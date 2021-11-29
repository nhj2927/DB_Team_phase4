<%@ page import="vo.Member" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %><%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 2021-11-23
  Time: 오후 8:01
  To change this template use File | Settings | File Templates.
--%>
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
    <title>HiAuction - 회원관리</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<jsp:include page="../Public/jsp/AdminHeader.jsp"></jsp:include>
<body>
<div class="container-fluid">
    <div class="row flex-nowrap">
        <jsp:include page="../Public/jsp/AdminSidebar.jsp"></jsp:include>
        <div class="col py-3">
            <br>
            <div class = "container">
                <h2>회원 관리</h2>
                <h6>총 회원수 : <%=request.getAttribute("totalcount")%></h6>
                <table class="table table-hover">
                    <thead class="thead-dark">
                    <tr>
                        <th>번호</th>
                        <th>이름</th>
                        <th>ID</th>
                        <th>EMAIL</th>
                        <th>평균 점수</th>
                        <th>신고된 횟수</th>
                    </tr>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<Member> reports = (ArrayList<Member>) request.getAttribute("reportList");
                            Iterator<Member> iterator = reports.iterator();
                            int totalcount = (int)request.getAttribute("totalcount");
                            int cur_page = 1;
                            if(request.getParameter("page") != null){
                                cur_page = Integer.parseInt(request.getParameter("page"));
                            }
                            totalcount = totalcount-((cur_page-1)*10);
                            while(iterator.hasNext()){
                                Member tmp = iterator.next();
                        %>
                        <tr style="cursor:pointer;" onclick="location.href='Admin_memberDetail.jsp?uid=<%=tmp.getU_id()%>'">
                            <td><%=totalcount--%></td>
                            <td><%=tmp.getName()%></td>
                            <td><%=tmp.getU_id()%></td>
                            <td><%=tmp.getEmail()%></td>
                            <td><%=tmp.getAverage_score()%></td>
                            <td><%=tmp.getReported_num()%></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                <br>
                <div>
                    <jsp:include page="memberlist_paging.jsp">
                        <jsp:param value="${paging.page}" name="page"/>
                        <jsp:param value="${paging.beginPage}" name="beginPage"/>
                        <jsp:param value="${paging.endPage}" name="endPage"/>
                        <jsp:param value="${paging.prev}" name="prev"/>
                        <jsp:param value="${paging.next}" name="next"/>
                    </jsp:include>
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
