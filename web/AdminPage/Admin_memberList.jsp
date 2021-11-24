<%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 2021-11-23
  Time: 오후 8:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <!-- Bootstrap -->
    <!--<link type="text/css" rel="stylesheet" href="../Public/css/bootstrap.min.css"/>-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <!-- Font Awesome Icon -->
    <link rel="stylesheet" href="../Public/css/font-awesome.min.css">
    <!-- Custom stlylesheet -->
    <link type="text/css" rel="stylesheet" href="../Public/css/style.css"/>
    <title>HiAuction - 회원관리</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<jsp:include page="../Public/jsp/AdminHeader.jsp"></jsp:include>
<body>
<div class="container-fluid">
    <div class="row flex-nowrap">
        <jsp:include page="../Public/jsp/AdminSidebar.jsp"></jsp:include>
        <div class="col py-3">
            <br>
            <div class = "container">
                <h2>회원 관리</h2>
                <table class="table table-hover">
                    <thead class="thead-dark">
                    <tr>
                        <th>번호</th>
                        <th>이름</th>
                        <th>ID</th>
                        <th>신고된 횟수</th>
                    </tr>
                    </thead>
                    <tbody>
                        <tr class="clickable-member-row" style="cursor:pointer;">
                            <td>1</td>
                            <td>옥션이1</td>
                            <td>Auctioneee1</td>
                            <td>3</td>
                        </tr>
                        <tr class="clickable-member-row" style="cursor:pointer;">
                            <td>2</td>
                            <td>나쁜 옥션이2</td>
                            <td>badAutionee2</td>
                            <td>11</td>
                        </tr>
                        <tr class="clickable-member-row" style="cursor:pointer;">
                            <td>3</td>
                            <td>엄청 나쁜 옥션이3</td>
                            <td>verybadautione3</td>
                            <td>21</td>
                        </tr>
                    </tbody>
                </table>
                <br>
                <div class="text-center">
                    <ul class="reviews-pagination">
                        <li><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('.clickable-member-row').click(()=>{
        location.href='Admin_memberDetail.jsp'
    })
    $('.clickable-report-row').click(()=>{
        location.href='Admin_reportDetail.jsp'
    })
</script>
</body>
</html>
