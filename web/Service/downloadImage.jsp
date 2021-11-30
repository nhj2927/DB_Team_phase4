<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    InputStream is = null;
    OutputStream os = null;
    File image = null;

    String it_id = request.getParameter("it_id");
    if (it_id != null) {
        try {
            Context context = new InitialContext();
            DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
            conn = dataSource.getConnection();

            String sql = "SELECT img FROM Item WHERE it_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.valueOf(it_id));
            rs = pstmt.executeQuery();

            if (rs.next()) {
                is = rs.getBinaryStream(1);
            }
            response.setContentType("text/html");
            out.clear();
            pageContext.pushBody();
            os = response.getOutputStream();

            int num;
            byte buf[] = new byte[1024];

            if(is.available() == 0){
                String realPath = request.getServletContext().getRealPath("/");
                String rootPath = realPath.substring(0, realPath.indexOf("out"));
                image = new File(rootPath + "web/Public/image/default.png");
                FileInputStream ifo = new FileInputStream(image);
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                while((num = ifo.read(buf)) != -1){
                    baos.write(buf, 0, num);
                }
                byte[] imgbuf = null;
                imgbuf = baos.toByteArray();
                baos.close();
                ifo.close();
                os.write(imgbuf, 0, imgbuf.length);
            } else {
                while ((num = is.read(buf)) != -1) {
                    os.write(buf, 0, num);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (is != null) {
                is.close();
            }
            if (os != null) {
                os.close();
            }
            if (conn != null) {
                conn.close();
            }
            if (rs != null) {
                rs.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
        }
    }
%>