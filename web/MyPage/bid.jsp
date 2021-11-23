<%--
  Created by IntelliJ IDEA.
  User: dydal
  Date: 2021-11-23
  Time: 오후 10:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

    <%--    <!-- Bootstrap -->--%>
    <link type="text/css" rel="stylesheet" href="../Public/css/bootstrap.min.css"/>

    <!-- Slick -->
    <link type="text/css" rel="stylesheet" href="../Public/css/slick.css"/>
    <link type="text/css" rel="stylesheet" href="./Public/css/slick-theme.css"/>

    <!-- nouislider -->
    <link type="text/css" rel="stylesheet" href="../Public/css/nouislider.min.css"/>

    <!-- Font Awesome Icon -->
    <link rel="stylesheet" href="../Public/css/font-awesome.min.css">

    <!-- Custom stlylesheet -->
    <link type="text/css" rel="stylesheet" href="../Public/css/style.css"/>
    <title>HiAuction - 내 입찰 목록</title>
    <link type="text/css" rel="stylesheet" href="../Public/css/MyPage_Main.css">
</head>
<body>
<jsp:include page="../Public/jsp/Header.jsp"></jsp:include>
<div class="MyPageBox">
    <div class="MyPageTopBar">
        <div class="MyPageTopBar_Logo">

        </div>
        <div class="MyPageTopBar_info">
            <div class="MyPage_info_comp" >
                <div class="mpage_comp_head">
                    내 입찰
                </div>
                <div class="mpage_comp_content">
                    7<div class="gun">건</div>
                </div>

            </div>
            <div class="MyPage_info_comp">
                <div class="mpage_comp_head">
                    내 등록 상품
                </div>
                <div class="mpage_comp_content">
                    8<div class="gun">건</div>
                </div>
            </div>
            <div class="MyPage_info_comp">
                <div class="mpage_comp_head">
                    내 후기
                </div>
                <div class="mpage_comp_content">
                    3<div class="gun">건</div>
                </div>
            </div>
        </div>
    </div>
    <div class="MyPageContent">
        <div class="MyPageSideBar">
            <div class="side-content">
                <div class="side-title"><a href="#">내 입찰 목록</a></div>
                <div class="side-body"><a href="#">낙찰 완료</a> </div>
                <div class="side-body"><a href="#">후기 작성 필요</a> </div>
                <div class="side-body"><a href="#">거래 완료</a> </div>
            </div>
            <div class="side-content">
                <div class="side-title"><a href="#">내 등록 상품</a></div>
                <div class="side-body"><a href="#">낙찰 완료</a> </div>
                <div class="side-body"><a href="#">후기 작성 필요</a> </div>
                <div class="side-body"><a href="#">거래 완료</a> </div>
            </div>
            <div class="side-content">
                <div class="side-title"><a href="#">내 후기</a></div>
                <div class="side-body"><a href="#">낙찰 완료</a> </div>
                <div class="side-body"><a href="#">후기 작성 필요</a> </div>
                <div class="side-body"><a href="#">거래 완료</a> </div>
            </div>
            <div class="side-content">
                <div class="side-title"><a href="#">회원정보 수정</a></div>
            </div>
        </div>
        <div class="MyPageBody" >
            <div class="MyPage_RealBody">
                <div class="MyPageBody_title">
                    <div class="mpb_Title">내 입찰 목록</div>
                    <a class="more_button" href="#">더보기</a>
                </div>
                <div class="MyPageBody_content">
                    <div class="cardBox">
                        <div class="bid-card card row-flex spb">
                            <div class="bid-left col-flex spb">
                                <div class="bid-GoodFinishDate">2021.11.25 낙찰</div>
                                <div class="bid-content row-flex">
                                    <img class="card-img" height="100px" width="100px" src="#">
                                    <div class="bid-body col-flex">
                                        <div class="card-title">Nike air Jordon</div>
                                        <div class="card-address">대구광역시 북구 복현동</div>
                                        <div class="bid-review-button btn-default btn">후기 작성하기</div>
                                    </div>
                                </div>
                            </div>
                            <div class="bid-right col-flex spb">
                                <div class="bid-alarm-review alarm ">후기<br>작성 필요</div>
                                <div class="price">770000원</div>
                            </div>
                        </div>
                        <div class="bid-card card row-flex spb">
                            <div class="bid-left col-flex spb">
                                <div class="bid-GoodFinishDate">2021.11.25 낙찰</div>
                                <div class="bid-content row-flex">
                                    <img class="card-img" height="100px" width="100px" src="#">
                                    <div class="bid-body col-flex">
                                        <div class="card-title">Nike air Jordon</div>
                                        <div class="card-address">대구광역시 북구 복현동</div>
                                        <div class="bid-review-button btn-default btn">후기 작성하기</div>
                                    </div>
                                </div>
                            </div>
                            <div class="bid-right col-flex spb">
                                <div class="bid-alarm-review alarm ">후기<br>작성 필요</div>
                                <div class="price">770000원</div>
                            </div>
                        </div>
                        <div class="bid-card card row-flex spb">
                            <div class="bid-left col-flex spb">
                                <div class="bid-GoodFinishDate">2021.11.25 낙찰</div>
                                <div class="bid-content row-flex">
                                    <img class="card-img" height="100px" width="100px" src="#">
                                    <div class="bid-body col-flex">
                                        <div class="card-title">Nike air Jordon</div>
                                        <div class="card-address">대구광역시 북구 복현동</div>
                                        <div class="bid-review-button btn-default btn">후기 작성하기</div>
                                    </div>
                                </div>
                            </div>
                            <div class="bid-right col-flex spb">
                                <div class="bid-alarm-review alarm ">후기<br>작성 필요</div>
                                <div class="price">770000원</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
