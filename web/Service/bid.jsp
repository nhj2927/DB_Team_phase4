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
            conn.setAutoCommit(false);

            String sql = "SELECT min_bid_unit, current_price, is_end"
                    + " FROM Item"
                    + " WHERE it_id = ?"
                    + " FOR UPDATE";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.valueOf(item_id));
            rs = pstmt.executeQuery();
            if (rs.next()) {
                int min_bid_unit = rs.getInt(1);
                int current_price = rs.getInt(2);
                String is_end = rs.getString(3);

                if(current_price >= Integer.valueOf(price)){ %>
                <script>
                    alert("입찰금액은 현재가보다 높아야 합니다");
                    location.href = "../DetailPage?item_id=" + '<%=item_id%>';
                </script>
                <% } else if((Integer.valueOf(price) - current_price) % min_bid_unit != 0) { %>
                <script>
                    alert("최소 입찰 단위를 맞추세요");
                    location.href = "../DetailPage?item_id=" + '<%=item_id%>';
                </script>
                <% } else if(!is_end.equals("0")) { %>
                <script>
                    alert("거래가 만료되었습니다");
                    location.href = '../';
                </script>
            <% } else {
                sql = "INSERT INTO Bid VALUES(seq_bid.nextval, ?, sysdate, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.valueOf(price));
                pstmt.setString(2, id);
                pstmt.setInt(3, Integer.valueOf(item_id));
                pstmt.executeUpdate();
                pstmt.close();

                sql = "UPDATE Item SET current_price = ?"
                        + " WHERE it_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.valueOf(price));
                pstmt.setInt(2, Integer.valueOf(item_id));
                pstmt.executeUpdate();

                conn.commit(); %>
                <script>
                    alert("입찰에 성공하였습니다");
                    location.href = "../DetailPage?item_id=" + '<%=item_id%>';
                </script>
            <% }
            }
        } catch (Exception e) {
        e.printStackTrace(); %>
        <script>
            alert("입찰에 실패하였습니다");
            location.href = "../DetailPage?item_id=" + '<%=item_id%>';
        </script>
    <% } finally {
        if (conn != null || !conn.isClosed()) {
            conn.setAutoCommit(true);
            conn.close();
        }
        if (pstmt != null || !pstmt.isClosed()) {
            pstmt.close();
        }
        if (rs != null || !rs.isClosed()) {
            rs.close();
        }
    }
} %>