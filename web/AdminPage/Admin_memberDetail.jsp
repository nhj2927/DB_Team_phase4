<%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 2021-11-23
  Time: 오후 8:35
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
    <link type="text/css" rel="stylesheet" href="../Public/css/modiUser.css">
    <title>HiAuction - 회원 상세</title>
</head>
<jsp:include page="../Public/jsp/AdminHeader.jsp"></jsp:include>
<body>
    <div class="container-fluid">
        <div class="row flex-nowrap">
            <jsp:include page="../Public/jsp/AdminSidebar.jsp"></jsp:include>
            <div class="col py-3" style="padding: 20vh">
                <br>
                <h2 class="fw-bolder mb-1">회원 상세정보</h2>
                <hr/>
                <!--modibox-->
                <div class="modiBox" style="font-size: 20px">
                    <table class="table table-striped modiUser_table" >
                        <tr>
                            <td class="detail-name">아이디</td>
                            <td>
                                <span class="inline-message detail-value">KimKim</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="detail-name">이름</td>
                            <td>
                                <span class="inline-message detail-value">홍길동</span>
                            </td>
                        </tr>

                        <tr>
                            <td class="detail-name">이메일</td>
                            <td>
                                <span class="inline-message detail-value" >kimkim@gmail.com</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="detail-name">닉네임</td>
                            <td>
                                <span class="inline-message detail-value">경매하자</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="detail-name">휴대폰 번호</td>
                            <td>
                                <span class="inline-message detail-value" style="display: inline-block; width: 200px">01011112222</span>
                            </td>
                        </tr>

                        <tr>
                            <td class="detail-name">거래지역</td>

                            <td>
                                <span class="detail-value">
                                    대현동 | 복현동 | 산격동
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td class="detail-name">한줄 소개</td>
                            <td>
                                <span class="detail-value">
                                    안녕하세요 처음 가입했는데, 잘 부탁드려요
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td class="detail-name">신고된 횟수</td>
                            <td class="detail-value">12</td>
                        </tr>
                    </table>
                </div>
                <!--modibox-->
                <hr/>
                <!-- Buttons -->
                <div>
                    <button class="btn btn-danger">회원 삭제</button>
                    <button class="btn btn-secondary" onclick="history.back()">뒤로 가기</button>
                </div>
                <!-- Buttons -->
            </div>

        </div>

    </div>
</body>
</html>
