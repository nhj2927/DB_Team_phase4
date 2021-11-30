<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String[] category_images = {"digital.png", "house_appliances.png", "furniture.png",
            "child.png", "processed_food.png", "child_book.png", "sports.png", "woman_general_merchandise.png",
            "woman_cloth.png", "man_cloth.png", "game.png", "beauty.png",
            "pet.png", "ticket.png", "flower.png"};
    String[] category_name = {"디지털기기", "생활가전", "가구/인테리어", "유아동", "생활/가공식품",
            "유아도서", "스포츠/레저", "여성잡화", "여성의류", "남성패션/잡화",
            "게임/취미", "뷰티/미용", "반려동물", "도서/티켓/음반", "식물"};
    String category_id = null;
    String address = null;
    String current_page = null;
    String search = null;
    Integer total_page = null;
%>
<html>
<head>
    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
            crossorigin="anonymous"></script>

    <!-- Slick -->
    <link type="text/css" rel="stylesheet" href="./Public/css/slick.css"/>
    <link type="text/css" rel="stylesheet" href="./Public/css/slick-theme.css"/>

    <!-- nouislider -->
    <link type="text/css" rel="stylesheet" href="./Public/css/nouislider.min.css"/>

    <!-- Font Awesome Icon -->
    <link rel="stylesheet" href="./Public/css/font-awesome.min.css">

    <!-- Custom stlylesheet -->
    <link type="text/css" rel="stylesheet" href="./Public/css/style.css"/>
    <link rel="stylesheet" href="./style.css"/>

    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>Main</title>
</head>
<body>
<%
    String[] addressList = (String[]) session.getAttribute("address");
    if (addressList == null || addressList.length == 0) { %>
<script>location.href = "./LoginPage/index.jsp"</script>
<% } else {
    address = request.getParameter("address");
    if (address == null) {
        address = addressList[0];
    }
    category_id = request.getParameter("category_id");
    if (category_id == null) {
        category_id = "1";
    }
    current_page = request.getParameter("page");
    if (current_page == null) {
        current_page = "1";
    }
    search = request.getParameter("search");

    try {
        Context context = new InitialContext();
        DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
        conn = dataSource.getConnection();

        String sql = "UPDATE Item SET is_end = '2'"
                    + " WHERE expire_date < SYSDATE";
        pstmt = conn.prepareStatement(sql);
        pstmt.executeUpdate();
        pstmt.close();

        sql = "SELECT COUNT(*) FROM Item"
                + " WHERE c_id = ?"
                + " AND ad_id = (SELECT ad_id FROM Address"
                + " WHERE name = ?)"
                + " AND is_end = '0'";
        if (search != null) {
            sql += " AND LOWER(name) LIKE '%" + search + "%'";
        }
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, category_id);
        pstmt.setString(2, address);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            int count = rs.getInt(1);
            total_page = (count - 1) / 8 + 1;
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        pstmt.close();
        rs.close();
    }
%>
<jsp:include page="./Public/jsp/Header.jsp">
    <jsp:param name="address" value="<%=address%>"/>
    <jsp:param name="category_id" value="<%=category_id%>"/>
</jsp:include>
<div class="container">
    <div class="category mt-3">
        <% for (int i = 0; i < category_name.length; i++) { %>
        <div class="item" onclick="selectCategory('<%=i+1%>', '<%=address%>')">
            <img src="Public/image/<%=category_images[i]%>" class="item-img"/>
            <div><%=category_name[i]%>
            </div>
        </div>
        <% } %>
    </div>
    <div class="select-wrapper">
        <select class="address-select form-select" aria-label="Default select example">
            <% for (int i = 0; i < addressList.length; i++) { %>
            <option value="<%=addressList[i]%>"
                    <% if (address.equals(addressList[i])) { %>
                    selected
                    <% } %>
            ><%=addressList[i]%>
            </option>
            <% } %>
        </select>
        <div class="category-name" onclick="registerItem()">
            <%=category_name[Integer.valueOf(category_id) - 1]%>
            <span class="item-reg">
                <i class="fa fa-plus" aria-hidden="true"></i>
                아이템 등록
            </span>
        </div>
    </div>
    <%
        try {
            String sql = "SELECT * FROM (SELECT name, current_price, quick_price,"
                    + " bid_count, expire_date, it_id, rownum as rnum, create_date FROM ("
                    + " SELECT * FROM Item "
                    + " WHERE c_id = ?"
                    + " AND ad_id = (SELECT ad_id FROM Address"
                    + " WHERE name = ?)"
                    + " AND expire_date > sysdate"
                    + " AND is_end = 0"
                    + " ORDER BY create_date DESC))"
                    + " WHERE rnum BETWEEN ? AND ?";
            if (search != null) {
                sql += " AND LOWER(name) LIKE '%" + search + "%'";
            }
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, category_id);
            pstmt.setString(2, address);
            pstmt.setInt(3, 8 * (Integer.valueOf(current_page) - 1) + 1);
            pstmt.setInt(4, 8 * (Integer.valueOf(current_page)));
            rs = pstmt.executeQuery();
            int count = 0;
            while (rs.next()) {
                if (count % 4 == 0) { %>
    <div class="item-wrapper row mt-5">
        <% } %>
        <div class="item card col" onclick="selectItem('<%=rs.getInt(6)%>')">
            <img src="./Service/downloadImage.jsp?it_id=<%=rs.getInt(6)%>" class="card-img-top"
                 style="height: 45%"/>
            <div class="card-body align-center">
                <div class="item-name"><%=rs.getString(1)%>
                </div>
                <div class="current-price">현재가: <%=rs.getInt(2)%>원</div>
                <div>즉시구매가: <%=rs.getInt(3)%>원</div>
                <div>입찰수: <%=rs.getInt(4)%>
                </div>
                <div>만료일: <%=rs.getDate(5)%>
                </div>
            </div>
        </div>
        <% if (count % 4 == 3) { %>
    </div>
    <% }
        count++; %>
    <% }
        if (count % 4 != 0 && count > 0) { %>
</div>
<% }
} catch (Exception e) {
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
%>
<nav class="mt-5 mb-5" aria-label="Page navigation example">
    <ul class="pagination justify-content-center">
        <% for (int i = 0; i < total_page; i++) { %>
        <li class="page-item" onclick="selectPage('<%=i + 1%>')">
            <a class="page-link"><%=i + 1%>
            </a>
        </li>
        <% } %>
    </ul>
</nav>
<script>
    const selectCategory = (category_id, address) => {
        location.href = './?category_id=' + category_id + '&address=' + address;
    }
    const selectPage = (page) => {
        let url = './?category_id=' + '<%=category_id%>'
            + '&address=' + '<%=address%>' + '&page=' + page;
        if ('<%=search%>' !== 'null') {
            url += '&search=' + '<%=search%>';
        }
        location.href = url;
    }
    const selectItem = (item_id) => {
        location.href = './DetailPage?item_id=' + item_id;
    }
    const registerItem = () => {
        location.href = './RegisterItemPage';
    }
    $('.address-select').change(() => {
        location.href = './?category_id=' + '<%=category_id%>'
            + '&address=' + $('.address-select option:selected').val()
            + '&page=' + '<%=current_page%>';
    });
</script>
</div>
<% } %>
</body>
</html>
