<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="team2.admin_board.Admin_BoardDBBean"%>
<%@ page import="team2.admin_board.Admin_BoardDataBean"%>
<%@ page import="team2.member.MemberDataBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%!int pageSize = 10;
    SimpleDateFormat sdf = 
        new SimpleDateFormat("yyyy-MM-dd HH:mm");%>

<%
	String pageNum = request.getParameter("pageNum");

		if (pageNum == null) {
			pageNum = "1";
		}

    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0;
    int number = 0;
    List<Admin_BoardDataBean> Admin_boardList = null; 
    
    Admin_BoardDBBean dbPro = Admin_BoardDBBean.getInstance();
    count = dbPro.getAdmin_BoardCount();
    
    if (count > 0) {
    	Admin_boardList = dbPro.getAdmin_Boards(startRow, endRow);
    }

	number = count-(currentPage-1)*pageSize;
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시판</title>
<link href="../../../css/header_style.css" rel="stylesheet" type="text/css">
<link href="../../../css/board_list_style.css" rel="stylesheet"
	type="text/css">
<script src="../../../js/jquery-2.1.0.min.js"></script>
<style type="text/css">
#board_kind {
	background-image: url("../../../img/board_notice.jpg");
	width: 700px;
	height: 43px;
	border-bottom: 1px solid #fff;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" flush="false" />
	
	<div id="board_page">
	<div id="board_kind">
		<a href="AdminBoard.jsp"><span id="notice_board"></span></a>
		<a href="AdminQandABoard.jsp"><span id="qna_board"></span></a>
		<a href="reviewBoardList.jsp"><span id="review_board"></span></a>
	</div>
	<div id="board_area">			
		<table>
			<tr id="table-header">
				<td id="board-num">글번호</td>
				<td id="board-type">말머리</td>
				<td id="board-title">제목</td>
				<td id="board-writer">작성자</td>
				<td id="board-day">작성일</td>
				<td id="board-read-count">조회수</td>
			</tr>
			<%
				for (int i = 0; i <Admin_boardList.size(); i++) {
					Admin_BoardDataBean Admin_board = Admin_boardList.get(i);
			%>
			<tr id="table-content">
				<td id="board-num"><%=number--%></td>
				<td id="board-type"><%=Admin_board.getAdmin_board_type()%></td>
				<td id="board-title"><a href="AdminboardForm.jsp?admin_board_num=<%=Admin_board.getAdmin_board_num()%>&pageNum=<%=currentPage%>">
						<%=Admin_board.getAdmin_board_title()%></a></td>
				<td id="board-writer">관리자</td>
				<td id="board-day"><%=sdf.format(Admin_board.getAdmin_board_date())%></td>
				<td id="board-read-count"><%=Admin_board.getAdmin_board_count()%></td>
			</tr>
			<%}%>
		</table>
	</div>
	<div id="page_num_area">
	<%
    if (count > 0) {
        int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage =1;
		
		if(currentPage % 10 != 0)
           startPage = (int)(currentPage/10)*10 + 1;
		else
           startPage = ((int)(currentPage/10)-1)*10 + 1;

		int pageBlock = 10;
        int endPage = startPage + pageBlock - 1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) { %>
          <a href="AdminBoard.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        
        for (int i = startPage ; i <= endPage ; i++) {  %>
           <a href="AdminBoard.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%      }
        
        if (endPage < pageCount) {  %>
        <a href="AdminBoard.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%
        }
    }
%>
	</div>
	<div id="btnarea">
		<input type="button" value="글쓰기"
			onclick="location.href='AdminboardWriteForm.jsp'">
	</div>
	</div>
</body>
</html>
