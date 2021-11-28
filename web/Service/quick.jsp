<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    Connection conn = null;
    PreparedStatement pstmt = null;

    String item_id = request.getParameter("item_id");
    String price = request.getParameter("price");
    String id = (String) session.getAttribute("id");

    if (item_id == null || price == null) {
        response.sendRedirect("../");
    } else {
        try {
            Context context = new InitialContext();
            DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
            conn = dataSource.getConnection();

            String sql = "UPDATE Item"
                        + " SET current_price = ?,"
                        + " is_end = 1"
                        + " WHERE it_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.valueOf(price));
            pstmt.setInt(2, Integer.valueOf(item_id));
            pstmt.executeUpdate();
            pstmt.close();

            sql = "INSERT INTO Bid VALUES(seq_bid.nextval, ?, sysdate, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.valueOf(price));
            pstmt.setString(2, id);
            pstmt.setInt(3, Integer.valueOf(item_id));
            pstmt.executeUpdate(); %>
            <script>
                alert("즉시 구매하였습니다");
            </script>
        <% } catch (Exception e) {
            e.printStackTrace(); %>
            <script>
                alert("즉시 구매에 실패하였습니다");
            </script>
        <% } finally {
            conn.close();
            pstmt.close();
        }
    }
%>
<script>
    location.href = "../";
</script>