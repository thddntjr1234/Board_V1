<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>--%>
<%@ page import="com.example.board_v1_0.PostDAO" %>
<%@ page import="com.example.board_v1_0.PostDTO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>게시판 목록</title>
    <script type="text/javascript">
        $(document).ready(function () {
            $.datepicker.setDefaults($.datepicker.regional['ko']);
            $("#startDate").datepicker({
                changeMonth: true,
                changeYear: true,
                nextText: '다음 달',
                prevText: '이전 달',
                dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
                dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
                monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                dateFormat: "yymmdd",
                maxDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
                onClose: function (selectedDate) {
                    //시작일(startDate) datepicker가 닫힐때
                    //종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
                    $("#endDate").datepicker("option", "minDate", selectedDate);
                }

            });
            $("#endDate").datepicker({
                changeMonth: true,
                changeYear: true,
                nextText: '다음 달',
                prevText: '이전 달',
                dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
                dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
                monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                dateFormat: "yymmdd",
                maxDate: 0,                       // 선택할수있는 최대날짜, ( 0 : 오늘 이후 날짜 선택 불가)
                onClose: function (selectedDate) {
                    // 종료일(endDate) datepicker가 닫힐때
                    // 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
                    $("#startDate").datepicker("option", "maxDate", selectedDate);
                }

            });
        });
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

    List<PostDTO> postLists = postDAO.getPostLists();
    for (PostDTO postDTO : postLists) {
        System.out.println(postDTO.toString());
    }
%>
<body>
<h1>게시판 - 목록</h1><br>
<form action="/boards/free/list.jsp" method="get">
    등록일
    <input type="text" id="startDate" name="startDate"> ~
    <input type="text" id="endDate" name="endDate">

    <select name="category" name="category">
        <option value="">전체 카테고리</option>
        <%
            for (PostDTO postDTO : categoryList) {
                String category = postDTO.getCategory();
                out.println("<option value=" + category + ">" + category + "</option>");
            }
        %>
    </select>

    <input type="search" name="keyword">
    <input type="submit" value="검색">
</form>
<div>
    <%
        Long Count = (long) postLists.size();
    %>
    <p> 총  <%=Count%>건</p>
</div>

<%--게시글 부분 list.get(page*1~10)으로 id값 가져오게 해야할 것 같음--%>
<div>
    <table>
        <tr>
            <th>카테고리</th>
            <th>제목</th>
            <th>작성자</th>
            <th>조회수</th>
            <th>등록 일시</th>
            <th>수정 일시</th>
        </tr>
    </table>
</div>
<%--페이지 부분--%>
<div>
    <a href></a>&nbsp;&nbsp;<a href=""></a>
</div>
<div>
    <button onclick="location.href='/boards/free/writer.jsp'">등록</button>
</div>
</body>
</html>
