<%--
  Created by IntelliJ IDEA.
  User: dydal
  Date: 2021-11-28
  Time: 오후 9:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="sun.security.krb5.internal.crypto.Des" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    request.setCharacterEncoding("utf-8");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ResultSet rs2 = null;
    String sql = null;
    if (session.getAttribute("id") == null){
        response.sendRedirect("../LoginPage/");
    }
    else {
        try {
            Context context = new InitialContext();
            DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
            conn = dataSource.getConnection();
        } catch (SQLException e){
            e.printStackTrace();
        }
        System.out.println(request.getRequestURL());
        String id = (String) session.getAttribute("id");
        String type = request.getParameter("type");
        if (type.equals("enroll")){
            System.out.println("=========================================");
            String star = request.getParameter("star");
            String reviewText = request.getParameter("reviewText");
            String item_uid = request.getParameter("itemUID");
            String item_id = request.getParameter("itemID");
            System.out.println(item_uid + " | " + star + " | " + reviewText);
            sql = "INSERT INTO RATING VALUES(?, SEQ_RATING.NEXTVAL, ?, ?, ?)";
            try {
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, item_uid);
                pstmt.setString(2, id);
                pstmt.setFloat(3, Float.parseFloat(star) - 0.5f);
                pstmt.setString(4, reviewText);
                int count = pstmt.executeUpdate();
                if (count < 1){
                    System.out.println("삽입 실패");
                }
                sql = "UPDATE ITEM SET is_end = '4' WHERE it_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(item_id));
                count = pstmt.executeUpdate();
                if (count < 1){
                    System.out.println("상태 변경 실패");
                }
            } catch (SQLException e){
                e.printStackTrace();
            } finally {
                if (conn != null) {
                    conn.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (rs != null) {
                    rs.close();
                }
            }
            String referer = (String)request.getHeader("REFERER");
            response.sendRedirect(referer);
        } else if (type.equals("modify")){

        }
    }
%>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
