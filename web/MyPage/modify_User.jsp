<%--
  Created by IntelliJ IDEA.
  User: dydal
  Date: 2021-11-23
  Time: 오후 10:56
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
    String sql = null;
    if (session.getAttribute("id") == null){
        response.sendRedirect("../LoginPage/");
    }
    else {

    String type = request.getParameter("type");
    System.out.println(type);
    String email = null;
    String tel = null;
    String oldPW = null;
    String newPW = null;
    String Description = null;
    String id = (String) session.getAttribute("id");
    if (type != null){
        Context context = new InitialContext();
        DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
        conn = dataSource.getConnection();
        if (type.equals("email")) {
            email = request.getParameter("email");
            sql = "UPDATE MEMBER SET email = ? WHERE u_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);

        } else if (type.equals("tel")) {
            tel = request.getParameter("phone");
            sql = "UPDATE MEMBER SET tel = ? WHERE u_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, tel);
        } else if (type.equals("password")) {
            String getPW = null;
            oldPW = request.getParameter("pass1");
            sql = "SELECT pw FROM MEMBER WHERE U_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            while(rs.next()){
                getPW = rs.getString(1);
            }
            if (!getPW.equals(oldPW)){
                %>
                <script>
                    alert("현재 비밀번호가 일치하지 않습니다. 다시 입력해주세요");
                    location.href = "./modify_User.jsp";
                </script>
                <%
                return;
            }
            newPW = request.getParameter("pass2");
            sql = "UPDATE MEMBER SET pw = ? WHERE u_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newPW);
        } else if (type.equals("description")) {
            Description = request.getParameter("FormControlTextarea");
            sql = "UPDATE MEMBER SET description = ?  WHERE U_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, Description);
        }
        try {
            pstmt.setString(2, id);
            int status = pstmt.executeUpdate();
            if (status != 1){ %>
                <script>
                    alert("변경 실패");
                </script>
            <%
            } else { %>
                <script>
                    alert("변경 성공");
                </script>
            <%
                if (type.equals("email")){
                    session.setAttribute("email", email);
                } else if(type.equals("tel")) {
                    session.setAttribute("tel", tel);
                } else if(type.equals("password")) {
                    session.setAttribute("pw", newPW);
                } else if(type.equals("description")) {
                    session.setAttribute("description", Description);
                }
            }
        } catch (SQLException e)
        {
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
        }
    }

%>
<html>
<head>
    <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
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
    <link type="text/css" rel="stylesheet" href="../Public/css/modiUser.css">
    <title>MyPage-회원정보 수정</title>
</head>
<body>
<jsp:include page="../Public/jsp/Header.jsp"></jsp:include>
<div class="MyPageBox">
    <div class="MyPageTopBar">
        <a class="MyPageTopBar_Logo" href='index.jsp'>
            <div style="text-align: center; font-size: 1.8rem;font-weight: bold;color:white;margin-top:1.3rem">MY HIAuction</div>
        </a>
        <%
            try {
                Context context = new InitialContext();
                DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
                conn = dataSource.getConnection();
            } catch (SQLException e){
                e.printStackTrace();
            }
            id = (String) session.getAttribute("id");
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
                    <div class="mpb_Title">회원 정보 수정</div>
                </div>
                <div class="MyPageBody_content">
                    <div class="modiBox">
                        <table class="table table-striped modiUser_table" >
                            <tr>
                                <td >아이디</td>
                                <td><%=session.getAttribute("id")%></td>
                            </tr>
                            <tr>
                                <td>이름</td>
                                <td>
                                    <span class="inline-message" ><%=session.getAttribute("name")%></span>
                                </td>
                            </tr>

                            <tr>
                                <td>이메일</td>
                                <td>
                                    <span class="inline-message" ><%=session.getAttribute("email")%></span>
                                    <button type="button"  class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#modifyEmailModal">이메일 변경</button>
                                </td>
                            </tr>
                            <tr>
                                <td>휴대폰 번호</td>
                                <td>
                                    <span class="inline-message"><%=session.getAttribute("tel")%></span>
                                    <button type="button"  class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#modifyTelModal">휴대폰 번호 변경</button>
                                </td>
                            </tr>

                            <tr>
                                <td>비밀번호 변경</td>
                                <td>
                                    <form action="modify_User.jsp" method="post" onsubmit="return isValidSubmit()">
                                        <input type="hidden" class="modifyType" name="type">
                                        <div>
                                            <label for="currentPass" class="pass-label" >현재 비밀번호</label>
                                            <input id="currentPass" type="password" value="" name="pass1" class="passInput">
                                        </div>
                                        <div>
                                            <label for="newPass" class="pass-label" >새 비밀번호</label>
                                            <input id="newPass" type="password" value="" name="pass2" class="passInput">
                                        </div>
                                        <div>
                                            <label for="confirmPass" class="pass-label" >비밀번호 다시 입력</label>
                                            <input id="confirmPass" type="password" value="" name="pass3" class="passInput">
                                            <button type="button"  class="btn btn-warning" id="modifyPassSubmit" onclick="modifyPass(this.form)">비밀번호 변경</button>
                                        </div>
                                    </form>
                                </td>
                            </tr>

                            <tr>
                                <td>거래지역</td>
                                <td>
                                    <div>
                                        <%
                                            sql = "select name from lives_in l, address a where l.ad_id = a.ad_id and l.u_id = ?";
                                            try{
                                                pstmt = conn.prepareStatement(sql);
                                                pstmt.setString(1, (String)session.getAttribute("id"));
                                                rs = pstmt.executeQuery();
                                                while(rs.next()) {
                                                    out.print(rs.getString(1));
                                                    out.print(" | ");
                                                }
                                            } catch(SQLException e) {
                                                e.printStackTrace();
                                            }
                                        %>
                                    </div>
                                    <br>
                                    <div>
                                        <!--<button type="button"  class="btn btn-warning" onclick="">지역 추가</button>
                                        <button type="button"  class="btn btn-secondary" onclick="">지역 삭제</button>-->
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>한줄 소개</td>
                                <td>
                                    <div><%=session.getAttribute("description")%></div>
                                    <br>
                                    <div>
                                        <button type="button"  class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#modifyDescriptionModal">한줄 소개 변경</button>
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <td colspan="2" class="text-center">
                                    <input type="hidden" name="id" value="">
                                    <button type="button"  class="btn btn-secondary" onclick="">나가기</button>
                                    <button type="submit"  class="btn btn-danger" data-item='<%=session.getAttribute("id")%>' data-bs-toggle="modal" data-bs-target="#deleteMemberModal">회원탈퇴</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- modify email Modal -->
