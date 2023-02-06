<%@ page import="com.example.board_v1_0.PostDTO" %>
<%@ page import="com.example.board_v1_0.PostDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시판 - 등록</title>
    <script type="text/javascript">
    </script>
</head>
<%
    PostDAO postDAO = PostDAO.getInstance();
    List<PostDTO> categoryList;
    try {
        categoryList = postDAO.getCategoryList();
    } catch (SQLException | ClassNotFoundException e) {
        throw new RuntimeException(e);
    }
%>
<body>
<h1>게시판 - 등록</h1>
<br>
<br>
<form name="write" method="post" action="insert.jsp">
    <table>
        <tr>
            <td>&nbsp;</td>
            <td>카테고리</td>
            <td>
                <select name="category" name="category">
                    <option value="">전체 카테고리</option>
                    <%
                        for (PostDTO postDTO : categoryList) {
                            String category = postDTO.getCategory();
                            out.println("<option value=" + category + ">" + category + "</option>");
                        }
                    %>
                </select>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>작성자</td>
            <td><input name="name" size="25" maxlength="100"></td>
            <td>&nbsp;</td>
        </tr>
        <tr height="1">
            <td colspan="4"></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>비밀번호</td>
            <td><input name="passwd" value="비밀번호" maxlength="16">&nbsp<input name="check_passwd" value="비밀번호 확인"
                                                                             maxlength="16"></td>
            <td>&nbsp;</td>
        </tr>
        <tr height="1">
            <td colspan="4"></td>
        </tr>
        <tr>
            <td>&nbsp</td>
            <td>제목</td>
            <td><input name="title" size="120" maxlength="100"></td>
            <td>&nbsp</td>
        </tr>
        <tr height="1">
            <td colspan="4"></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>내용</td>
            <td><textarea name="content" cols="100" rows="20" maxlength="2000"></textarea></td>
            <td>&nbsp;</td>
        </tr>
        <br><br>
        <tr>
            <td colspan="4"><input type="button" onclick="location.href='/boards/free/list.jsp';" value="취소"></td>
            <td colspan="4"></td>
            <td><input type="submit" value="저장"></td>
        </tr>
    </table>
</form>
</body>
</html>
