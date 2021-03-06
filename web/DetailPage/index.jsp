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
    String id = (String) session.getAttribute("id");
    String item_id = request.getParameter("item_id");
    if (id == null) { %>
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
                + " I.expire_date, I.description, I.it_id, M.average_score, M.u_id"
                + " FROM Item I, Member M"
                + " WHERE I.u_id = M.u_id"
                + " AND I.it_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.valueOf(item_id));
        rs = pstmt.executeQuery();
        if (rs.next()) { %>
    <div class="item-detail">
        <img class="item-image" src="../Service/downloadImage.jsp?it_id=<%=rs.getInt(9)%>"/>
        <div class="item-info fw-bolder">
            <h2><%=rs.getString(1)%>
            </h2>
            <hr class="mb-3">
            <div class="row mt-3 mb-4 h5">
                <div class="col-md-4 fw-bold">?????????</div>
                <div class="col-md-8"><%=rs.getInt(2)%>???</div>
            </div>
            <div class="row mb-4 h5">
                <div class="col-md-4 fw-bold">?????????</div>
                <div class="col-md-8 text-danger fw-bold"><%=rs.getInt(3)%>???</div>
            </div>
            <div class="row mb-4 h5">
                <div class="col-md-4 fw-bold">???????????????</div>
                <div class="col-md-8"><%=rs.getInt(4)%>???</div>
            </div>
            <div class="row mb-4 h5">
                <div class="col-md-4 fw-bold">??????????????????</div>
                <div class="col-md-8"><%=rs.getInt(5)%>???</div>
            </div>
            <div class="row mb-4 h5">
                <div class="col-md-4 fw-bold">?????????</div>
                <div class="col-md-8"><%=rs.getInt(6)%>???</div>
            </div>
            <div class="row mb-4 h5">
                <div class="col-md-4 fw-bold">??????</div>
                <div class="col-md-8"><%=rs.getDate(7)%>
                </div>
            </div>
            <div class="row mb-4 h5">
                <div class="col-md-4 fw-bold">???????????????</div>
                <div class="col-md-8 row align-items-center">
                        <span class="col-md-1">
                            <img src="../Public/image/star.png"
                                 width="25rem" height="25rem"/>
                        </span>
                    <div class="col-md-3">
                        <%=rs.getDouble(10)%>/5
                    </div>
                </div>
            </div>
            <div class="row ml-3 btn-wrapper">
                <div class="col button bid" data-bs-toggle="modal"
                     data-bs-target="#bid-modal">????????????
                </div>
                <div class="col button quick" data-bs-toggle="modal"
                     data-bs-target="#quick-modal">??????????????????
                </div>
                <div class="col button report" data-bs-toggle="modal"
                     data-bs-target="#report-modal">????????????
                </div>
            </div>
        </div>
    </div>
    <hr/>
    <div class="item-description mb-5">
        <div class="h3 fw-bold mb-3 text-primary">?????? ??????</div>
        <div class="h5" style="line-height: 2"><%=rs.getString(8).replaceAll("\n", "<br>")%>
        </div>
    </div>
    <div class="modal fade" id="bid-modal" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">??????</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="h5">???????????? ??????????????????</div>
                    <input id="bid-price-input" type="text" class="row form-control"/><span class="h5">???</span>
                    <div class="h5 fw-bold text-danger">?????? ?????? ??????: <%=rs.getInt(5)%>???</div>
                </div>
                <div class="modal-footer row justify-content-center">
                    <button type="button" class="col-md-3 btn btn-primary" onclick="bid()">????????????</button>
                    <button type="button" class="col-md-3 btn btn-secondary" data-bs-dismiss="modal">??????</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="quick-modal" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">????????????</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="h5">?????? ?????????????????????????</div>
                    <div class="h5 fw-bold text-danger">?????? ?????????: <%=rs.getInt(4)%>???</div>
                </div>
                <div class="modal-footer row justify-content-center">
                    <button type="button" class="col-md-3 btn btn-primary" onclick="quick()">???</button>
                    <button type="button" class="col-md-3 btn btn-secondary" data-bs-dismiss="modal">?????????</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="report-modal" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">??????</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="h5">?????? ????????? ???????????????</div>
                    <textarea id="report-input" class="form-control" rows="10"></textarea>
                </div>
                <div class="modal-footer row justify-content-center">
                    <button type="button" class="col-md-3 btn btn-primary" onclick="report()">????????????</button>
                    <button type="button" class="col-md-3 btn btn-secondary" data-bs-dismiss="modal">??????</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        const check = () => {
            if ('<%=id%>' === '<%=rs.getString(11)%>') {
                return false;
            } else {
                return true;
            }
        }
        const bid = () => {
            if (!check()) {
                alert("????????? ????????? ????????? ????????? ??? ????????????");
                location.reload();
            } else {
                const price = $('#bid-price-input').val();
                location.href = '../Service/bid.jsp?item_id=' + '<%=item_id%>'
                    + '&price=' + price;
            }
        }
        const quick = () => {
            if (!check()) {
                alert("????????? ????????? ????????? ????????? ??? ????????????");
                location.reload();
            } else {
                location.href = '../Service/quick.jsp?item_id=' + '<%=item_id%>'
                    + '&price=' + '<%=rs.getInt(4)%>';
            }
        }
        const report = () => {
            if (!check()) {
                alert("????????? ????????? ????????? ????????? ??? ????????????");
                location.reload();
            } else {
                location.href = '../Service/report.jsp?item_id=' + '<%=item_id%>'
                    + '&content=' + $('#report-input').val().replace(/(\n|\r\n)/g, '%0a');
            }
        }
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
    } %>
</div>
<% } %>
</body>
</html>
