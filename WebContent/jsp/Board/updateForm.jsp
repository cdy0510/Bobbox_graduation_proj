<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="team2.member.MemberDBBean"%>	
<%@ page import="team2.review_board.Review_BoardDBBean"%>
<%@ page import="team2.review_board.Review_BoardDataBean"%>
<%
	int review_board_num = Integer.parseInt(request.getParameter("review_board_num"));
  	String pageNum = request.getParameter("pageNum");
  	
  	MemberDBBean memberdb = MemberDBBean.getInstance();
	String member_id = "";
 	
  	try{
  		member_id = (String)session.getAttribute("member_id");
  		Review_BoardDBBean dbPro = Review_BoardDBBean.getInstance(); 
  		Review_BoardDataBean review_board =  dbPro.updateGetReview_Board(review_board_num);
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
		action="updatePro.jsp?review_board_num=<%=review_board_num%>&pageNum=<%=pageNum%>" onsubmit="return writeSave()">
			<div id="board-top">
			<table>
				<tr>
				<%if(member_id == review_board.getMember_id()){ %>
					<td id="label">작성자</td>
					<td colspan="2" id="writer"><%=review_board.getMember_id()%></td>
					<%}else{ %>
			<script type="text/javascript">      
       		<!--      
         	alert("해당 권한이 없습니다");
        		 history.go(-1);
       			-->
   			</script>
			<%}%>
				</tr>
				<tr>
					<td id="label">분류</td>
					<td id="board-type">[후기]</td>
					<td id="label">제목</td>
					<td id="board-title">
					<input type="text"
						name="review_board_title" value="<%=review_board.getReview_board_title()%>"></td>
				</tr>
			</table>
		</div>
		<div id="border-line"></div>
		<div>
			<table id="content">
				<tr>
					<td colspan="3"><textarea id="board-content"
							name="review_board_content"><%=review_board.getReview_board_content()%></textarea></td>
				</tr>
				<tr>
					<td id="passwd-label">비밀번호</td>
					<td id="passwd"><input type="password"
						name="review_board_passwd" maxlength="4" size="4"></td>
					<td id="passwd-coment">*비밀번호는 4자리로 입력</td>
				</tr>
			</table>			
		</div>
	</form>
	<div id="btnarea">
			<input type="button" value="목록보기"
				onclick="location.href='../Board/reviewBoardList.jsp'"> 
			<input type="reset" value="다시작성">	
		    <input type="submit" value="글수정">
		</div>	
<%
}catch(Exception e){}%>	
</body>
</html>