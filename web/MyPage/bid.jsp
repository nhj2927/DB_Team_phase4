<%--
  Created by IntelliJ IDEA.
  User: dydal
  Date: 2021-11-23
  Time: 오후 10:09
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
    } else {

%>
<html>
<head>
    <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">--%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

    <%--    <!-- Bootstrap -->--%>
<%--    <link type="text/css" rel="stylesheet" href="../Public/css/bootstrap.min.css"/>--%>

    <!-- Slick -->
    <link type="text/css" rel="stylesheet" href="../Public/css/slick.css"/>
    <link type="text/css" rel="stylesheet" href="./Public/css/slick-theme.css"/>

    <!-- nouislider -->
    <link type="text/css" rel="stylesheet" href="../Public/css/nouislider.min.css"/>

    <!-- Font Awesome Icon -->
    <link rel="stylesheet" href="../Public/css/font-awesome.min.css">

    <!-- Custom stlylesheet -->
    <link type="text/css" rel="stylesheet" href="../Public/css/style.css"/>
    <link type="text/css" rel="stylesheet" href="../Public/css/MyPage_Main.css">
    <title>HiAuction - 내 입찰 목록</title>
    <link type="text/css" rel="stylesheet" href="./review.css"/>
</head>
<body>
<jsp:include page="../Public/jsp/Header.jsp"></jsp:include>
<div class="MyPageBox">
    <div class="MyPageTopBar">
        <div class="MyPageTopBar_Logo" onclick="location.href='index.jsp'">
            <div style="text-align: center; font-size: 1.8rem;font-weight: bold;color:white;margin-top:1.3rem">MY HIAuction</div>
        </div>
        <%
            try {
                Context context = new InitialContext();
                DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
                conn = dataSource.getConnection();
            } catch (SQLException e){
                e.printStackTrace();
            }
            String id = (String) session.getAttribute("id");
            int bidCount = 0;
            int itemCount = 0;
            int ratingCount = 0;
            sql = "select count(*) from bid where u_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            try{
                rs = pstmt.executeQuery();
                rs.next();
                bidCount = rs.getInt(1);
            } catch (SQLException e){
                e.printStackTrace();
            }
            sql = "select count(*) from item where u_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            try{
                rs = pstmt.executeQuery();
                rs.next();
                itemCount = rs.getInt(1);
            } catch (SQLException e){
                e.printStackTrace();
            }
            sql = "select count(*) from rating where buy_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            try{
                rs = pstmt.executeQuery();
                rs.next();
                ratingCount = rs.getInt(1);
            } catch (SQLException e){
                e.printStackTrace();
            } finally {
                if (conn != null) {
                    System.out.println("=======connection 종료===========");
                    conn.close();
                }
                if (pstmt != null) {
                    System.out.println("=======prepared statement 종료===========");
                    pstmt.close();
                }
                if (rs != null) {
                    System.out.println("=======resultSet 종료===========");
                    rs.close();
                }
            }
        %>
        <div class="MyPageTopBar_info">
            <div class="MyPage_info_comp" >
                <div class="mpage_comp_head">
                    내 입찰
                </div>
                <div class="mpage_comp_content">
                    <%=bidCount%><div class="gun">건</div>
                </div>

            </div>
            <div class="MyPage_info_comp">
                <div class="mpage_comp_head">
                    내 등록 상품
                </div>
                <div class="mpage_comp_content">
                    <%=itemCount%><div class="gun">건</div>
                </div>
            </div>
            <div class="MyPage_info_comp">
                <div class="mpage_comp_head">
                    내 후기
                </div>
                <div class="mpage_comp_content">
                    <%=ratingCount%><div class="gun">건</div>
                </div>
            </div>
        </div>
    </div>
    <div class="MyPageContent">
        <div class="MyPageSideBar">
            <div class="side-content">
                <div class="side-title"><a href="bid.jsp">내 입찰 목록</a></div>
            </div>
            <div class="side-content">
                <div class="side-title"><a href="items.jsp">내 등록 상품</a></div>
            </div>
            <div class="side-content">
                <div class="side-title"><a href="modify_User.jsp">회원정보 수정</a></div>
            </div>
        </div>
        <div class="MyPageBody" >
            <div class="MyPage_RealBody">
                <div class="MyPageBody_title">
                    <div class="mpb_Title">내 입찰 목록</div>
                </div>
                <div class="MyPageBody_content">
                    <div class="cardBox">
                        <%
                            id = (String) session.getAttribute("id");
                            try {
                                Context context = new InitialContext();
                                DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
                                conn = dataSource.getConnection();
                            } catch (SQLException e){
                                e.printStackTrace();
                            }
                            sql = "select * from (select rownum as num, b_id, price, create_date, u_id, it_id from bid b WHERE b.u_id = ?) a " +
