<%--
  Created by IntelliJ IDEA.
  User: dydal
  Date: 2021-11-23
  Time: 오후 10:56
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
    <link type="text/css" rel="stylesheet" href="../Public/css/MyPage_Main.css">
    <link type="text/css" rel="stylesheet" href="../Public/css/modiUser.css">
    <title>MyPage-회원정보 수정</title>
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
                <div class="side-title"><a href="bid.jsp">내 입찰 목록</a></div>
                <div class="side-body"><a href="#">낙찰 완료</a> </div>
                <div class="side-body"><a href="#">후기 작성 필요</a> </div>
                <div class="side-body"><a href="#">거래 완료</a> </div>
            </div>
            <div class="side-content">
                <div class="side-title"><a href="items.jsp">내 등록 상품</a></div>
                <div class="side-body"><a href="#">낙찰 완료</a> </div>
                <div class="side-body"><a href="#">후기 작성 필요</a> </div>
                <div class="side-body"><a href="#">거래 완료</a> </div>
            </div>
            <div class="side-content">
                <div class="side-title"><a href="reviews.jsp">내 후기</a></div>
                <div class="side-body"><a href="#">낙찰 완료</a> </div>
                <div class="side-body"><a href="#">후기 작성 필요</a> </div>
                <div class="side-body"><a href="#">거래 완료</a> </div>
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
                                <td>Kimkim</td>
                            </tr>
                            <tr>
                                <td>이름</td>
                                <td>
                                    <span class="inline-message" >홍길동</span>
                                </td>
                            </tr>

                            <tr>
                                <td>이메일</td>
                                <td>
                                    <span class="inline-message" >kimkim@gmail.com</span>
                                    <button type="button"  class="btn btn-warning" onclick="">이메일 변경</button>
                                </td>
                            </tr>
                            <tr>
                                <td>닉네임</td>
                                <td>
                                    <span class="inline-message" >경매하자</span>
                                    <button type="button"  class="btn btn-warning" onclick="">닉네임 변경</button>
                                </td>
                            </tr>
                            <tr>
                                <td>휴대폰 번호</td>
                                <td>
                                    <span class="inline-message" style="display: inline-block; width: 200px">01011112222</span>
                                    <button type="button"  class="btn btn-warning" onclick="">휴대폰 번호 변경</button>
                                </td>
                            </tr>

                            <tr>
                                <td>비밀번호 변경</td>
                                <td>
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
                                        <button type="button"  class="btn btn-warning" onclick="">비밀번호 변경</button>
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <td>거래지역 변경</td>
                                <td>
                                    <div>대현동 | 복현동 | 산격동</div>
                                    <br>
                                    <div>
                                        <button type="button"  class="btn btn-warning" onclick="">지역 추가</button>
                                        <button type="button"  class="btn btn-default" onclick="">지역 삭제</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>한줄 소개</td>
                                <td>
                                    <div>안녕하세요 처음 가입했는데, 잘 부탁드려요</div>
                                    <br>
                                    <div>
                                        <button type="button"  class="btn btn-warning" onclick="">한줄 소개 변경</button>
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <td colspan="2" class="text-center">
                                    <input type="hidden" name="id" value="">
                                    <button type="button"  class="btn btn-danger" onclick="">나가기</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
