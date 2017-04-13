<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="team2.admin_board.Admin_BoardDBBean" %>
<%@ page import="team2.admin_board.Admin_BoardDataBean" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시판</title>
<link href="../../../css/header_style.css" rel="stylesheet" type="text/css">
<link href="../../../css/board_write_style.css" rel="stylesheet"
	type="text/css">
<script src="../../../js/jquery-2.1.0.min.js"></script>
</head>
<body>
<% 
  int admin_board_num = 0;
  try{
    if(request.getParameter("admin_boardnum")!=null){
	   admin_board_num=Integer.parseInt(request.getParameter("admin_board_num"));
    }
%>
	<jsp:include page="header.jsp" flush="false" />
	<form name="boardForm" method="post" action="AdminboardWritePro.jsp">
		<div id="board-top">
			<table>
				<tr>
					<td id="label">작성자</td>
					<td colspan="2" id="writer"><input type="text"
						name="admin" readonly="readonly" value="관리자"></td>
				</tr>
				<tr>
					<td id="label">분류</td>
					<td id="select-type"><select name="admin_board_type">
							<option value="공지사항">공지사항</option>
							<option value="이벤트">이벤트</option>
					</select></td>
					<td id="label">제목</td>
					<td id="board-title">
					<input type="text"
						name="admin_board_title" value=""></td>
				</tr>
			</table>
		</div>
		<div id="border-line"></div>
		<div>
			<table id="content">
				<tr>
					<td colspan="3"><textarea id="board-content"
							name="admin_board_content"></textarea></td>
				</tr>
			</table>			
		</div>
		<div></div>
		<div id="btnarea">
			<input type="button" value="목록보기"
				onclick="location.href='../Board/AdminBoard.jsp'"> 
			<input type="reset" value="다시작성">	
		    <input type="button" value="글쓰기" onclick="submitBoard()">
		</div>
<%
  }catch(Exception e){}
%>     		
	</form>
</body>
<script>
	function submitBoard() {
		//입력되지 않은값을 체크하기 위한 변수
		var title = document.boardForm.admin_board_title;
		var content = document.boardForm.admin_board_content;
		
		//잘못된 값을 체크하기 위한 변수
		if (title.value == "") {
			alert("제목을 입력해 주세요.");
			title.focus();
		} else if (content.value == "") {
			alert("내용이 입력되지 않았습니다.");
			content.focus();
		} else {
			alert("새글 등록완료");
			document.boardForm.submit();
		}

	}
</script>
</html>
