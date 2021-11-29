<%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 2021-11-23
  Time: 오후 8:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <!-- Bootstrap -->
    <!--<link type="text/css" rel="stylesheet" href="../Public/css/bootstrap.min.css"/>-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <!-- Font Awesome Icon -->
    <link rel="stylesheet" href="../Public/css/font-awesome.min.css">
    <!-- Custom stlylesheet -->
    <link type="text/css" rel="stylesheet" href="../Public/css/style.css"/>
    <link type="text/css" rel="stylesheet" href="../Public/css/modiUser.css">
    <title>HiAuction - 회원 상세</title>
</head>
<jsp:include page="../Public/jsp/AdminHeader.jsp"></jsp:include>
<%
    String member_id = request.getParameter("uid");
    Context context = new InitialContext();
    DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
    Connection conn = dataSource.getConnection();
    String sql = "with reported_num as( " +
            "    select m.u_id as ruid, count(*) as rnum " +
            "    from member m, report r " +
            "    where m.u_id=r.u_id " +
            "    group by m.u_id) " +
            "select * " +
            "from member m left outer join reported_num r on m.u_id=r.ruid " +
            "where m.u_id = ?";

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, member_id);
    rs = pstmt.executeQuery();
    rs.next();
%>
<body>
    <div class="container-fluid">
        <div class="row flex-nowrap">
            <jsp:include page="../Public/jsp/AdminSidebar.jsp"></jsp:include>
            <div class="col py-3" style="padding: 20vh">
                <br>
                <h2 class="fw-bolder mb-1">회원 상세정보</h2>
                <hr/>
                <!--modibox-->
                <div class="modiBox" style="font-size: 20px">
                    <table class="table table-striped modiUser_table" >
                        <tr>
                            <td class="detail-name">아이디</td>
                            <td>
                                <span class="inline-message detail-value"><%=rs.getString(1)%></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="detail-name">닉네임</td>
                            <td>
                                <span class="inline-message detail-value"><%=rs.getString(3)%></span>
                            </td>
                        </tr>

                        <tr>
                            <td class="detail-name">이메일</td>
                            <td>
                                <span class="inline-message detail-value" ><%=rs.getString(7)%></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="detail-name">휴대폰 번호</td>
                            <td>
                                <span class="inline-message detail-value" style="display: inline-block; width: 200px"><%=rs.getString(6)%></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="detail-name">한줄 소개</td>
                            <td>
                                <span class="detail-value">
                                    <%=rs.getString(4)%>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td class="detail-name">신고된 횟수</td>
                            <td class="detail-value"><%=rs.getInt(9)%></td>
                        </tr>
                        <tr>
                            <td class="detail-name">평균 평점</td>
                            <td class="detail-value"><%=rs.getFloat(5)%></td>
                        </tr>

                        <tr>
                            <td class="detail-name">거래지역</td>
                            <td>
                                <%
                                    sql = "select a.name " +
                                            "from member m, lives_in l, address a " +
                                            "where m.u_id=l.u_id " +
                                            "and l.ad_id=a.ad_id " +
                                            "and m.u_id=? ";
                                    pstmt = conn.prepareStatement(sql);
                                    pstmt.setString(1,member_id);
                                    rs = pstmt.executeQuery();
                                    while(rs.next()) {
                                        out.println("<span class=\"detail-value\">");
                                        out.println(rs.getString(1));
                                        out.println("|</span>");
                                    }
                                    pstmt.close();
                                    rs.close();
                                    conn.close();
                                %>
                            </td>
                        </tr>
                    </table>
                </div>
                <!--modibox-->
                <hr/>
                <!-- Buttons -->
                <div>
                    <button class="btn btn-danger">회원 삭제</button>
                    <button class="btn btn-secondary" onclick="history.back()">뒤로 가기</button>
                </div>
                <!-- Buttons -->
            </div>

        </div>

    </div>
</body>
</html>
