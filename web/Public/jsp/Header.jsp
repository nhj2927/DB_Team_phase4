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
                            <img src="/DB_Team_phase4_war_exploded/Public/image/HiAuction-logos_white.png" alt="" style="height: 100px;width: 300px;object-fit: cover;">
                        </a>
                    </div>
                </div>
                <!-- /LOGO -->

                <!-- SEARCH BAR -->
                <div class="col-md-6">
                    <div class="header-search">
                        <form style="display: flex">
                            <select class="input-select">
                                <option value="0">검색</option>
                            </select>
                            <input id="search-input" class="input" placeholder="Search here">
                            <div class="search-btn" onclick="searchItem()">검색</div>
                        </form>
                    </div>
                </div>
                <!-- /SEARCH BAR -->

<%--                <!-- ACCOUNT -->--%>
<%--                <div class="col-md-3 clearfix">--%>
<%--                    <div class="header-ctn">--%>
<%--                        --%>

<%--                        <!-- Menu Toogle -->--%>
<%--                        <div class="menu-toggle">--%>
<%--                            <a href="#">--%>
<%--                                <i class="fa fa-bars"></i>--%>
<%--                                <span>Menu</span>--%>
<%--                            </a>--%>
<%--                        </div>--%>
<%--                        <!-- /Menu Toogle -->--%>
<%--                    </div>--%>
<%--                </div>--%>
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
    $('#search-input').keypress((e)=>{
        if(e.keyCode == 13){
            e.preventDefault();
            searchItem();
        }
    })
    const searchItem = () => {
        const address = '<%=address%>';
        const category_id = '<%=category_id%>';
        const search = $('#search-input').val();
        let url = '/DB_Team_phase4_war_exploded/?';
        if (search) {
            url += 'search=' + search.toLowerCase();
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
        location.href = '/DB_Team_phase4_war_exploded/Service/LogoutAction.jsp';
    }
</script>