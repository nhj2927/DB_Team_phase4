<%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 2021-11-29
  Time: 오후 5:41
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
    int itemID = Integer.parseInt(request.getParameter("it_id"));

    sql = "delete from item where it_id=?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, itemID);
    int result = pstmt.executeUpdate();

    conn.close();
    pstmt.close();
%>
<script>
    location.href="reportList"
</script>
