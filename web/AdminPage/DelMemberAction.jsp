<%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 2021-11-29
  Time: 오후 7:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Context context = new InitialContext();
    DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
    Connection conn = dataSource.getConnection();
    String sql = "";
    ResultSet rs = null;
    String memberID = request.getParameter("u_id");

//    삭제한 회원이 입찰한 아이템의 current price 변경하기
//    item에 bid가 삭제할 회원의 bid밖에 없는 경우 현재가를 시작가로
    sql="with tmp as( " +
            "    select distinct i.it_id as itid, i.start_price as sp " +
            "    from item i, bid b " +
            "    where i.it_id=b.it_id " +
            "    and i.is_end=0 " +
            "    and b.u_id=?) " +
            "select tmp.itid as itemID, tmp.sp as startPrice " +
            "from tmp, bid b " +
            "where not exists( " +
            "    select * " +
            "    from bid " +
            "    where bid.it_id = tmp.itid " +
            "    and (bid.u_id !=? or bid.u_id is not null)";
    PreparedStatement pstmt1=conn.prepareStatement(sql);
    pstmt1.setString(1,memberID);
    pstmt1.setString(2,memberID);
    rs = pstmt1.executeQuery();

    sql = "UPDATE ITEM SET Current_price = ? WHERE it_id = ?";
    PreparedStatement pstmt2 = conn.prepareStatement(sql);
    try{
        while(rs.next()){
            pstmt2.setInt(1, rs.getInt(2));
            pstmt2.setInt(2, rs.getInt(1));
            pstmt2.addBatch();
            pstmt2.clearParameters();
        }
        pstmt2.executeBatch();
    }catch (SQLException e){
        e.printStackTrace();
    }finally {
        pstmt1.close();
        rs.close();
        pstmt2.close();
    }

    //item에 bid가 삭제할 회원의 bid말고도 더 있는경우
    sql = "with tmp as( " +
            "    select distinct i.it_id as itid" +
            "    from item i , bid b " +
            "    where i.it_id = b.it_id " +
            "    and i.is_end=0 "+
            "    and b.u_id = ?) " +
            "select MAX(b.price) , tmp.itid " +
            "from tmp, bid b " +
            "where tmp.itid=b.it_id " +
            "and b.u_id != ? " +
            "and b.u_id is not null " +
            "and b.it_id is not null " +
            "group by tmp.itid";
    PreparedStatement pstmt3 = conn.prepareStatement(sql);
    pstmt3.setString(1, memberID);
    pstmt3.setString(2, memberID);
    rs = pstmt3.executeQuery();

    sql = "UPDATE ITEM SET Current_price = ? WHERE it_id = ?";
    PreparedStatement pstmt4 = conn.prepareStatement(sql);
    try{
        while(rs.next()){
            pstmt4.setInt(1, rs.getInt(1));
            pstmt4.setInt(2, rs.getInt(2));
            pstmt4.addBatch();
            pstmt4.clearParameters();
        }
        pstmt4.executeBatch();
    }catch (SQLException e){
        e.printStackTrace();
    }finally {
        pstmt3.close();
        rs.close();
        pstmt4.close();
    }

    //회원 삭제
    sql = "delete from member where u_id=?";
    PreparedStatement pstmt5 = conn.prepareStatement(sql);
    pstmt5.setString(1, memberID);
    pstmt5.executeUpdate();

    conn.close();
    pstmt5.close();
%>
<script>
    location.href="memberList"
</script>
