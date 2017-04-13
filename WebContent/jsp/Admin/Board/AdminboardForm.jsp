<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="team2.admin_board.Admin_BoardDBBean"%>
<%@ page import="team2.admin_board.Admin_BoardDataBean"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시판</title>
<link href="../../../css/header_style.css" rel="stylesheet" type="text/css">
<link href="../../../css/board_style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="header.jsp" flush="false" />
<%
	
	int admin_board_num = Integer.parseInt(request.getParameter("admin_board_num"));
	String pageNum = request.getParameter("pageNum");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
		try {	
			Admin_BoardDBBean dbPro = Admin_BoardDBBean.getInstance();
			Admin_BoardDataBean admin_board = dbPro.getAdmin_Board(admin_board_num);	
		
%>

	<form>
		<div id="board-top">
			<table>
				<tr>
					<td id="board-type"><%=admin_board.getAdmin_board_type() %></td>
					<td id="board-title"><%=admin_board.getAdmin_board_title()%></td>
					<td id="board-day"><%=sdf.format(admin_board.getAdmin_board_date())%></td>
					<td id="board-read-count"><%=admin_board.getAdmin_board_count()%></td>
				</tr>
			</table>
		</div>
		<div class="border-line"></div>
		<div>
			<table>
				<tr>
					<td id="writer">관리자</td>
				</tr>
				<tr>
					<td>
						<pre id="board-content">
							<%=admin_board.getAdmin_board_content()%>
						</pre>
					</td>
				</tr>
			</table>
		</div>
		<div id="btnarea"> 
			<input type="button" value="수정" 
			onclick="document.location.href='AdminupdateForm.jsp?admin_board_num=<%=admin_board.getAdmin_board_num()%>&pageNum=<%=pageNum%>'"> 
			<input type="button" value="삭제"
			onclick="document.location.href='AdmindeleteForm.jsp?admin_board_num=<%=admin_board.getAdmin_board_num()%>&pageNum=<%=pageNum%>'"> 
			<input type="button" value="목록" onclick="location.href='AdminBoard.jsp'">
		</div>
		</form>
	 <%} catch (Exception e) {
		}
	%>
</body>
</html>
