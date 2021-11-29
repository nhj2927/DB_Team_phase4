package dao;

import java.sql.*;
import java.util.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import vo.Member;
import vo.Paging;

public class MemberDao {
    private String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
    private String USER_NAME ="DBTeam7";
    private String USER_PASSWD ="comp322";
    private static MemberDao memberDao = null;

    Connection conn = null;
    ResultSet rs = null;
    PreparedStatement pstmt = null;

    public MemberDao(){
        try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    public static MemberDao getInstance(){
        if(memberDao == null){
            memberDao = new MemberDao();
        }
        return memberDao;
    }
    public ArrayList<Member> selectAllMember(Paging paging){
        //1번 페이지 1~10
        //2번 페이지 11~20
        int startNum = paging.getStartNum();
        int endNum = paging.getEndNum();

        String sql = "with reported_num as( " +
                "    select m.u_id as ruid, count(*) as rnum " +
                "    from member m, report r " +
                "    where m.u_id=r.u_id " +
                "    group by m.u_id) " +
                "SELECT * " +
                "FROM (SELECT ROWNUM row_num, member.* FROM member) rmem left outer join reported_num rnum " +
                "on rmem.u_id=rnum.ruid " +
                "WHERE rmem.row_num >= ? and rmem.row_num<? ";

        //나중에 order by datetime으로 바꾸기
        ArrayList<Member> list = new ArrayList<Member>();
        try{
            conn = DriverManager.getConnection(URL, USER_NAME, USER_PASSWD);
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, startNum);
            pstmt.setInt(2, endNum);
            rs = pstmt.executeQuery();
            while(rs.next()){
                Integer reportnum = rs.getInt("rnum");
                Member vo = new Member();
                vo.setU_id(rs.getString("u_id"));
                vo.setPw(rs.getString("pw"));
                vo.setName(rs.getString("name"));
                vo.setEmail(rs.getString("email"));
                vo.setAverage_score(rs.getInt("average_score"));
                vo.setTel(rs.getString("tel"));
                if(reportnum == null){
                    vo.setReported_num(0);
                }else{
                    vo.setReported_num(reportnum);
                }
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
        String sql = "SELECT COUNT(*) as count FROM member";
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
