<%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 2021-11-29
  Time: 오후 7:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Context context = new InitialContext();
    DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
    Connection conn = dataSource.getConnection();
    String sql = "";
    PreparedStatement pstmt = null;
    String memberID = request.getParameter("u_id");

    sql = "delete from member where u_id=?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1,memberID);
    pstmt.executeUpdate();
    pstmt.close();

    //삭제한 회원이 입찰한 아이템의 current price 변경하기
    sql = "with tmp as( " +
            "    select distinct i.it_id as itid" +
            "    from item i , bid b " +
            "    where i.it_id = b.it_id " +
            "    and i.is_end=0"+
            "    and b.u_id = ?)" +
            "select MAX(b.price), tmp.itid " +
            "from tmp, bid b " +
            "where tmp.itid=b.it_id " +
            "and b.u_id is not null " +
            "group by tmp.itid, tmp.sp ";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, memberID);
    ResultSet rs = pstmt.executeQuery();
    pstmt.close();

    sql = "UPDATE ITEM SET Current_price = ? WHERE it_id = ?";
    pstmt = conn.prepareStatement(sql);

    while(rs.next()){
        pstmt.setInt(1, rs.getInt(1));
        pstmt.setInt(2, rs.getInt(2));
        pstmt.addBatch();
        pstmt.clearParameters();
    }
    pstmt.executeBatch();

    conn.close();
    pstmt.close();
    rs.close();
%>
<script>
    location.href="memberList"
</script>
