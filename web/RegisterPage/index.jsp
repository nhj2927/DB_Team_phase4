<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ArrayList addressOptions = null;
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

    <!-- Font Awesome Icon -->
    <link rel="stylesheet" href="../Public/css/font-awesome.min.css">

    <!-- Custom stlylesheet -->
    <link rel="stylesheet" href="./style.css"/>

    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>Register</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    String id = request.getParameter("id");
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    String name = request.getParameter("name");
    String tel = request.getParameter("tel");
    String description = request.getParameter("description");
    String[] addressList = request.getParameterValues("address");

    Set s = new HashSet<String>();
    if (addressList != null) {
        for (String address : addressList) {
            if (!address.equals("선택안함")) {
                s.add(address);
            }
        }
    }

    Context context = new InitialContext();
    DataSource dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
    conn = dataSource.getConnection();

    if (id != null) {
        try {
            String sql = "SELECT COUNT(*) FROM Member"
                    + " WHERE U_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                if (rs.getInt(1) == 1) { %>
                    <script>
                        alert("아이디 중복");
                        location.href = './';
                    </script>
                <% } else {
                    pstmt.close();
                    rs.close();
                    sql = "INSERT INTO Member(u_id, pw, name, description, tel, email)"
                            + " VALUES(?, ?, ?, ?, ?, ?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, id);
                    pstmt.setString(2, password);
                    pstmt.setString(3, name);
                    pstmt.setString(4, description);
                    pstmt.setString(5, tel);
                    pstmt.setString(6, email);

                    int count = pstmt.executeUpdate();
                    if (count == 1) {
                        pstmt.close();
                        rs.close();
                        sql = "INSERT INTO LIVES_IN"
                                + " VALUES(?, (SELECT ad_id FROM Address WHERE name = ?))";
                        pstmt = conn.prepareStatement(sql);
                        for (Iterator<String> it = s.iterator(); it.hasNext(); ) {
                            String address = it.next();
                            pstmt.setString(1, id);
                            pstmt.setString(2, address);
                            pstmt.executeUpdate();
                        }
                        session.setAttribute("id", id);
                        session.setAttribute("name", name);
                        session.setAttribute("description", description);
                        session.setAttribute("average_score", 0);
                        session.setAttribute("tel", tel);
                        session.setAttribute("email", email);
                        session.setAttribute("address", s.toArray(new String[0])); %>
                        <script>
                            alert("회원가입에 성공하였습니다");
                            location.href = '../';
                        </script>
                    <% } else { %>
                        <script>
                            alert("회원가입에 실패하였습니다");
                        </script>
                    <% }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
            pstmt.close();
            rs.close();
        }
    } else {
        try {
            addressOptions = new ArrayList<String>();
            pstmt = conn.prepareStatement("SELECT name FROM Address");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                addressOptions.add(rs.getString(1));
            }
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            conn.close();
            pstmt.close();
            rs.close();
        }
        %>
        <div style="display: flex;flex-direction:row; justify-content: center; margin-top:50px">
            <div class="header-logo">
                <a href="/DB_Team_phase4_war_exploded/" class="logo">
                    <img src="/DB_Team_phase4_war_exploded/Public/image/HiAuction-logos_black.png" alt="" style="width: 400px;">
                </a>
            </div>
        </div>
        <div class="container-fluid">
            <div class="border form-wrapper">
                <form class="form-register" action="./" method="post">
                    <div class="mb-3">
                        <label for="inputId" class="form-label">아이디</label>
                        <input type="text" class="form-control" name="id" id="inputId">
                    </div>
                    <div class="mb-3">
                        <label for="inputTel" class="form-label">연락처(-없이)</label>
                        <input type="text" class="form-control" name="tel" id="inputTel" aria-describedby="telHelp">
                    </div>
                    <div class="mb-3">
                        <label for="inputEmail" class="form-label">이메일</label>
                        <input type="email" class="form-control" name="email" id="inputEmail" aria-describedby="emailHelp">
                    </div>
                    <div class="mb-3">
                        <label for="inputName" class="form-label">이름</label>
                        <input type="text" class="form-control" name="name" id="inputName">
                    </div>
                    <div class="mb-3">
                        <label for="inputPassword" class="form-label">비밀번호</label>
                        <input type="password" class="form-control" name="password" id="inputPassword">
                    </div>
                    <div class="mb-3" data-bs-toggle="modal" data-bs-target="#exampleModal">
                        <label for="description" class="form-label">한줄 소개</label>
                        <input type="text" class="form-control" name="description" id="description">
                    </div>
                    <div class="mb-3" data-bs-toggle="modal" data-bs-target="#exampleModal">
                        <label class="form-label">주소(최대 3개)</label>
                        <div class="row g-3">
                            <div class="col">
                                <select class="form-select" name="address" aria-label="Default select example">
                                    <option selected>선택안함</option>
                                    <% for (Object address: addressOptions){ %>
                                        <option vale="<%=(String)address%>"><%=(String)address%></option>
                                   <% } %>
                                </select>
                            </div>
                            <div class="col">
                                <select class="form-select" name="address" aria-label="Default select example">
                                    <option selected>선택안함</option>
                                    <% for (Object address: addressOptions){ %>
                                    <option vale="<%=(String)address%>"><%=(String)address%></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="col">
                                <select class="form-select" name="address" aria-label="Default select example">
                                    <option selected>선택안함</option>
                                    <% for (Object address: addressOptions){ %>
                                    <option vale="<%=(String)address%>"><%=(String)address%></option>
                                    <% } %>
                                </select>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="register btn btn-primary">회원가입</button>
                </form>
            </div>
        </div>
    <%}%>
</body>
</html>
