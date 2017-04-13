<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="team2.member.MemberDBBean"%>
<%@ page import="team2.member.MemberDataBean"%>
<%@ page import="team2.review_board.Review_BoardDBBean"%>
<%@ page import="team2.review_board.Review_BoardDataBean"%>

<%
	MemberDBBean dbpro = MemberDBBean.getInstance();

	String member_id = "";
	try {
		member_id = (String) session.getAttribute("member_id");
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
<script>
	function submitBoard() {
		//입력되지 않은값을 체크하기 위한 변수
		var title = document.boardForm.review_board_title;
		var content = document.boardForm.review_board_content;
		var passwd = document.boardForm.review_board_passwd;

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

		function fn_check(obj) {
			var str = "비밀글";
			if (obj.checked) {
				str = "일반글";
			}
			document.getElementById("value").value = str;
		}

	}
</script>
</head>
<body>
	<%
		int review_board_num = 0, re_group_num = 1, re_step = 0, re_level = 0;
			String strV = "";
			try {
				if (request.getParameter("review_board_num") != null) {
					review_board_num = Integer.parseInt(request
							.getParameter("review_board_num"));
					re_group_num = Integer.parseInt(request
							.getParameter("re_group_num"));
					re_step = Integer.parseInt(request
							.getParameter("re_step"));
					re_level = Integer.parseInt(request
							.getParameter("re_level"));

				}
	%>
	<jsp:include page="header.jsp" flush="false" />
	<form name="boardForm" method="post" action="boardWritePro.jsp">
		<div id="board-top">
			<input type="hidden" name="review_board_num"
				value="<%=review_board_num%>"> <input type="hidden"
				name="re_group_num" value="<%=re_group_num%>"> <input
				type="hidden" name="re_step" value="<%=re_step%>"> <input
				type="hidden" name="re_level" value="<%=re_level%>">
			<table>
				<tr>
					<%
						if (member_id != null) {
					%>
					<td id="label">작성자</td>
					<td colspan="2" id="writer"><input type="text"
						name="memeber_id" value="<%=member_id%>"></td>
					<%
						} else {
					%>
					<td id="label">작성자</td>
					<td colspan="2" id="writer"><input type="text"
						name="memeber_id" value="손님"></td>
					<%
						}
					%>
				</tr>
				<tr>
					<td id="label">분류</td>
					<td id="board-type">[후기]</td>
					<td id="label">제목</td>
					<td id="board-title">
						<%
							if (request.getParameter("num") == null)
										strV = "";
									else
										strV = "[답변]";
						%> <input type="text" name="review_board_title"
						value="<%=strV%>">
					</td>
				</tr>
			</table>
		</div>
		<div id="border-line"></div>
		<div>
			<table id="content">
				<tr>
					<td colspan="3"><textarea id="board-content"
							name="review_board_content"></textarea></td>
				</tr>
				<tr>
					<td id="passwd-label">비밀번호</td>
					<td id="passwd"><input type="password"
						name="review_board_passwd" maxlength="4" size="4"></td>
					<td id="passwd-coment">*비밀번호는 4자리로 입력</td>
				</tr>
			</table>
		</div>
		<div></div>
		<div id="btnarea">
			<input type="button" value="목록보기"
				onclick="location.href='../Board/reviewBoardList.jsp'"> <input
				type="button" value="글쓰기" onclick="submitBoard()">
		</div>
		<%
			} catch (Exception e) {
				}
		%>
	</form>
</body>
</html>
<%
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
