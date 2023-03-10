<%@ page import="com.example.board_v1_0.Post.PostDTO" %>
<%@ page import="com.example.board_v1_0.Post.PostDAO" %><%--
  Created by IntelliJ IDEA.
  User: wooseok
  Date: 2023/02/05
  Time: 5:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<%
    String operation = request.getParameter("operation");
    Long postId = Long.parseLong(request.getParameter("postId"));

    PostDAO postDAO = PostDAO.getInstance();
    PostDTO post = postDAO.getPost(postId);

%>
<body>
<div class="d-flex justify-content-lg-center">
    <table class="table d-flex justify-content-lg-center">
        <form class="form-control-lg" id="passwdValidForm">
            <tr>
                <td> 비밀번호</td>
                <td>
                    <input class="form-control-lg" type="password" id="inputPasswd" name="inputPasswd">
                </td>
            </tr>
            <tr>
                <td>
                    <button class="btn btn-primary" onclick="location.href='/boards/free/list.jsp'">취소</button>
<%--                    <button class="btn btn-secondary" onclick="location.href='/boards/free/<%=operation%>.jsp?postId=<%=postId%>'">확인</button>--%>
                    <button class="btn btn-secondary" onclick="function(">확인</button>
                </td>
            </tr>
        </form>
    </table>
</div>
<script>
    function chekcPassword(postId, password, operation) {

        let formData = $("#passwdValidForm").serialize();
        formData += "&postId=" + postId;
        console.log("formdata = ", formData);
        $.ajax({
            type: "POST",
            url: "/boards/free/checkPwdAction.jsp",
            data: formData,
            error: function (e) {
                alert("전송 실패", e);
            },
            success: function () {
                alert("패스워드 확인 완료");
                window.location.href = "/boards/free/" + operation + ".jsp?postId=" + postId;
            }
        });
    }
</script>
</body>
</html>
