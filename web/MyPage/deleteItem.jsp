<%--
  Created by IntelliJ IDEA.
  User: dydal
  Date: 2021-11-29
  Time: 오후 8:46
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
    PreparedStatement pstmt = null;
    int itemID = Integer.parseInt(request.getParameter("it_id"));

    sql = "delete from item where it_id=?";
    try {
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, itemID);
        int result = pstmt.executeUpdate();
    } catch (SQLException e){
        e.printStackTrace();
    } finally {
        if (conn != null) {
            conn.close();
        }
        if (pstmt != null) {
            pstmt.close();
        }
    }
    String referer = (String)request.getHeader("REFERER");
    response.sendRedirect(referer);
%>
