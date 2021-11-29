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
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Context context = new InitialContext();
    DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
    Connection conn = dataSource.getConnection();
    String sql = "";
    PreparedStatement pstmt = null;
    String memberID = request.getParameter("u_id");

    sql = "delete from member where u_id=?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1,memberID);
    pstmt.executeUpdate();
    //삭제한 회원이 입찰한 아이템의 current price 변경하기

    sql = "select i.it_id, MAX(b.price)" +
            " from bid b, item i" +
            " where b.it_id = i.it_id AND i.Is_end = 0" +
            "                    AND b.u_id = ?" +
            " GROUP BY i.it_id";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, memberID);
    ResultSet rs = pstmt.executeQuery();

    while(rs.next()){
        sql = "UPDATE ITEM SET Current_price = ? WHERE it_id = ?";
        pstmt.setInt(1, rs.getInt(1));
        pstmt.setString(2, rs.getString(2));
        pstmt.executeUpdate();
    }
    pstmt.executeUpdate();

    conn.close();
    pstmt.close();
    rs.close();
%>
<script>
    location.href="memberList"
</script>
