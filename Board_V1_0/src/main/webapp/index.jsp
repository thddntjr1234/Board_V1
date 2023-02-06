<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.example.board_v1_0.PostDAO" %>
<%@ page import="com.example.board_v1_0.PostDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    PostDAO postDAO = PostDAO.getInstance();
    List<PostDTO> categoryList = null;
    try {
        categoryList = postDAO.getCategoryList();
    } catch (SQLException | ClassNotFoundException e) {
        throw new RuntimeException(e);
    }

//    try {
//        String url = "jdbc:mariadb://localhost:3306/board_v1";
//        String userName = "root";
//        String password = "0927";
//        Class.forName("org.mariadb.jdbc.Driver");
//        System.out.println("드라이버가 로딩됨");
//        Connection connection = DriverManager.getConnection(url, userName, password);
//    } catch (Exception e) {
//        e.printStackTrace();
//        System.out.println("드라이버가 로딩되지 않음");
//    }
//    final String driver = "org.mariadb.jdbc.Driver";
//    final String DB_IP = "localhost";
//    final String DB_PORT = "3306";
//    final String DB_NAME = "board_v1";
//    final String DB_URL =
//            "jdbc:mariadb://" + DB_IP + ":" + DB_PORT + "/" + DB_NAME;


//    try {
//        Class.forName(driver);
//        conn = DriverManager.getConnection(DB_URL, "root", "0927");
//        if (conn != null) {
//            System.out.println("DB 접속 성공");
//        }
//
//    } catch (ClassNotFoundException e) {
//        System.out.println("드라이버 로드 실패");
//        e.printStackTrace();
//    } catch (SQLException e) {
//        System.out.println("DB 접속 실패");
//        e.printStackTrace();
//    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<h1><%= "Hello World!" %>
</h1>
<br/>
<%
//    for (PostDTO post : categoryList) {
//        javax.servlet.jsp.JspWriter
//        out.write("    <tr>");
//        out.write("        <td>" + post.getCategory() + "</td>");
//        out.write("    </tr>");
//    }

%>
<script>
    location.href = '/boards/free/list.jsp';
</script>

</body>
</html>