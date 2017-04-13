<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="team2.QandA_board.QandA_BoardDBBean"%>
<%@ page import="team2.QandA_board.QandA_BoardDataBean"%>
<%
	int QandA_board_num = Integer.parseInt(request.getParameter("QandA_board_num"));
  	String pageNum = request.getParameter("pageNum");
 	
  	try{
  		QandA_BoardDBBean dbPro = QandA_BoardDBBean.getInstance(); 
  		QandA_BoardDataBean QandA_board =  dbPro.updateGetQandA_Board(QandA_board_num);
%>
<!DOCTYPE html>
<html>
<head>
<title>게시판</title>
<link href="../../css/header_style.css" rel="stylesheet" type="text/css">
<link href="../../css/board_style.css" rel="stylesheet" type="text/css">
<script src="../../js/jquery-2.1.0.min.js"></script>
</head>
<body>
<jsp:include page="header.jsp" flush="false" />
	<form method="post" name="boardForm"
		action="QandAupdatePro.jsp?QandA_board_num=<%=QandA_board_num%>&pageNum=<%=pageNum%>" onsubmit="return writeSave()">
			<div id="board-top">
			<table>
				<tr>
					<td id="bywrite">작성자</td>
					<td colspan="2" id="writer"><%=QandA_board.getMember_id()%></td>
				</tr>
				<tr>
					<td id="label">분류</td>
					<td id="board-type">[후기]</td>
					<td id="label">제목</td>
					<td id="board-title">
					<input type="text"
						name="review_board_title" value="<%=QandA_board.getQandA_board_title()%>"></td>
				</tr>
			</table>
		</div>
		<div id="border-line"></div>
		<div>
			<table id="content">
				<tr>
					<td colspan="3"><textarea id="board-content"
							name="QandA_board_content"><%=QandA_board.getQandA_board_content()%></textarea></td>
				</tr>
			</table>			
		</div>
		<div id="btnarea">
			<input type="button" value="목록보기"
				onclick="location.href='../Board/QandABoardList.jsp'"> 
		    <input type="submit" value="글수정">
		</div>	
	</form>
<%
}catch(Exception e){}%>	
</body>
</html>