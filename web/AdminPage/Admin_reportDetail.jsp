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
    <link type="text/css" rel="stylesheet" href="../Public/css/reportDetail.css"/>
    <title>HiAuction - 신고 내용</title>
</head>
<jsp:include page="../Public/jsp/AdminHeader.jsp"></jsp:include>
<%
    int report_id = Integer.parseInt(request.getParameter("report_id"));
    Context context = new InitialContext();
    DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
    Connection conn = dataSource.getConnection();
    String sql = "select i.name,r.u_id,r.admin_id,r.create_date,r.description,i.it_id from report r, item i where r.it_id = i.it_id and r.report_id=?";
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, report_id);
    rs = pstmt.executeQuery();
    rs.next();
%>
<body>
    <div class="container-fluid">
        <div class="row flex-nowrap">
            <jsp:include page="../Public/jsp/AdminSidebar.jsp"></jsp:include>
            <div class="col py-3">
                <br>
                <div class="container-sm">
                    <article>
                        <!-- Post header-->
                        <header class="mb-4">
                            <!-- Post title-->
                            <h2 class="fw-bolder mb-1">신고 상세 내용</h2>
                            <h6>아이템명 : <%=rs.getString(1)%></h6>
                            <hr/>
                            <!-- Post meta content-->
                            <div class="kboard-detail">
                                <div class="detail-attr">
                                    <div class="detail-name">신고자ID</div>
                                    <div class="detail-value"><%=rs.getString(2)%></div>
                                </div>
                                <div class="detail-attr">
                                    <div class="detail-name">담당자</div>
                                    <div class="detail-value"><%=rs.getString(3)%></div>
                                </div>
                                <div class="detail-attr">
                                    <div class="detail-name">작성일</div>
                                    <div class="detail-value"><%=rs.getString(4)%></div>
                                </div>
                            </div>
                            <!-- Post meta content-->
                        </header>
                        <!-- Post content-->
                        <section class="mb-5 wrap_content">
                            <p class="fs-6 mb-4">
                                <%=rs.getString(5)%>
                            </p>
                        </section>
                    </article>
                    <hr/>
                    <!-- Buttons -->
                    <div>
                        <button class="btn btn-primary" onclick="location.href='../DetailPage?item_id=<%=rs.getInt(6)%>'">게시글 확인</button>
                        <% if(rs.getString(3).equals(session.getAttribute("id").toString())){ %>
                            <button id="DelReport" class="btn btn-danger" onclick="location.href='DelReportAction.jsp?report_id=<%=report_id%>'">리포트 삭제</button>
                            <button id="DelItem"class="btn btn-danger" onclick="location.href='DelItemAction.jsp?it_id=<%=rs.getInt(6)%>'">게시글 삭제</button>
                        <%}%>
                        <button class="btn btn-secondary" onclick="history.back()">뒤로 가기</button>
                    </div>
                    <!-- Buttons -->
                    <%
                        rs.close();
                        pstmt.close();
                        conn.close();
                    %>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