//                                    "where a.num BETWEEN 1 and 3 \n"
                                    "ORDER BY a.create_date DESC";
                            pstmt = conn.prepareStatement(sql);
                            pstmt.setString(1, id);
                            try {
                                rs = pstmt.executeQuery();
                                while(rs.next()){
                                    sql = "SELECT * FROM ITEM i , ADDRESS a WHERE i.It_id = ? AND i.ad_id = a.ad_id";
                                    pstmt = conn.prepareStatement(sql);
                                    pstmt.setInt(1, rs.getInt(6));
                                    rs2 = pstmt.executeQuery();

                                    while(rs2.next()){
                                        if (rs2.getString(8).equals("0")){ //경매 진행중
                                        %>
                                            <div class="bid-card card row-flex spb">
                                                <div class="bid-left col-flex spb">
                                                    <div class="bid-GoodFinishDate"><%=rs.getDate(4)%> 입찰</div>
                                                    <div class="bid-content row-flex">
                                                        <img class="card-img" height="100px" width="100px" src="../Service/downloadImage.jsp?it_id=<%=rs2.getInt(1)%>">
                                                        <div class="bid-body col-flex">
                                                            <div class="card-title"><%=rs2.getString(2)%></div>
                                                            <div class="card-address"><%=rs2.getString(18)%></div>
                                                            <div class="bid-review-button btn-secondary btn" onclick="location.href='../DetailPage/index.jsp?item_id=<%=rs2.getInt(1)%>'">상세보기</div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="bid-right col-flex spb">
                                                    <div class="item-alarm-onSale alarm ">판매중</div>
                                                    <div class="price">입찰가격 : <%=rs.getInt(3)%>원</div>
                                                </div>
                                            </div>
                                        <%
                                        } else if (rs2.getString(8).equals("1")){ //낙찰
                                        %>
                                            <div class="bid-card card row-flex spb">
                                                <div class="bid-left col-flex spb">
                                                    <div class="bid-GoodFinishDate"><%=rs2.getDate(9)%> 낙찰</div>
                                                    <div class="bid-content row-flex">
                                                        <img class="card-img" height="100px" width="100px" src="../Service/downloadImage.jsp?it_id=<%=rs2.getInt(1)%>">
                                                        <div class="bid-body col-flex">
                                                            <div class="card-title"><%=rs2.getString(2)%></div>
                                                            <div class="card-address"><%=rs2.getString(18)%></div>
                                                            <%
                                                                if (rs.getInt(3) == rs2.getInt(7)) {
                                                            %>
<%--                                                            <div class="bid-review-button btn-secondary btn" data-user="<%=rs2.getString(14)%>" data-bs-toggle="modal" data-bs-target="#reviewModal">판매자 정보보기</div>--%>
                                                            <form action="bid.jsp" method="post">
                                                                <input type="hidden" class="watchSeller" name="watchSeller">
                                                                <input type="hidden" class="seller_id" name="seller_id" value="<%=rs2.getString(14)%>">
                                                                <input type="submit" id="sellerSubmit" style="display: none">
                                                                <button class="bid-review-button btn-secondary btn" onclick="watchSellerInfo(this.form)">판매자정보</button>
                                                            </form>
                                                            <div class="bid-seller-modal-button btn-secondary btn" style="display: none" data-bs-toggle="modal" data-bs-target="#SellerInfoModal">판매자 정보보기</div>
                                                            <%
                                                            } else {
                                                            %>
                                                            <div class="bid-review-button btn-secondary btn" onclick="location.href='../DetailPage/index.jsp?item_id=<%=rs2.getInt(1)%>'">상세보기</div>
                                                            <%
                                                                }
                                                            %>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="bid-right col-flex spb">
                                                    <%
                                                        if (rs.getInt(3) == rs2.getInt(7)) {
                                                    %>
                                                    <div class="item-alarm-finish alarm ">낙찰완료</div>
                                                    <div class="price"><%=rs2.getInt(7)%>원</div>
                                                    <%
                                                    } else {
                                                    %>
                                                    <div class="item-alarm-finish alarm ">낙찰실패</div>
                                                    <div class="price">입찰가격 : <%=rs.getInt(3)%>원</div>
                                                    <%
                                                        }
                                                    %>
                                                </div>
                                            </div>
                                        <%
                                        } else if (rs2.getString(8).equals("2")) { //기간 만료
                                        %>
                                            <div class="bid-card card row-flex spb">
                                                <div class="bid-left col-flex spb">
                                                    <div class="bid-GoodFinishDate"><%=rs.getDate(4)%> 입찰</div>
                                                    <div class="bid-content row-flex">
                                                        <img class="card-img" height="100px" width="100px" src="../Service/downloadImage.jsp?it_id=<%=rs2.getInt(1)%>">
                                                        <div class="bid-body col-flex">
                                                            <div class="card-title"><%=rs2.getString(2)%></div>
                                                            <div class="card-address"><%=rs2.getString(18)%></div>
                                                            <div class="bid-review-button btn-secondary btn" onclick="location.href='../DetailPage/index.jsp?item_id=<%=rs2.getInt(1)%>'">상세보기</div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="bid-right col-flex spb">
                                                    <div class="item-alarm-expired alarm ">기간만료</div>
                                                    <div class="price">입찰가격 : <%=rs.getInt(3)%>원</div>
                                                </div>
                                            </div>
                                        <%
                                        }else if (rs2.getString(8).equals("3")){ //후기 작성 필요
                                        %>
                                            <div class="bid-card card row-flex spb">
                                                <div class="bid-left col-flex spb">
                                                    <div class="bid-GoodFinishDate"><%=rs2.getDate(9)%> 낙찰</div>
                                                    <div class="bid-content row-flex">
                                                        <img class="card-img" height="100px" width="100px" src="../Service/downloadImage.jsp?it_id=<%=rs2.getInt(1)%>">
                                                        <div class="bid-body col-flex">
                                                            <div class="card-title"><%=rs2.getString(2)%></div>
                                                            <div class="card-address"><%=rs2.getString(18)%></div>
                                                            <%
                                                                if (rs.getInt(3) == rs2.getInt(7)) {
                                                                    System.out.println(rs2.getString(14));
                                                                    //data-item="rs2.getInt(1)"
                                                            %>
                                                            <div class="bid-review-button btn-secondary btn" data-item="<%=rs2.getString(14)%>,<%=rs2.getInt(1)%>" data-bs-toggle="modal" data-bs-target="#reviewModal">후기 작성하기</div>
                                                            <%
                                                            } else {
                                                            %>
                                                            <div class="bid-review-button btn-secondary btn" onclick="location.href='../DetailPage/index.jsp?item_id=<%=rs2.getInt(1)%>'">상세보기</div>
                                                            <%
                                                                }
                                                            %>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="bid-right col-flex spb">
                                                    <%
                                                        if (rs.getInt(3) == rs2.getInt(7)) {
                                                            %>
                                                                <div class="bid-alarm-review alarm ">후기<br>작성 필요</div>
                                                                <div class="price"><%=rs2.getInt(7)%>원</div>
                                                            <%
                                                        } else {
                                                            %>
                                                                <div class="item-alarm-finish alarm ">낙찰실패</div>
                                                                <div class="price">입찰가격 : <%=rs.getInt(3)%>원</div>
                                                            <%
                                                        }
                                                    %>
                                                </div>
                                            </div>
                                        <%
                                        } else if (rs2.getString(8).equals("4")){ //거래완료
                                        %>
                                            <div class="bid-card card row-flex spb">
                                                <div class="bid-left col-flex spb">
                                                    <div class="bid-GoodFinishDate"><%=rs2.getDate(9)%> 낙찰</div>
                                                    <div class="bid-content row-flex">
                                                        <img class="card-img" height="100px" width="100px" src="../Service/downloadImage.jsp?it_id=<%=rs2.getInt(1)%>">
                                                        <div class="bid-body col-flex">
                                                            <div class="card-title"><%=rs2.getString(2)%></div>
                                                            <div class="card-address"><%=rs2.getString(18)%></div>
                                                            <div class="bid-review-button btn-secondary btn" onclick="location.href='../DetailPage/index.jsp?item_id=<%=rs2.getInt(1)%>'">상세보기</div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="bid-right col-flex spb">
                                                    <%
                                                        if (rs.getInt(3) == rs2.getInt(7)) {
                                                    %>
                                                    <div class="item-alarm-finish alarm ">거래완료</div>
                                                    <div class="price"><%=rs2.getInt(7)%>원</div>
                                                    <%
                                                    } else {
                                                    %>
                                                    <div class="item-alarm-finish alarm ">낙찰실패</div>
                                                    <div class="price">입찰가격 : <%=rs.getInt(3)%>원</div>
                                                    <%
                                                        }
                                                    %>
                                                </div>
                                            </div>
                                        <%
                                        }

                                    }
                                }
                            } catch (SQLException e){
                                e.printStackTrace();
                            } finally {
                                if (conn != null) {
                                    System.out.println("=======connection 종료===========");
                                    conn.close();
                                }
                                if (pstmt != null) {
                                    System.out.println("=======prepared statement 종료===========");
                                    pstmt.close();
                                }
                                if (rs != null) {
                                    System.out.println("=======resultSet 종료===========");
                                    rs.close();
                                }
                            }
                        %>
                    </div>
                </div>
