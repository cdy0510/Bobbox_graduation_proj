<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="team2.member.MemberDBBean"%>
<%@ page import="team2.member.MemberDataBean"%>
<%@ page import="team2.QandA_board.QandA_BoardDBBean" %>
<%@ page import="team2.QandA_board.QandA_BoardDataBean" %>

<%
	MemberDBBean dbpro = MemberDBBean.getInstance();

	String member_id = "";	
	try{
		member_id = (String)session.getAttribute("member_id");
		 
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시판</title>
<link href="../../css/header_style.css" rel="stylesheet" type="text/css">
<link href="../../css/board_write_style.css" rel="stylesheet"
	type="text/css">	
<script src="../../js/jquery-2.1.0.min.js"></script>
</head>
<body>
<% 
  int QandA_board_num = 0;

  try{
    if(request.getParameter("QandA_board_num")!=null){
    	QandA_board_num=Integer.parseInt(request.getParameter("QandA_board_num"));
    }
%>
	<jsp:include page="header.jsp" flush="false" />
	<form name="boardForm" method="post" action="QandAboardWritePro.jsp">
		<div id="board-top">
			<input type="hidden" name="QandA_board_num" value="<%=QandA_board_num%>"/> 
			<table>
				<tr>
					<% if(member_id != null){%>
					<td id="label">작성자</td>
					<td colspan="2" id="writer"><input type="text"
						name="memeber_id" value="<%=member_id%>"></td>
					<% } else { %>
					<td id="label">작성자</td>
					<td colspan="2" id="writer"><input type="text"
						name="memeber_id" value="손님"></td>
					<% } %>
				</tr>
				<tr>
					<td id="label">분류</td>
					<td id="board-type">[Q&A]</td>
					<td id="label">제목</td>
					<td id="board-title"><input type="text" name="QandA_board_title" value=""></td>
					<td><input type="checkbox">비밀글</td>
				</tr>
			</table>
		</div>
		<div id="border-line"></div>
		<div>
			<table id="content">
				<tr>
					<td colspan="3"><textarea id="board-content"
							name="QandA_board_content"></textarea></td>
				</tr>
				<tr>
					<td id="passwd-label">비밀번호</td>
					<td id="passwd"><input type="password"
						name="QandA_board_passwd" maxlength="4" size="4"></td>
					<td id="passwd-coment">*비밀번호는 4자리로 입력</td>
				</tr>
			</table>
		</div>
		<div></div>
		<div id="btnarea">
			<input type="button" value="목록보기"
				onclick="location.href='../Board/QandABoardList.jsp'"> <input
				type="button" value="글쓰기" onclick="submitBoard()">
		</div>
<%
  }catch(Exception e){}
%>     
	</form>
</body>
<script>
	function submitBoard() {
		//입력되지 않은값을 체크하기 위한 변수
		var title = document.boardForm.QandA_board_title;
		var content = document.boardForm.QandA_board_content;
		var passwd = document.boardForm.QandA_board_passwd;

		//잘못된 값을 체크하기 위한 변수
		if (title.value == "") {
			alert("제목을 입력해 주세요.");
			title.focus();
		} else if (content.value == "") {
			alert("내용이 입력되지 않았습니다.");
			content.focus();
		} else if (passwd.value == "") {
			alert("4자리 비밀번호를 입력해주세요.");
			passwd.focus();
		} else {
			alert("새글 등록완료");
			document.boardForm.submit();
		}

	}
</script>
</html>
<%  
    }catch(Exception e){
		e.printStackTrace();
	}
%>		
