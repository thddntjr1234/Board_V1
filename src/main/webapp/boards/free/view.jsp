<%@ page import="com.example.board_v1_0.PostDTO" %>
<%@ page import="com.example.board_v1_0.PostDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
현<%@ page import="java.io.File" %>
<%@ page import="com.example.board_v1_0.FileDAO" %>
<%@ page import="com.example.board_v1_0.FileDTO" %>
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
    request.setCharacterEncoding("utf-8");

    Long postId = Long.valueOf(request.getParameter("id"));
    PostDAO postDAO = PostDAO.getInstance();
    PostDTO post = postDAO.getPost(postId);

    FileDAO fileDAO = FileDAO.getInstance();
    List<FileDTO> files = fileDAO.getFileNames(post.getId());
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
    <div class="container\">
        <p class="text-md-start" style="font-size: 14px;"><%=post.getContent().replaceAll("\r\n", "<br>")%>
        </p>
    </div>
    <br>
    <div class="container">
        <%
            for (FileDTO file : files) {
                out.println("<div><a href=\"#\" onclick=\"DownloadFile(\'" + file.getFileName() + "\')" + "\">" + file.getFileRealName() + "</a></div>");
            }
        %>
    </div>
</div>
<hr>
</div>


<%--bootstrap, jquery--%>
<script src="/webjars/jquery/3.3.1/jquery.min.js"></script>
<script src="/webjars/bootstrap/5.1.3/js/bootstrap.min.js"></script>
<script type="text/javascript">
    function DownloadFile(fileName) {
        //Set the File URL.
        var url = "/files/" + fileName;

        $.ajax({
            url: url,
            cache: false,
            xhr: function () {
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 2) {
                        if (xhr.status == 200) {
                            xhr.responseType = "blob";
                        } else {
                            xhr.responseType = "text";
                        }
                    }
                };
                return xhr;
            },
            success: function (data) {
                //Convert the Byte Data to BLOB object.
                var blob = new Blob([data], {type: "application/octetstream"});

                //Check the Browser type and download the File.
                var isIE = false || !!document.documentMode;
                if (isIE) {
                    window.navigator.msSaveBlob(blob, fileName);
                } else {
                    var url = window.URL || window.webkitURL;
                    link = url.createObjectURL(blob);
                    var a = $("<a />");
                    a.attr("download", fileName);
                    a.attr("href", link);
                    $("body").append(a);
                    a[0].click();
                    $("body").remove(a);
                }
                return;
            }
        });
    };



</script>
</body>
</html>