<%--                <div class="more_bid btn btn-primary" style="width: 100%">더보기</div>--%>
            </div>
        </div>
    </div>
</div>

<!-- review Modal -->
<div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="reviewModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="reviewModalLabel">후기 남기기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="review_action.jsp" method="post">
                <div class="modal-body">
                    <br>
                    <input type="hidden" class="reviewType" name="type">
                    <input type="hidden" class="itemUID" name="itemUID">
                    <input type="hidden" class="itemID" name="itemID">
                    <div class="starRapping">
                        <div class="startRadio">
                            <label class="startRadio__box">
                                <input type="radio" name="star" id="s1" value="1" checked="checked">
                                <span class="startRadio__img"><span class="blind">별 1개</span></span>
                            </label>
                            <label class="startRadio__box">
                                <input type="radio" name="star" id="s1.5" value="1.5">
                                <span class="startRadio__img"><span class="blind">별 1.5개</span></span>
                            </label>
                            <label class="startRadio__box">
                                <input type="radio" name="star" id="s2" value="2">
                                <span class="startRadio__img"><span class="blind">별 2개</span></span>
                            </label>
                            <label class="startRadio__box">
                                <input type="radio" name="star" id="s2.5" value="2.5">
                                <span class="startRadio__img"><span class="blind">별 2.5개</span></span>
                            </label>
                            <label class="startRadio__box">
                                <input type="radio" name="star" id="s3" value="3">
                                <span class="startRadio__img"><span class="blind">별 3개</span></span>
                            </label>
                            <label class="startRadio__box">
                                <input type="radio" name="star" id="s3.5" value="3.5">
                                <span class="startRadio__img"><span class="blind">별 3.5개</span></span>
                            </label>
                            <label class="startRadio__box">
                                <input type="radio" name="star" id="s4" value="4">
                                <span class="startRadio__img"><span class="blind">별 4개</span></span>
                            </label>
                            <label class="startRadio__box">
                                <input type="radio" name="star" id="s4.5" value="4.5">
                                <span class="startRadio__img"><span class="blind">별 4.5개</span></span>
                            </label>
                            <label class="startRadio__box">
                                <input type="radio" name="star" id="s5" value="5">
                                <span class="startRadio__img"><span class="blind">별 5개</span></span>
                            </label>
                            <label class="startRadio__box">
                                <input type="radio" name="star" id="" value="5.5">
                                <span class="startRadio__img"><span class="blind">별 5.5개</span></span>
                            </label>
                        </div>
                    </div>
                    <br><br>
                    <div class="mb-3" style="padding-left: 20px;padding-right: 20px">
                        <textarea class="form-control" id="FormControlTextarea" name="reviewText" rows="5" placeholder="거래 후기를 남겨주세요!!"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" onclick="reviewEnroll(this.form)">후기 등록</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- SellerInfo Modal -->
