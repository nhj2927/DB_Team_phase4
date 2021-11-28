<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>
<html>
<head>
    <head>
        <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
              crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
                crossorigin="anonymous"></script>

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
        <title>Detail</title>
    </head>
</head>
<body>
<%
    String[] addressList = (String[]) session.getAttribute("address");
    String item_id = request.getParameter("item_id");
    if (addressList == null || addressList.length == 0) { %>
<script>location.href = "../LoginPage/index.jsp"</script>
<% } else if (item_id == null) { %>
<script>location.href = "../"</script>
<% } else { %>
<jsp:include page="../Public/jsp/Header.jsp"></jsp:include>
<div class="container item-container">
    <% try {
        Context context = new InitialContext();
        DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
        conn = dataSource.getConnection();

        String sql = "SELECT I.name, I.start_price, I.current_price,"
                + " I.quick_price, I.min_bid_unit, I.bid_count,"
                + " I.expire_date, I.description, M.average_score"
                + " FROM Item I, Member M"
                + " WHERE I.u_id = M.u_id"
                + " AND I.it_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.valueOf(item_id));
        rs = pstmt.executeQuery();
        if (rs.next()) { %>
    <div class="item-detail">
        <img class="item-image" src="../Public/image/sports.png"/>
        <div class="item-info">
            <h3><%=rs.getString(1)%>
            </h3>
            <hr class="mb-3">
            <div class="row mt-3 mb-4 h5">
                <div class="col-md-4">시작가</div>
                <div class="col-md-8"><%=rs.getInt(2)%>원</div>
            </div>
            <div class="row mb-4 h5">
                <div class="col-md-4">현재가</div>
                <div class="col-md-8 text-danger fw-bold"><%=rs.getInt(3)%>원</div>
            </div>
            <div class="row mb-4 h5">
                <div class="col-md-4">즉시구매가</div>
                <div class="col-md-8"><%=rs.getInt(4)%>원</div>
            </div>
            <div class="row mb-4 h5">
                <div class="col-md-4">최소입찰단위</div>
                <div class="col-md-8"><%=rs.getInt(5)%>원</div>
            </div>
            <div class="row mb-4 h5">
                <div class="col-md-4">입찰수</div>
                <div class="col-md-8"><%=rs.getInt(6)%>회</div>
            </div>
            <div class="row mb-4 h5">
                <div class="col-md-4">종료</div>
                <div class="col-md-8"><%=rs.getDate(7)%>
                </div>
            </div>
            <div class="row mb-4 h5">
                <div class="col-md-4">판매자평점</div>
                <div class="col-md-8 row align-items-center">
                        <span class="col-md-1">
                            <img src="../Public/image/star.png"
                                 width="25rem" height="25rem"/>
                        </span>
                    <div class="col-md-3">
                        <%=rs.getDouble(9)%>/5
                    </div>
                </div>
            </div>
            <div class="row ml-3 btn-wrapper">
                <div class="col button bid" data-bs-toggle="modal"
                     data-bs-target="#bid-modal">입찰하기
                </div>
                <div class="col button quick" data-bs-toggle="modal"
                     data-bs-target="#quick-modal">즉시구매하기
                </div>
                <div class="col button report" data-bs-toggle="modal"
                     data-bs-target="#report-modal">신고하기
                </div>
            </div>
        </div>
    </div>
    <div class="item-description mb-5">
        <div class="h3 fw-bold mb-3">상세 정보</div>
        <div class="h5"><%=rs.getString(8)%>
        </div>
    </div>
    <div class="modal fade" id="bid-modal" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">입찰</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="h5">입찰가를 입력해주세요</div>
                    <input id="bid-price-input" type="text" class="row form-control"/><span class="h5">원</span>
                    <div class="h5 fw-bold text-danger">최소 입찰 단위: <%=rs.getInt(5)%>원</div>
                </div>
                <div class="modal-footer row justify-content-center">
                    <button type="button" class="col-md-3 btn btn-primary" onclick="bid()">입찰하기</button>
                    <button type="button" class="col-md-3 btn btn-secondary" data-bs-dismiss="modal">취소</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="quick-modal" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">즉시구매</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="h5">즉시 구매하시겠습니까?</div>
                    <div class="h5 fw-bold text-danger">즉시 구매가: <%=rs.getInt(4)%>원</div>
                </div>
                <div class="modal-footer row justify-content-center">
                    <button type="button" class="col-md-3 btn btn-primary" onclick="quick()">예</button>
                    <button type="button" class="col-md-3 btn btn-secondary" data-bs-dismiss="modal">아니오</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="report-modal" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">신고</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="h5">신고 내용을 적어주세요</div>
                    <textarea id="report-input" class="form-control" rows="10"></textarea>
                </div>
                <div class="modal-footer row justify-content-center">
                    <button type="button" class="col-md-3 btn btn-primary" onclick="report()">신고하기</button>
                    <button type="button" class="col-md-3 btn btn-secondary" data-bs-dismiss="modal">취소</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        const bid = () => {
            const price = $('#bid-price-input').val();
            if (parseInt(price) <= '<%=rs.getInt(3)%>') {
                alert("현재가보다 높아야합니다");
            } else if (parseInt(price) >= '<%=rs.getInt(4)%>') {
                alert("즉시 구매해주세요");
            } else if ((price - '<%=rs.getInt(3)%>') > '<%=rs.getInt(5)%>') {
                location.href = '../Service/bid.jsp?item_id=' + '<%=item_id%>'
                    + '&price=' + price;
            } else {
                alert("최소 입찰 단위를 맞추세요");
            }
        }
        const quick = () => {
            location.href = '../Service/quick.jsp?item_id=' + '<%=item_id%>'
                    + '&price=' + '<%=rs.getInt(4)%>';
        }
        const report = () => {
            location.href = '../Service/report.jsp?item_id=' + '<%=item_id%>'
                    + '&content=' + $('#report-input').val().replace(/(\n|\r\n)/g, '%0a');
        }
    </script>
    <% }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        conn.close();
        pstmt.close();
        rs.close();
    } %>
</div>
<% } %>
</body>
</html>
