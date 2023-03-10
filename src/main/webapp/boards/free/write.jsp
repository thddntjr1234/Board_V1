<%@ page import="com.example.board_v1_0.Post.PostDTO" %>
<%@ page import="com.example.board_v1_0.Post.PostDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="multipart/form-data" ; charset=UTF-8">
    <meta name="viewport" content="width=device-width" , inital-scale="1">
    <title>게시판 - 등록</title>
    <%--bootstrap 적용--%>
    <link rel="stylesheet" href="/webjars/bootstrap/5.1.3/css/bootstrap.css">

    <%--  프론트/ajax로 유효성 검사  --%>
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
<div class="container">
    <h1>게시판 - 등록</h1>
</div>
<br>
<div class="container">
    <form class="form-control" id="boardForm" name="write">
        <table class="table">
            <tr>
                <td colspan="2">카테고리</td>
                <td>
                    <select class="form-select-sm" name="category" name="category" required>
                        <option value="">카테고리 선택</option>
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
                <td colspan="2">작성자</td>
                <td><input class="form-text" id="input_author" name="author" required></td>
            </tr>
            <tr>
                <td colspan="2">비밀번호</td>
                <td>
                    <input type="password" id="input_passwd1" class="form-control-sm" name="passwd" placeholder="비밀번호" required>&nbsp
                    <input type="password" id="input_passwd2" class="form-control-sm" name="passwdCheck"
                           placeholder="비밀번호 확인" required>
                </td>
            </tr>
            <tr>
                <td colspan="2">제목</td>
                <td><input class="form-text" id="input_title" name="title" size="100" required></td>
            </tr>
            <tr>
                <td colspan="2">내용</td>
                <td><textarea class="form-text" id="input_content" name="content" cols="100" rows="20" required></textarea></td>
            </tr>
            <tr>
                <td colspan="2" rowspan="3">파일 첨부</td>
                <td>
                    <div class="form-control"><input type="file" name="file1"></div>
                    <div class="form-control"><input type="file" name="file2"></div>
                    <div class="form-control"><input type="file" name="file3"></div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <button class="btn btn-secondary" onclick="location.href='/boards/free/list.jsp';">취소</button>
                </td>
                <td>
                    <button class="btn btn-secondary" type="submit" id="btnSubmit">저장</button>
                </td>
            </tr>
        </table>
    </form>
</div>

<%--bootstrap, jquery--%>
<script src="/webjars/jquery/3.3.1/jquery.min.js"></script>
<script src="/webjars/bootstrap/5.1.3/js/bootstrap.min.js"></script>
<script>
    $(function () {
        console.log("jquery 동작");
    })
    $("#boardForm").on("submit", function (event) {
        event.preventDefault();

        let authorLength = $("#input_author").val().length;
        if (authorLength < 3 || authorLength >= 5) {
            alert("작성자명은 3글자 이상, 5글자 미만이어야 합니다.");
            return;
        }
        console.log("작성자명 조건 통과");

        let initPasswd = $("#input_passwd1").val();
        if (!initPasswd.match(/^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{4,15}$/)) {
            alert("패스워드는 영문, 숫자, 특수문자를 포함한 4글자 이상, 16글자 미만이어야 합니다.");
            return;
        }
        if ($("#input_passwd1").val() !== $("#input_passwd2").val()) {
            alert("비밀번호와 비밀번호 확인에 입력한 비밀번호가 일치하지 않습니다.");
            return;
        }
        console.log("패스워드 조건 통과");

        let titleLength = $("#input_title").val().length;
        if (titleLength < 4 || titleLength >= 100) {
            alert("제목은 4글자 이상, 100글자 미만이어야 합니다.");
            return;
        }
        console.log("제목명 조건 통과");

        let contentLength = $("#input_content").val().length;
        if (contentLength < 4 || contentLength >= 2000) {
            alert("내용은 4글자 이상, 2000글자 미만이어야 합니다");
            return;
        }
        console.log("내용 조건 통과");

        console.log("유효성 검사 통과, ajax로 서버사이드 유효성 검증 실행");
        // 이 라인까지 도달했으면 front에서의 유효성 검증은 종료, 서버에 ajax로 writeAction.jsp 호출해서 현재 페이지에서 검증 후 db insert
        let form = $("#boardForm")[0];
        let formData = new FormData(form);

        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            url: "/boards/free/writeAction.jsp",
            async: false,
            data: formData,
            error: function (e) {
                alert(e);
            },
            success: function () {
                console.log("success");
                alert("저장 성공");
                window.location.href="/boards/free/list.jsp"
            }
        });

        return;
    });
</script>
</body>
</html>
