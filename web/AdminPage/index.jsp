<%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 2021-11-23
  Time: 오후 3:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>HiAuction - 관리자페이지</title>
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<jsp:include page="../Public/jsp/AdminHeader.jsp"></jsp:include>
<%
    Context context = new InitialContext();
    DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
    Connection conn = dataSource.getConnection();
    String sql = "";
    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>
<body>
    <div class="container-fluid">
        <div class="row flex-nowrap">
            <jsp:include page="../Public/jsp/AdminSidebar.jsp"></jsp:include>
            <div class="col py-3">
                <!-- contents here-->
                <br>
                <!-- 신고 리스트 -->
                <div class = "container">
                    <h2>신고 리스트</h2>
                    <table class="table table-hover">
                        <thead class="thead-dark">
                        <tr>
                            <th>RID</th>
                            <th>신고된 아이템명</th>
                            <th>신고자ID</th>
                            <th>담당자</th>
                            <th>작성일</th>
                        </tr>
                        </thead>
                        <tbody>
                            <%
                                sql = "with ordered_repo as( " +
                                        "    select * " +
                                        "    from report " +
                                        "    order by create_date desc)" +
                                        "select * " +
                                        "from ordered_repo left outer join item on ordered_repo.it_id=item.it_id " +
                                        "where rownum<=10";
                                pstmt = conn.prepareStatement(sql);
                                rs = pstmt.executeQuery();
                            %>

                            <% while (rs.next()){ %>
                            <tr style="cursor:pointer;" onclick="location.href='Admin_reportDetail.jsp?report_id=<%=rs.getInt(1)%>'">
                                <td><%=rs.getInt(1)%></td>
                                <td><%=rs.getString(8)%></td>
                                <td><%=rs.getString(3)%></td>
                                <td><%=rs.getString(5)%></td>
                                <td>
                                    <%
                                        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                        Date date = df.parse(rs.getString(6));
                                        df = new SimpleDateFormat("yyyy-MM-dd");
                                        out.print(df.format(date));
                                    %>
                                </td>
                            </tr>
                            <% }
                                pstmt.close();
                                rs.close();
                            %>
                        </tbody>
                    </table>
                    <a class="btn btn-outline-dark pull-right" href="reportList">더보기</a>
                    <br>
                </div>
                <!-- 신고 리스트 -->
            </div>
            <div class="col py-3">
                <br>
                <!-- 회원 관리 -->
                <div class = "container">
                    <h2>가장 많이 신고된 회원</h2>
                    <table class="table table-hover">
                        <thead class="thead-dark">
                        <tr>
                            <th>번호</th>
                            <th>이름</th>
                            <th>ID</th>
                            <th>신고된 횟수</th>
                        </tr>
                        </thead>
                        <tbody>
                            <%
                                sql = "with reported_num as( " +
                                        "    select m.u_id as ruid, count(*) as rnum " +
                                        "    from member m, report r " +
                                        "    where m.u_id=r.u_id " +
                                        "    group by m.u_id) " +
                                        "select rownum, m1, m2, r1 " +
                                        "from(" +
                                        "select m.name as m1, m.u_id as m2, r.rnum as r1 " +
                                        "from member m, reported_num r " +
                                        "where m.u_id=r.ruid " +
                                        "order by r.rnum desc) " +
                                        "where rownum <=15 ";
                                pstmt = conn.prepareStatement(sql);
                                rs = pstmt.executeQuery();
                            %>
                            <% while (rs.next()){ %>
                                <tr style="cursor:pointer;" onclick="location.href='Admin_memberDetail.jsp?uid=<%=rs.getString(3)%>'">
                                    <td><%=rs.getInt(1)%></td>
                                    <td><%=rs.getString(2)%></td>
                                    <td><%=rs.getString(3)%></td>
                                    <td><%=rs.getInt(4)%></td>
                                </tr>
                            <% }
                                conn.close();
                                pstmt.close();
                                rs.close();
                            %>
                        </tbody>
                    </table>
                    <a class="btn btn-outline-dark pull-right" href="memberList">회원관리 페이지-></a>
                    <br>
                </div>
                <!-- 회원 관리 -->
            </div>
        </div>
    </div>
</body>
</html>
