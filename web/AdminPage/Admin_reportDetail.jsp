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
    <title>HiAuction - 신고 내용</title>
</head>
<jsp:include page="../Public/jsp/AdminHeader.jsp"></jsp:include>
<body>
<div class="container-fluid">
    <div class="row flex-nowrap">
        <jsp:include page="../Public/jsp/AdminSidebar.jsp"></jsp:include>
        <div class="col py-3">
            <br>
            <div class="container-sm">
                <article>
                    <!-- Post header-->
                    <header class="mb-4">
                        <!-- Post title-->
                        <h2 class="fw-bolder mb-1">이건 좀 아닌것 같습니다.</h2>
                        <!-- Post meta content-->
                        <div class="text-muted mb-2" style="background: #f2f2f2">
                            <h6>신고자</h6>
                        </div>
                        <!-- Post categories-->
                    </header>
                    <!-- Post content-->
                    <section class="mb-5">
                        <p class="fs-5 mb-4">
                             분명히 어제 만나서 거래하기로 했는데 약속장소에 안 나타납니다. 조치 취해주세요.
                        </p>

                    </section>
                </article>
                <div>
                    <button class="btn btn-primary">게시글 확인</button>
                    <button class="btn btn-danger">리포트 삭제</button>
                    <button class="btn btn-danger">게시글 삭제</button>
                </div>
            </div>
        </div>
    </div>

</div>
</body>
</html>
