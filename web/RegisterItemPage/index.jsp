<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" integrity="sha512-mSYUmp1HYZDFaVKK//63EcZq4iFWFjxSL+Z3T/aCt4IO9Cejm03q3NKKYN6pFQzY0SBOr8h+eCIAZHPXcpZaNw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

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

    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
    <title>Register</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    String[] category_name = {"디지털기기", "생활가전", "가구/인테리어", "유아동", "생활/가공식품",
            "유아도서", "스포츠/레저", "여성잡화", "여성의류", "남성패션/잡화",
            "게임/취미", "뷰티/미용", "반려동물", "도서/티켓/음반", "식물"};
    String id = (String) session.getAttribute("id");

    if (id == null) {
        response.sendRedirect(".../LoginPage");
    } else {
        String[] addressList = (String[]) session.getAttribute("address");
%>
<jsp:include page="../Public/jsp/Header.jsp"></jsp:include>
<div class="container-fluid">
    <div class="border form-wrapper">
        <h3 class="mb-4">물품 등록</h3>
        <form class="form-item-register" action="../Service/registerItem.jsp" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="inputName" class="form-label">물품명</label>
                <input type="text" class="form-control" name="name" id="inputName"/>
            </div>
            <div class="mb-3">
                <label for="inputDescription" class="form-label">설명</label>
                <textarea id="inputDescription" class="form-control" name="description" rows="10"></textarea>
            </div>
            <div class="mb-3">
                <label for="inputMin" class="form-label">최소 입찰 단위(원)</label>
                <input type="text" class="form-control" name="min" id="inputMin"/>
            </div>
            <div class="mb-3">
                <label for="inputStart" class="form-label">시작가(원)</label>
                <input type="text" class="form-control" name="start" id="inputStart">
            </div>
            <div class="mb-3">
                <label for="inputQuick" class="form-label">즉시 구매가(원)</label>
                <input type="text" class="form-control" name="quick" id="inputQuick">
            </div>
            <div class="mb-3">
                <label for="expired" class="form-label">만료 날짜</label>
                <input type="text" class="form-control datepicker" name="expired"  id="expired" readonly>
            </div>
            <div class="mb-3">
                <label for="formFile" class="form-label">이미지</label>
                <input class="form-control" name="image" type="file" id="formFile">
            </div>
            <div class="mb-3">
                <label for="address-select" class="form-label">동네</label>
                <select id="address-select" name="address" class="form-select" aria-label="Default select example">
                    <% for (int i = 0; i < addressList.length; i++) { %>
                    <option value="<%=addressList[i]%>">
                        <%=addressList[i]%>
                    </option>
                    <% } %>
                </select>
            </div>
            <div class="mb-3">
                <label for="category-select" class="form-label">카테고리</label>
                <select id="category-select" name="c_id" class="form-select" aria-label="Default select example">
                    <% for (int i = 0; i < category_name.length; i++) { %>
                    <option value="<%=i+1%>">
                        <%=category_name[i]%>
                    </option>
                    <% } %>
                </select>
            </div>
            <button class="register btn btn-primary">물품등록</button>
        </form>
    </div>
</div>
<% } %>
<script>
    $('.register').click((e) => {
        e.preventDefault();
        $('.form-item-register').submit();
    })
    $('.datepicker').datepicker({
        format: "yyyy-mm-dd",
        startDate: '+1d',
        autoclose : true,
        calendarWeeks : false,
        clearBtn : false,
        immediateUpdates: false,
        multidate : false,
        templates : {
            leftArrow: '&laquo;',
            rightArrow: '&raquo;'
        },
        showWeekDays : true,
        todayHighlight : true,
        toggleActive : true,
        weekStart : 0 ,
    });
</script>
</body>
</html>
