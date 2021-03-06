<%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 2021-11-23
  Time: 오후 7:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <script src="https://kit.fontawesome.com/2141b63311.js" crossorigin="anonymous"></script>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">--%>
<%--    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>--%>
</head>
<body>
<%
    String adminID = session.getAttribute("id").toString();
%>
    <div class="col-auto col-md-3 col-xl-2 px-sm-2 px-0 bg-dark">
        <div class="d-flex flex-column align-items-center align-items-sm-start px-3 pt-2 text-white min-vh-100">
            <br>
            <!-- admin profile-->
            <div class="dropdown pb-4">
                <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
                    <img src="https://avatars.dicebear.com/api/identicon/<%=adminID%>.svg" alt="hugenerd" width="30" height="30" class="rounded-circle">
                    <span class="d-none d-sm-inline mx-1"><%=adminID%></span>
                </a>
                <ul class="dropdown-menu dropdown-menu-dark text-small shadow">
                    <li><a id="Logout"class="dropdown-item" href="/DB_Team_phase4_war_exploded/Service/LogoutAction.jsp">Log out</a></li>
                </ul>
            </div>
            <!-- admin profile-->
            <br>
            <a href="index.jsp" class="d-flex align-items-center pb-3 mb-md-0 me-md-auto text-white text-decoration-none">
                <span class="fs-5 d-none d-sm-inline">Menu</span>
            </a>
            <ul class="nav nav-pills flex-column mb-sm-auto mb-0 align-items-center align-items-sm-start " id="menu">
                <li class="nav-item">
                    <a href="reportList" class="nav-link align-middle px-0 text-white">
                        <i class="fas fa-exclamation-circle"></i>
                         <span class="ms-1 d-none d-sm-inline">신고 리스트</span>
                    </a>
                </li>
                <li>
                    <a href="memberList" class="nav-link px-0 align-middle text-white">
                        <i class="fas fa-tasks"></i>
                        </i> <span class="ms-1 d-none d-sm-inline">회원 관리</span></a>
                </li>
                <li>
                    <a class="nav-link px-0 align-middle text-white" data-bs-toggle="modal" data-bs-target="#AddAdmin" style="cursor:pointer;">
                        <i class="far fa-address-book"></i></i> <span class="ms-1 d-none d-sm-inline">관리자 추가</span> </a>
                </li>
                <br>
            </ul>
        </div>
    </div>
    <!-- Modal for AddAdmin -->
    <div class="modal fade" id="AddAdmin" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">관리자 추가</h5>
                </div>
                <!-- modal body-->
                <div class="modal-body">
                    <div class="container">
                        <div style="padding-top: 20px;">
                            <form method="post" action="/DB_Team_phase4_war_exploded/AdminPage/AdminjoinAction.jsp">
                                <div class="form-group">
                                    <input type="text" class="form-control" placeholder="관리자 아이디" name="AdminID" maxlength="20">
                                </div>
                                <div class="form-group">
                                    <input type="password" class="form-control" placeholder="비밀번호" name="AdminPW" maxlength="20">
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control" placeholder="이름" name="AdminName" maxlength="20">
                                </div>
                                <input type="submit" class="btn btn-primary form-control" value="관리자 추가">
                            </form>
                        </div>
                    </div>
                </div>
                <!-- modal body-->
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal for AddAdmin -->
</body>

