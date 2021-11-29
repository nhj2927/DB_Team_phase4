<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Random" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String item_id = request.getParameter("item_id");
    String content = request.getParameter("content");
    String id = (String) session.getAttribute("id");
    ArrayList adminList = new ArrayList<String>();
    Random random = new Random();
    random.setSeed(System.currentTimeMillis());

    if (item_id == null) {
        response.sendRedirect("../");
    } else {
        try {
            Context context = new InitialContext();
            DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
            conn = dataSource.getConnection();

            String sql = "SELECT admin_id FROM Admin";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while(rs.next()){
                adminList.add(rs.getString(1));
            }
            pstmt.close();
            rs.close();

            sql = "INSERT INTO Report VALUES(seq_report.nextval, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, content);
            pstmt.setString(2, id);
            pstmt.setInt(3, Integer.valueOf(item_id));
            pstmt.setString(4, (String) adminList.get(random.nextInt(adminList.size())));
            pstmt.executeUpdate(); %>
            <script>
                    alert("신고되었습니다");
            </script>
        <% } catch (Exception e) {
            e.printStackTrace(); %>
            <script>
                alert("신고 실패하였습니다");
            </script>
        <% } finally {
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
    }
%>
<script>
    location.href = "../DetailPage?item_id=" + '<%=item_id%>';
</script>