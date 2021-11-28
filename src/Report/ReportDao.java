package Report;

import java.sql.*;
import java.util.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import Report.Paging.*;

public class ReportDao {
    private String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
    private String USER_NAME ="DBTeam7";
    private String USER_PASSWD ="comp322";
    private static ReportDao reportDao = null;

    Connection conn = null;
    ResultSet rs = null;
    PreparedStatement pstmt = null;

    public ReportDao(){
        try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    public static ReportDao getInstance(){
        if(reportDao == null){
            reportDao = new ReportDao();
        }
        return reportDao;
    }
    public ArrayList<Report> selectAllMember(Paging paging){
        //1번 페이지 1~10
        //2번 페이지 11~20
        int startNum = paging.getStartNum();
        int endNum = paging.getEndNum();

        String sql = "SELECT * FROM ("
                + "SELECT * FROM ("
                + "SELECT ROWNUM row_num, report.* FROM report"
                + ") WHERE row_num >= ?"
                + ") WHERE row_num <= ?";
        ArrayList<Report> list = new ArrayList<Report>();
        try{
            conn = DriverManager.getConnection(URL, USER_NAME, USER_PASSWD);
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, startNum);
            pstmt.setInt(2, endNum);
            rs = pstmt.executeQuery();
            while(rs.next()){
                Report vo = new Report();
                vo.setAdid(rs.getString("admin_id"));
                vo.setReportId(rs.getInt("report_id"));
                vo.setItid(rs.getInt("it_id"));
                vo.setUid(rs.getString("u_id"));
                vo.setDescription(rs.getString("description"));
                //vo.setDatetime(rs.getString("datetime"));
                //vo.setTitle(rs.getString("title"));
                list.add(vo);
            }
            rs.close();
            pstmt.close();
            conn.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
        return list;
    }
    public int getAllCount() {
        String sql = "SELECT COUNT(*) as count FROM report";
        int count = 0;
        try{
            conn = DriverManager.getConnection(URL, USER_NAME, USER_PASSWD);
            pstmt = conn.prepareStatement(sql);
            rs= pstmt.executeQuery();
            if(rs.next()){
                count = rs.getInt("count");
            }
            conn.close();
            pstmt.close();
            rs.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
        return count;
    }
}
