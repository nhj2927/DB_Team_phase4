<%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 2021-11-29
  Time: 오후 9:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vo.Report"%>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Context context = new InitialContext();
    DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
    Connection conn = dataSource.getConnection();
    String sql = "";
    PreparedStatement pstmt = null;

    request.setCharacterEncoding("euc-kr");
    String adminID = request.getParameter("AdminID");
    String adminPW = request.getParameter("AdminPW");
    String adminName = request.getParameter("AdminName");

    try{
        sql = "insert into admin values (?,?,?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1,adminID);
        pstmt.setString(2,adminPW);
        pstmt.setString(3,adminName);
        pstmt.executeUpdate();
    }catch (SQLException e){
        System.err.println(e.getErrorCode());
    }finally {
        pstmt.close();
        conn.close();
    }
%>
<script>
    location.href="index.jsp"
</script>