<%@ page import="com.example.board_v1_0.PostDTO" %>
<%@ page import="com.example.board_v1_0.PostDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="multipart/form-data" ; charset=UTF-8">
    <meta name="viewport" content="width=device-width" , inital-scale="1">
    <title>게시판 - 등록</title>
    <%--bootstrap 적용--%>
    <link rel="stylesheet" href="/webjars/bootstrap/5.1.3/css/bootstrap.css">

</head>
<%
    Long postId = Long.valueOf(request.getParameter("id"));
    PostDAO postDAO = PostDAO.getInstance();
    PostDTO post = postDAO.getPost(postId);

%>
<body>
<div class="container">
    <h1>게시판 - 보기</h1>
    <br>
</div>
<div class="container">
    <div class="container">
        <span><%=post.getAuthor()%></span>
        <span class="float-end">
            등록일시 <%=post.getCreatedDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"))%>
            &nbsp 수정일시
        <%
            if (post.getCreatedDate() != null) {
                out.println(post.getCreatedDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")));
            }
        %>
        </span>
    </div>
    <br>
    <div class="container" style="border: black">
        <span style="font-size: 20px;">[<%=post.getCategory()%>]    <%=post.getTitle()%>
        </span>
        <span class="float-end">조회수: <%=post.getHits()%></span>
    </div>
    <br>
    <div class="container border-secondary">
        <textarea class="form-text"><%=post.getContent()%></textarea>
    </div>
    <br>
    <div class="container">
        <a href=""
    </div>

</div>
<hr>
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
                alert("서버 유효성 검사에서 입력조건 오류 발생", e);
            },
            success: function () {
                console.log("success");
                alert("저장 성공");
                window.location.href = "/boards/free/list.jsp"
            }
        });

        return;
    });
</script>
</body>
</html>
