<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>--%>
<%@ page import="com.example.board_v1_0.PostDAO" %>
<%@ page import="com.example.board_v1_0.PostDTO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, inital-scale=1">

    <title>게시판 목록</title>
    <%--bootstrap, datetimepicker 적용--%>
    <%--bootstrap, jquery--%>
    <link rel="stylesheet" href="/webjars/bootstrap/5.1.3/css/bootstrap.css">
<%--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">--%>
</head>
<%
    PostDAO postDAO = PostDAO.getInstance();
%>
<body>
<div class="container">
    <h1>게시판 - 목록</h1><br>
</div>
<div class="container">
    <form class="form-inline" action="/boards/free/list.jsp" method="get">
        <div class="form-group">
            등록일

            <input name="startDate" class="form-control-sm" type="date" required/>
            <input name="endDate" class="form-control-sm" type="date" required/>

            <select class="form-select-sm" name="category" required>
                <option value="all">전체 카테고리</option>
                <%
                    List<PostDTO> categoryList;
                    try {
                        categoryList = postDAO.getCategoryList();
                    } catch (SQLException | ClassNotFoundException e) {
                        throw new RuntimeException(e);
                    }

                    for (PostDTO postDTO : categoryList) {
                        String category = postDTO.getCategory();
                        out.println("<option value=" + category + ">" + category + "</option>");
                    }
                %>
            </select>
            <input type="search" name="keyword">
            <input type="submit" value="검색">
        </div>
    </form>
</div>
<div class="container">
    <%
        // 조회 조건 입력후 검색시 파라미터대로 조회하도록 dao에 로직 추가하고 이 부분 코드 추가해야 함
        if (request.getParameter("startDate") != null && request.getParameter("endDate") != null) {

        }

        List<PostDTO> postLists = postDAO.getPostLists();
        for (PostDTO postDTO : postLists) {
            System.out.println(postDTO.toString());
        }

        Long Count = (long) postLists.size();
    %>
    <p> 총  <%=Count%>건</p>
</div>

<%--게시글 부분 list.get(page*1~10)으로 id값 가져오게 해야할 것 같음--%>
<div class="container">
    <table class="table table-hover" style="text-align: center;">
        <thead>
        <tr>
            <th class="w-auto" style="text-align: center;">카테고리</th>
            <th class="w-auto" style="text-align: center;">&nbsp</th>
            <th class="w-auto" style="text-align: center;">제목</th>
            <th class="w-auto" style="text-align: center;">작성자</th>
            <th class="w-auto" style="text-align: center;">조회수</th>
            <th class="w-auto" style="text-align: center;">등록 일시</th>
            <th class="w-auto" style="text-align: center;">수정 일시</th>
        </tr>
        </thead>
        <tbody>
        <%
            // a태그로 /view?id=게시글번호 방식으로 넘어가도록 변경해야 함

            // LocalDateTime -> yyyy-MM-dd HH:mm String 타입으로 변환, modifiedDate NullPointException 방지하기 위해 값 체크
            for (PostDTO dto : postLists) {
                String createdDate = dto.getCreatedDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
                String modifiedDate = "-";
                if (dto.getModifiedDate() != null) {
                    modifiedDate = dto.getModifiedDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
                }

                out.println("<tr>");
                out.println("<td>" + dto.getCategory() + "</td>");
                out.println("<td> </td>"); // 파일 첨부 아이콘 표시 필요
                out.println("<td style=\"text-align: left;\">" + dto.getTitle() + "</td>");
                out.println("<td>" + dto.getAuthor() + "</td>");
                out.println("<td>" + dto.getHits() + "</td>");
                out.println("<td>" + createdDate + "</td>");
                out.println("<td>" + modifiedDate + "</td>");
                out.println("</tr>");
            }
        %>
        </tbody>
    </table>
</div>
<%--페이지 부분--%>
<div class="d-flex justify-content-center">
    <ul class="pagination">
        <li class="page-item disa"><a class="page-link" href="#"><<</a></li>
        <li class="page-item"><a class="page-link" href="#">1</a></li>
        <li class="page-item"><a class="page-link" href="#">2</a></li>
        <li class="page-item"><a class="page-link" href="#">3</a></li>
        <li class="page-item"><a class="page-link" href="#">4</a></li>
        <li class="page-item"><a class="page-link" href="#">5</a></li>
        <li class="page-item"><a class="page-link" href="#">6</a></li>
        <li class="page-item"><a class="page-link" href="#">7</a></li>
        <li class="page-item"><a class="page-link" href="#">8</a></li>
        <li class="page-item"><a class="page-link" href="#">9</a></li>
        <li class="page-item"><a class="page-link" href="#">10</a></li>
        <li class="page-item"><a class="page-link" href="#">>></a></li>
    </ul>
</div>
<div class="d-flex justify-content-end">
    <button class="btn btn-secondary" onclick="location.href='/boards/free/write.jsp'">등록</button>
</div>

<script src="/webjars/jquery/3.3.1/jquery.min.js"></script>
<script src="/webjars/bootstrap/5.1.3/js/bootstrap.js"></script>
<script src="/webjars/popper.js/2.9.3/umd/popper.min.js"></script>
</body>
</html>
