<%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 2021-11-23
  Time: 오후 8:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Report.Report"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    <title>HiAuction - 신고 리스트</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<jsp:include page="../Public/jsp/AdminHeader.jsp"></jsp:include>
<body>
<%--<%--%>
<%--    Context context = new InitialContext();--%>
<%--    DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");--%>
<%--    Connection conn = dataSource.getConnection();--%>
<%--    String sql = "";--%>
<%--    PreparedStatement pstmt = null;--%>
<%--    ResultSet rs = null;--%>
<%--%>--%>
<div class="container-fluid">
    <div class="row flex-nowrap">
        <jsp:include page="../Public/jsp/AdminSidebar.jsp"></jsp:include>
        <div class="col py-3">
            <br>
            <div class = "container">
                <h2>신고 리스트</h2>
                <table class="table table-hover">
                    <thead class="thead-dark">
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>신고자</th>
                        <th>담당자</th>
                        <th>등록일</th>
                    </tr>
                    </thead>
                    <%
                        Object list = request.getAttribute("reportList");
                    %>
                    <h3> <%=request.getAttribute("test")%> </h3>
                    <tbody>
<%--                        <%--%>
<%--                            sql = "select * from report";--%>
<%--                            pstmt = conn.prepareStatement(sql);--%>
<%--                            rs = pstmt.executeQuery();--%>
<%--                        %>--%>
<%--                        <% while (rs.next()){ %>--%>
<%--                        <tr class="clickable-report-row" style="cursor:pointer;">--%>
<%--                            <td><%=rs.getInt(1)%></td>--%>
<%--                            <td><%=rs.getString(2)%></td>--%>
<%--                            <td><%=rs.getString(4)%></td>--%>
<%--                            <td><%=rs.getString(5)%></td>--%>
<%--                            <td>2021-11-21</td>--%>
<%--                        </tr>--%>
<%--                        <% } %>--%>
                    </tbody>
                </table>
                <br>
                <div>
                    <jsp:include page="paging.jsp">
                        <jsp:param value="${paging.page}" name="page"/>
                        <jsp:param value="${paging.beginPage}" name="beginPage"/>
                        <jsp:param value="${paging.endPage}" name="endPage"/>
                        <jsp:param value="${paging.prev}" name="prev"/>
                        <jsp:param value="${paging.next}" name="next"/>
                    </jsp:include>
                </div>
                <div class="text-center">
                    <ul class="reviews-pagination">
                        <li><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('.clickable-member-row').click(()=>{
        location.href='Admin_memberDetail.jsp'
    })
    $('.clickable-report-row').click(()=>{
        location.href='Admin_reportDetail.jsp'
    })
</script>
</body>
</html>
