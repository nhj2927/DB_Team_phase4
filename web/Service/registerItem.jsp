<%@ page import="java.io.File" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.sql.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    request.setCharacterEncoding("utf-8");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    Collection<Part> parts = request.getParts();
    String id = (String) session.getAttribute("id");
    String name = null;
    String description = null;
    String start = null;
    String min = null;
    String quick = null;
    String expired = null;
    String c_id = null;
    String address = null;
    InputStream image = null;
    ArrayList adminList = new ArrayList<String>();
    Random random = new Random();
    random.setSeed(System.currentTimeMillis());

    for (Part part : parts) {
        if (part.getHeader("Content-Disposition").contains("filename=")) {
            if (part.getSize() > 0) {
                image = part.getInputStream();
            }
        } else {
            switch (part.getName()) {
                case "name":
                    name = request.getParameter(part.getName());
                    break;
                case "description":
                    description = request.getParameter(part.getName());
                    break;
                case "start":
                    start = request.getParameter(part.getName());
                    break;
                case "min":
                    min = request.getParameter(part.getName());
                    break;
                case "quick":
                    quick = request.getParameter(part.getName());
                    break;
                case "expired":
                    expired = request.getParameter(part.getName());
                    break;
                case "c_id":
                    c_id = request.getParameter(part.getName());
                    break;
                case "address":
                    address = request.getParameter(part.getName());
                    break;
            }
        }
    }

    try {
        Context context = new InitialContext();
        DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
        conn = dataSource.getConnection();

        String sql = "SELECT admin_id FROM ADMIN";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            adminList.add(rs.getString(1));
        }
        pstmt.close();
        rs.close();

        sql = "INSERT INTO ITEM(it_id, name, description,"
                + " min_bid_unit, quick_price, current_price,"
                + " expire_date, start_price, img, c_id,"
                + " u_id, admin_id, ad_id)"
                + " VALUES (SEQ_ITEM.NEXTVAL, ?, ?,"
                + " ?, ?, ?,"
                + " ?, ?, ?, ?,"
                + " ?, ?, (SELECT ad_id FROM Address"
                        +  " WHERE name = ?))";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, description);
        pstmt.setInt(3, Integer.valueOf(min));
        pstmt.setInt(4, Integer.valueOf(quick));
        pstmt.setInt(5, Integer.valueOf(start));
        pstmt.setDate(6, Date.valueOf(expired));
        pstmt.setInt(7, Integer.valueOf(start));
        pstmt.setBinaryStream(8, image);
        pstmt.setInt(9, Integer.valueOf(c_id));
        pstmt.setString(10, id);
        pstmt.setString(11, (String) adminList.get(random.nextInt(adminList.size())));
        pstmt.setString(12, address);
        pstmt.executeUpdate(); %>
        <script>
            alert("상품을 등록하였습니다");
        </script>
    <% } catch (Exception e) {
        e.printStackTrace(); %>
        <script>
            alert("상품등록에 실패하였습니다");
        </script>
    <% } finally {
        if (conn != null) {
            conn.close();
        }
        if (pstmt != null) {
            pstmt.close();
        }
    } %>
<script>
    location.href = '../';
</script>
