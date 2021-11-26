<%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 2021-11-25
  Time: 오후 6:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <link type="text/css" rel="stylesheet" href="../Public/css/style.css"/>
</head>
<body>
    <div class="text-center">
        <ul class="reviews-pagination">
            <!-- 1~10까지 있는 페이지의 페이징 -->
            <c:url var="action" value="/AdminPage/reportList"/>
            <c:if test="${param.prev}">
                <li><a href="${action}?page=${param.beginPage-1}">prev</a></li>
            </c:if>
            <c:forEach begin="${param.beginPage}" end="${param.endPage}" step="1" var="index">
                <c:choose>
                    <c:when test="${param.page==index}">
                        ${index}
                    </c:when>
                    <c:otherwise>
                        <li><a href="${action}?page=${index}">${index}</a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${param.next}">
                <li><a href="${action}?page=${param.endPage+1}">next</a></li>
            </c:if>
        </ul>
    </div>
</body>
</html>

