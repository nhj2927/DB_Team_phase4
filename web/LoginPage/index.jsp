<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.xml.crypto.Data" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%--%>
<%--    Context context = new InitialContext();--%>
<%--    DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");--%>
<%--    Connection conn = dataSource.getConnection();--%>

<%--    String sql = "select * from Member";--%>
<%--    PreparedStatement pstmt = conn.prepareStatement(sql);--%>
<%--    ResultSet res = pstmt.executeQuery();--%>
<%--    while(res.next()){--%>
<%--        System.out.println(res.getString(1));--%>
<%--    }--%>
<%--%>--%>
<%
    String a = "1234";
%>
<html>
<head>
    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

    <!-- Bootstrap -->
    <link type="text/css" rel="stylesheet" href="../Public/css/bootstrap.min.css"/>

    <!-- Slick -->
    <link type="text/css" rel="stylesheet" href="../Public/css/slick.css"/>
    <link type="text/css" rel="stylesheet" href="../Public/css/slick-theme.css"/>

    <!-- nouislider -->
    <link type="text/css" rel="stylesheet" href="../Public/css/nouislider.min.css"/>

    <!-- Font Awesome Icon -->
    <link rel="stylesheet" href="../Public/css/font-awesome.min.css">

    <!-- Custom stlylesheet -->
    <link type="text/css" rel="stylesheet" href="../Public/css/style.css"/>
    <link rel="stylesheet" href="./style.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>Title</title>
</head>
<body>
    <div class="container">
        <div class="card card-container">
            <!-- <img class="profile-img-card" src="//lh3.googleusercontent.com/-6V8xOA6M7BA/AAAAAAAAAAI/AAAAAAAAAAA/rzlHcD0KYwo/photo.jpg?sz=120" alt="" /> -->
            <img id="profile-img" class="profile-img-card" src="//ssl.gstatic.com/accounts/ui/avatar_2x.png" />
            <p id="profile-name" class="profile-name-card"></p>
            <form class="form-signin">
                <span id="reauth-email" class="reauth-email"></span>
                <input type="email" id="inputEmail" class="form-control" placeholder="Email address" required autofocus>
                <input type="password" id="inputPassword" class="form-control" placeholder="Password" required>
                <button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">로그인</button>
            </form><!-- /form -->
            <button class="btn btn-lg btn-primary btn-block btn-register">회원가입</button>
        </div><!-- /card-container -->
    </div>
</body>
<script>
    $('.btn-signin').click((e)=>{
        e.preventDefault();
        //location.href = "/DB_Team_phase4_war_exploded/RegisterPage";
        console.log('<%=a%>')
    })
    $('.btn-register').click(()=>{
        location.href = "/DB_Team_phase4_war_exploded/RegisterPage";
    });
</script>
</html>
