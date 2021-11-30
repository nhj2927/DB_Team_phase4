<%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 2021-11-23
  Time: 오후 3:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    String name = (String) session.getAttribute("name");
%>
<!-- HEADER -->
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
            <div class="row justify-content-between" style="margin-top: 1.5rem">
                <!-- LOGO -->
                <div class="col-md-3">
                    <div class="header-logo">
                        <a href="/DB_Team_phase4_war_exploded/AdminPage" class="logo">
                            <img src="/DB_Team_phase4_war_exploded/Public/image/HiAuction-logos_white.png" alt="" style="width: 200px;">
                        </a>
                    </div>
                </div>
                <!-- /LOGO -->
            </div>
            <!-- row -->
        </div>
        <!-- container -->
    </div>
    <!-- /MAIN HEADER -->
</header>
<!-- /HEADER -->
<script>
    const logout = () => {
        location.href = '/DB_Team_phase4_war_exploded/Service/LogoutAction.jsp';
    }
</script>