<div class="modal fade" id="SellerInfoModal" tabindex="-1" aria-labelledby="SellerInfoModal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="SellerInfoModalLabel">판매자 정보</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="expandItem.jsp" method="post">
                <div class="modal-body">
                    <div class = "UserName">
                        <label>이름 : </label><span class="Name" id="SellerInfoModalName">00000</span>
                    </div>
                    <div class = "UserPhone">
                        <label>전화번호 : </label><span class="Phone" id = "SellerInfoModalPhone">0000</span>
                    </div>
                    <div class = "UserEmail">
                        <label>Email : </label><span class="Email" id ="SellerInfoModalEmail">0000</span>
                    </div>
                    <input type="hidden" class="it_id" name="it_id">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">확인</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
<script>
    let Item_U_id = -1;
    let Item_id = -1;
    let User_id = -1;
    $('#reviewModal').on('show.bs.modal', function (e) {
        Item_U_id = $(e.relatedTarget).data('item').split(",");
    });
    function reviewEnroll(form){
        if (form.FormControlTextarea.value != ""){
            $('.reviewType').val('enroll');
            $('.itemUID').val(Item_U_id[0]);
            $('.itemID').val(Item_U_id[1]);
            form.submit();
        }else{
            alert("글을 써주세요");
        }
    };

    function watchSellerInfo(form) {
        $('.watchSeller').val('true');
        form.submit();
    };
