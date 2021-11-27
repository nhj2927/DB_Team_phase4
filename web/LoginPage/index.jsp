<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>
<html>
<head>
    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

    <!-- Bootstrap -->
    <link type="text/css" rel="stylesheet" href="../Public/css/bootstrap.min.css"/>

    <!-- Font Awesome Icon -->
    <link rel="stylesheet" href="../Public/css/font-awesome.min.css">

    <!-- Custom stlylesheet -->
    <link type="text/css" rel="stylesheet" href="../Public/css/style.css"/>
    <link rel="stylesheet" href="./style.css"/>

    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>Login</title>
</head>
<body>
<%
    String id = request.getParameter("id");
    String password = request.getParameter("password");
    String type = request.getParameter("type");

    if (id != null && password != null && type != null) {
        try {
            Context context = new InitialContext();
            DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
            conn = dataSource.getConnection();
            String sql = null;

            if (type.equals("admin")) {
                sql = "SELECT * FROM Admin"
                        + " WHERE Admin_id = ?"
                        + " AND pw = ?";
            } else {
                sql = "SELECT * FROM Member"
                        + " WHERE U_id = ?"
                        + " AND pw = ?";
            }
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                if (type.equals("admin")) {
                    session.setAttribute("id", rs.getString(1));
                    session.setAttribute("name", rs.getString(3));
                    response.sendRedirect("../AdminPage/index.jsp");
                } else {
                    session.setAttribute("id", rs.getString(1));
                    session.setAttribute("name", rs.getString(3));
                    session.setAttribute("description", rs.getString(4));
                    session.setAttribute("average_score", rs.getDouble(5));
                    session.setAttribute("tel", rs.getString(6));
                    session.setAttribute("email", rs.getString(7));

                    String u_id = rs.getString(1);
                    rs.close();
                    pstmt.close();
                    sql = "SELECT A.name FROM Address A, Lives_in L"
                            + " WHERE L.ad_id = A.ad_id"
                            + " AND L.u_id = ?";

                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, u_id);
                    rs = pstmt.executeQuery();
                    ArrayList addressList = new ArrayList<String>();

                    while (rs.next()){
                        addressList.add(rs.getString(1));
                    }
                    session.setAttribute("address", addressList.toArray(new String[0]));
                    response.sendRedirect("../");
                }
            } else { %>
<script>
    alert("로그인 실패");
    location.href = "./";
</script>
<% }
} catch (Exception e) {
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
} else { %>
<div class="container">
    <div class="card card-container">
        <img id="profile-img" class="profile-img-card" src="//ssl.gstatic.com/accounts/ui/avatar_2x.png"/>
        <p id="profile-name" class="profile-name-card"></p>
        <form class="form-signin" action='./' method="post">
            <span id="reauth-email" class="reauth-email"></span>
            <input type="text" id="inputId" name="id" class="form-control" placeholder="Id" required autofocus>
            <input type="password" id="inputPassword" name="password" class="form-control" placeholder="Password"
                   required>
            <input type="hidden" id="userType" name="type">
            <button class="btn btn-lg btn-primary btn-block btn-signin user" type="submit">유저 로그인</button>
            <button class="btn btn-lg btn-primary btn-block btn-signin admin" type="submit">관리자 로그인</button>
        </form>
        <button class="btn btn-lg btn-primary btn-block btn-register">회원가입</button>
    </div>
</div>
<script>
    $('.admin').click((e) => {
        e.preventDefault();
        $("#userType").val("admin");
        $(".form-signin").submit();
    });
    $('.user').click((e) => {
        e.preventDefault();
        $("#userType").val("user");
        $(".form-signin").submit();
    });
    $('.btn-register').click(() => {
        location.href = "/DB_Team_phase4_war_exploded/RegisterPage";
    });
</script>
<% } %>
</body>
</html>
