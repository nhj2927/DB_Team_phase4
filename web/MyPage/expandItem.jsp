<%--
  Created by IntelliJ IDEA.
  User: dydal
  Date: 2021-11-29
  Time: 오후 9:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Context context = new InitialContext();
    DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
    Connection conn = dataSource.getConnection();
    String sql = "";
    PreparedStatement pstmt = null;
    int itemID = Integer.parseInt(request.getParameter("it_id"));
    String expireDate = request.getParameter("expandDate");

    sql = "UPDATE ITEM SET expire_date = ?, is_end = '0' WHERE it_id = ?";
    try {
        pstmt = conn.prepareStatement(sql);
        pstmt.setDate(1, Date.valueOf(expireDate));
        pstmt.setInt(2, itemID);
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

