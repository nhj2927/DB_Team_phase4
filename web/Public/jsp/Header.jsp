<%--
  Created by IntelliJ IDEA.
  User: dydal
  Date: 2021-11-23
  Time: 오후 3:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    String address = request.getParameter("address");
    String category_id = request.getParameter("category_id");
%>
<style>
    .search-btn {
        display: flex;
        justify-content: center;
        align-items: center;
        cursor: pointer;
    }
    .logout {
        color: #fff;
        cursor: pointer;
        text-decoration: underline;
    }
</style>
<!-- HEADER -->
<header>
    <!-- TOP HEADER -->
    <div id="top-header">
        <div class="container">
            <ul class="header-links pull-left">
                <li><a href="#" style=" text-decoration-line: none"><i class="fa fa-phone"></i> 080-1111-2222</a></li>
                <li><a href="#" style=" text-decoration-line: none"><i class="fa fa-envelope-o"></i> HiAuction@HiAuction.com</a></li>
                <li><a href="#" style=" text-decoration-line: none"><i class="fa fa-map-marker"></i> 대구광역시 북구 대학로 80, 경북대학교 IT 융복합관</a></li>
            </ul>
            <ul class="header-links pull-right">
                <li><a href="#"><i class="fa fa-won"></i> KR</a></li>
                <li><a href="/DB_Team_phase4_war_exploded/MyPage"><i class="fa fa-user-o"></i> 마이페이지</a></li>
                <li class="logout" onclick="logout()"><i class="fa fa-user-o"></i>로그아웃</li>
            </ul>
        </div>
    </div>
    <!-- /TOP HEADER -->

    <!-- MAIN HEADER -->
    <div id="header">
        <!-- container -->
        <div class="container">
            <!-- row -->
            <div class="row">
                <!-- LOGO -->
                <div class="col-md-3">
                    <div class="header-logo">
                        <a href="#" class="logo">
                            <img src="./img/logo.png" alt="">
                        </a>
                    </div>
                </div>
                <!-- /LOGO -->

                <!-- SEARCH BAR -->
                <div class="col-md-6">
                    <div class="header-search">
                        <form onsubmit="searchItem()" style="display: flex">
                            <select class="input-select">
                                <option value="0">검색</option>
                            </select>
                            <input id="search-input" class="input" placeholder="Search here">
                            <div class="search-btn" onclick="searchItem()">검색</div>
                        </form>
                    </div>
                </div>
                <!-- /SEARCH BAR -->

                <!-- ACCOUNT -->
                <div class="col-md-3 clearfix">
                    <div class="header-ctn">
                        <!-- Wishlist -->
                        <div>
                            <a href="#">
                                <i class="fa fa-heart-o"></i>
                                <span>Your Wishlist</span>
                                <div class="qty">2</div>
                            </a>
                        </div>
                        <!-- /Wishlist -->

                        <!-- Cart -->
                        <div class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                                <i class="fa fa-shopping-cart"></i>
                                <span>Your Cart</span>
                                <div class="qty">3</div>
                            </a>
                            <div class="cart-dropdown">
                                <div class="cart-list">
                                    <div class="product-widget">
                                        <div class="product-img">
                                            <img src="./img/product01.png" alt="">
                                        </div>
                                        <div class="product-body">
                                            <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                            <h4 class="product-price"><span class="qty">1x</span>$980.00</h4>
                                        </div>
                                        <button class="delete"><i class="fa fa-close"></i></button>
                                    </div>

                                    <div class="product-widget">
                                        <div class="product-img">
                                            <img src="./img/product02.png" alt="">
                                        </div>
                                        <div class="product-body">
                                            <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                            <h4 class="product-price"><span class="qty">3x</span>$980.00</h4>
                                        </div>
                                        <button class="delete"><i class="fa fa-close"></i></button>
                                    </div>
                                </div>
                                <div class="cart-summary">
                                    <small>3 Item(s) selected</small>
                                    <h5>SUBTOTAL: $2940.00</h5>
                                </div>
                                <div class="cart-btns">
                                    <a href="#">View Cart</a>
                                    <a href="#">Checkout <i class="fa fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                        </div>
                        <!-- /Cart -->

                        <!-- Menu Toogle -->
                        <div class="menu-toggle">
                            <a href="#">
                                <i class="fa fa-bars"></i>
                                <span>Menu</span>
                            </a>
                        </div>
                        <!-- /Menu Toogle -->
                    </div>
                </div>
                <!-- /ACCOUNT -->
            </div>
            <!-- row -->
        </div>
        <!-- container -->
    </div>
    <!-- /MAIN HEADER -->
</header>
<!-- /HEADER -->
<script>
    const searchItem = () => {
        const address = '<%=address%>';
        const category_id = '<%=category_id%>';
        const search = $('#search-input').val();
        let url = '/DB_Team_phase4_war_exploded/?';
        if (search) {
            url += 'search=' + search;
        }
        if (address !== 'null') {
            url += '&address=' + address;
        }
        if (category_id !== 'null') {
            url += '&category_id=' + category_id;
        }
        location.href = url;
    }
    const logout = () => {
        location.href = '/DB_Team_phase4_war_exploded/LoginPage';
    }
</script>