</script>
<%
    System.out.println(request.getParameter("watchSeller"));
    if (request.getParameter("watchSeller") != null && request.getParameter("watchSeller").equals("true")) {
        try {
            Context context = new InitialContext();
            DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
            conn = dataSource.getConnection();
        } catch (SQLException e){
            e.printStackTrace();
        }
        sql = "SELECT name, tel, email FROM MEMBER WHERE U_id = ?";
        try{
            pstmt = conn.prepareStatement(sql);
            System.out.println(request.getParameter("seller_id"));
            pstmt.setString(1, request.getParameter("seller_id"));
            rs = pstmt.executeQuery();
            while(rs.next()) {
%>
<script>
    const name = "<%=rs.getString(1)%>";
    const phone = "<%=rs.getString(2)%>";
    const email = "<%=rs.getString(3)%>";
</script>
<script>
    document.getElementById('SellerInfoModalName').innerHTML = name;
    document.getElementById('SellerInfoModalPhone').innerHTML = phone;
    document.getElementById('SellerInfoModalEmail').innerHTML = email;</script>
<script>
    $('.bid-seller-modal-button').trigger('click');
</script>
<%
            }
        } catch (SQLException e)
        {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                System.out.println("=======connection 종료===========");
                conn.close();
            }
            if (pstmt != null) {
                System.out.println("=======prepared statement 종료===========");
                pstmt.close();
            }
            if (rs != null) {
                System.out.println("=======resultSet 종료===========");
                rs.close();
            }
        }
    }
%>
<%
    System.out.println(request.getParameter("watchBuyer"));
    if (request.getParameter("watchBuyer") != null && request.getParameter("watchBuyer").equals("true")) {
        try {
            Context context = new InitialContext();
            DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
            conn = dataSource.getConnection();
        } catch (SQLException e){
            e.printStackTrace();
        }
        sql = "select u_id from bid where it_id=? and ROWNUM = 1 ORDER BY create_date DESC";
        String buyer_id = null;
        try {
            pstmt = conn.prepareStatement(sql);
            System.out.println(request.getParameter("item_id_WB"));
            pstmt.setInt(1, Integer.parseInt(request.getParameter("item_id_WB")));
            rs = pstmt.executeQuery();
            while(rs.next()){
                buyer_id = rs.getString(1);
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        sql = "SELECT name, tel, email FROM MEMBER WHERE U_id = ?";
        try{
            pstmt = conn.prepareStatement(sql);
            System.out.println(buyer_id);
            pstmt.setString(1, buyer_id);
            rs = pstmt.executeQuery();
            while(rs.next()) {
%>
<script>
    const name = "<%=rs.getString(1)%>";
    const phone = "<%=rs.getString(2)%>";
    const email = "<%=rs.getString(3)%>";
    //alert(name, phone, email);
</script>
<script>
    document.getElementById('BuyerInfoModalName').innerHTML = name;
    document.getElementById('BuyerInfoModalPhone').innerHTML = phone;
    document.getElementById('BuyerInfoModalEmail').innerHTML = email;</script>
<script>
    $('.BuyerModalButton').trigger('click');
</script>
<%
            }
        } catch (SQLException e)
        {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                System.out.println("=======connection 종료===========");
                conn.close();
            }
            if (pstmt != null) {
                System.out.println("=======prepared statement 종료===========");
                pstmt.close();
            }
            if (rs != null) {
                System.out.println("=======resultSet 종료===========");
                rs.close();
            }
        }
    }
%>
</html>
<% } %>