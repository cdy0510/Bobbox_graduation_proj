<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="team2.admin_board.Admin_BoardDBBean"%>
<%@ page import="team2.admin_board.Admin_BoardDataBean"%>
<%
	int admin_board_num = Integer.parseInt(request.getParameter("admin_board_num"));
  	String pageNum = request.getParameter("pageNum");
 	 try{
	  Admin_BoardDBBean dbPro = Admin_BoardDBBean.getInstance(); 
	  Admin_BoardDataBean admin_board =  dbPro.updateGetAdmin_Board(admin_board_num);
%>
<!DOCTYPE html>
<html>
<head>
<title>게시판</title>
<link href="../../../css/header_style.css" rel="stylesheet" type="text/css">
<link href="../../../css/board_style.css" rel="stylesheet" type="text/css">
<script src="../../../js/jquery-2.1.0.min.js"></script>
</head>
<body>
<jsp:include page="header.jsp" flush="false" />
	<form method="post" name="boardForm"
		action="AdminupdatePro.jsp?admin_board_num=<%=admin_board_num%>&pageNum=<%=pageNum%>" onsubmit="return writeSave()">
			<div id="board-top">
			<table>
				<tr>
				<td id="label">분류</td>
					<td id="select-type"><select name="admin_board_type">
							<option value="공지사항">공지사항</option>
							<option value="이벤트">이벤트</option>
					</select></td>
				</tr>
				<tr>
					<td id="label">제목</td>
					<td id="board-title">
					<input type="text"
						name="admin_board_title" value="<%=admin_board.getAdmin_board_title()%>"></td>
				</tr>
			</table>
		</div>
		<div class="border-line"></div>
		<div>
			<table id="content">
				<tr>
					<td colspan="3"><textarea id="board-content"
							name="admin_board_content"><%=admin_board.getAdmin_board_content()%></textarea></td>
				</tr>
			</table>			
		</div>
		<div id="btnarea">
			<input type="button" value="목록보기"
				onclick="location.href='../Board/AdminBoard.jsp'"> 
			<input type="reset" value="다시작성">	
		    <input type="submit" value="글수정">
		</div>	
	</form>
<%
}catch(Exception e){}%>	
</body>
</html>