<div class="modal fade" id="modifyEmailModal" tabindex="-1" aria-labelledby="modifyEmailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modifyEmailModalLabel">이메일 변경</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="./modify_User.jsp" method="post">
                <input type="hidden" class="modifyType" name="type">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="InputEmail" class="form-label">변경할 email을 입력하세요</label>
                        <input type="email" class="form-control" id="InputEmail" name='email' aria-describedby="emailHelp" placeholder="example@example.com">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="submit" class="btn btn-primary" id="modifyEmailSubmit" onclick="modifyEmail(this.form)" >이메일 변경</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- modify tel Modal -->
<div class="modal fade" id="modifyTelModal" tabindex="-1" aria-labelledby="modifyTelModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modifyTelModalLabel">휴대폰 번호 변경</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form name="frm" method="post" action="?">
                <input type="hidden" class="modifyType" name="type">
                <div class="modal-body">
                    <input type="text" name="phone" class="phone" maxlength="13" placeholder="휴대폰 번호 예)01011112222">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="submit" class="btn btn-primary" id="modifyTelSubmit" onclick="modifyTel(this.form)">휴대폰 번호 변경</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- deleteMember Modal -->
<div class="modal fade" id="deleteMemberModal" tabindex="-1" aria-labelledby="deleteMemberModal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteMemberModalLabel">회원 탈퇴</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="withdrawal_member.jsp" method="post">
                <div class="modal-body">
                    정말 탈퇴하시겠습니까?
                </div>
                <input type="hidden" class="u_id" name="u_id">
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-danger" onclick="deleteMember(this.form)">탈퇴하기</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- description tel Modal -->
<div class="modal fade" id="modifydescriptionModal" tabindex="-1" aria-labelledby="modifydescriptionModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modifydescriptionModalLabel">한줄 소개 변경</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form name="frm" method="post" action="modify_User.jsp" id="modifyDescriptionForm">
                <input type="hidden" class="modifyType" name="type">
                <div class="modal-body">
                    <textarea class="form-control" id="FormControlTextarea" name="FormControlTextarea" rows="5" placeholder="한 줄 소개를 써주세요"></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" id="modifydescriptionSubmit" onclick="modifyDes(this.form)">한줄 소개 변경</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
<script>
    let validStatus = 0;
    let u_id = -1;
    function validateEmail(email) {
        var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
        return re.test(email);
    };
    function modifyEmail(form) {
        $('.modifyType').val('email');
        $('#modifyEmailSubmit').submit();
    };
    function modifyTel(form) {
        $('.modifyType').val('tel');
    };
    function modifyPass(form) {
        if (form.pass1.value != "" & form.pass2.value != "" & form.pass3.value != "") {
            if (form.pass2.value != form.pass3.value) {
                validStatus = 0;
                alert("비밀번호가 일치하지 않습니다 다시 입력해주세요.");
                return;
            } else {
                validStatus = 1;
                $('.modifyType').val('password');
                form.submit();
            }
        } else {
            alert("값을 입력해주세요");
        }
    };
    function modifyDes(form){
        if (form.FormControlTextarea.value != ""){
            $('.modifyType').val('description');
            form.submit();
        }else{
            alert("글을 써주세요")
        }
    };

    function isValidSubmit() {
        return validStatus;
    };
    $('#deleteMemberModal').on('show.bs.modal', function (e) {
        u_id = $(e.relatedTarget).data('item');
        //alert(Item_id);
    });
    function deleteMember(form){
        $('.u_id').val(u_id);
        form.submit();
    };
</script>
</html>
<% } %>
