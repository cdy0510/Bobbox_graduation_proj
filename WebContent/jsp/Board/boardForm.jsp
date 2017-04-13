<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="team2.member.MemberDBBean"%>
<%@ page import="team2.member.MemberDataBean"%>	
<%@ page import="team2.review_board.Review_BoardDBBean"%>
<%@ page import="team2.review_board.Review_BoardDataBean"%>
<%@ page import="team2.board_comment.Board_CommentDBBean"%>
<%@ page import="team2.board_comment.Board_CommentDataBean"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시판</title>
<link href="../../css/header_style.css" rel="stylesheet" type="text/css">
<link href="../../css/board_style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="header.jsp" flush="false" />

	<%
		
	int review_board_num = Integer.parseInt(request.getParameter("review_board_num"));
	String pageNum = request.getParameter("pageNum");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	int currentPage = Integer.parseInt(pageNum);
	int count = 0;
	
	MemberDBBean memberdb = MemberDBBean.getInstance();
	String member_id = "";

	List<Board_CommentDataBean> board_commentList = null; 
	
	Board_CommentDBBean boarddb = Board_CommentDBBean.getInstance();
    
	count = boarddb.getBoard_CommentCount();
    
		try {
			member_id = (String)session.getAttribute("member_id");
			Review_BoardDBBean dbPro = Review_BoardDBBean.getInstance();
			Review_BoardDataBean review_board = dbPro.getReview_Board(review_board_num);
			
			if (count > 0) {
		    	board_commentList = boarddb.getBoard_Comments(review_board_num);
		    } 
	
	 
%>

	<form id="review_board_form">
		<div id="board-top">
			<table>
				<tr>
					<td id="board-type">[후기]</td>
					<td id="board-title"><%=review_board.getReview_board_title()%></td>
					<td id="board-day"><%=sdf.format(review_board.getReview_board_date())%></td>
					<td id="board-read-count"><%=review_board.getReview_board_count()%></td>
				</tr>
			</table>
		</div>
		<div id="border-line"></div>
		<div>
			<table>
				<tr>
					<td id="writer"><%=review_board.getMember_id()%></td>
				</tr>
				<tr>
					<td>
						<div id="board-content">
							<%=review_board.getReview_board_content()%>
						</div>
					</td>
				</tr>
			</table>
		</div>
		</form>
		
		<form id="boardForm" name="boardForm" method="post" action="boardPro.jsp">
		<input type="hidden" name="review_board_num" value="<%=review_board_num %>" />
		<input type="hidden" name="pageNum" value="<%=pageNum %>" />
		<div>
			<table id="reple">
				<% 	
				if(board_commentList != null) {
					for (int i = 0; i <board_commentList.size(); i++) {
				       Board_CommentDataBean board_comment = board_commentList.get(i);
			    %>
				<tr>
					<td id="reple-writer"><%=board_comment.getMember_id()%></td>
					<td colspan="3" id="board-comment"><%=board_comment.getBoard_comment_content()%>
					<td id="reple-day"><%=sdf.format(board_comment.getBoard_comment_date())%></td>
					<input type="hidden" name="admin_comment_num" value="<%=board_comment.getBoard_comment_num()%>"/></td>
					<td id="reple-delete"><input type="button" value="삭제" onclick="goDelete(<%=board_comment.getBoard_comment_num()%>)"></td>
				</tr>
				<% 	}
				}%>

				<tr>
					<td colspan="5"><div id="border-line"></div></td>
				</tr>	
				<tr>
				<%
					if (member_id != null) {
			    %>
					<td id="reple-writer"><%=member_id%></td>
					<td colspan="3" id="reple-content"><input type="text" name="board_comment_content"></td>
					<td id="reple-create"><input type="submit" value="댓글쓰기"/></td>
				<%
					} else {
				%>	
					<td colspan="3" id="reple-content"><input type="text" name="board_comment_content" value="권한이 없습니다." readonly="readonly" style="border: none" /></td>
				<%
					}
				%>
				</tr>
			</table>
		</div>
		</form>
		<div id="btnarea">
			<input type="button" value="수정"
			onclick="document.location.href='updateForm.jsp?review_board_num=<%=review_board.getReview_board_num()%>&pageNum=<%=pageNum%>'">
			<input type="button" value="삭제" 
			onclick="document.location.href='deleteForm.jsp?review_board_num=<%=review_board.getReview_board_num()%>&pageNum=<%=pageNum%>'"> 
			<input type="button" value="목록" onclick="location.href='reviewBoardList.jsp'">
		</div>
	 <%} catch (Exception e) {
		}
	%>
</body>
<script>
function goDelete(i)
{
	var form= document.getElementById('boardForm');
	form.action = "BoardCommentdeleteForm.jsp?board_comment_num="+i;
	form.submit();
}
function goUpdate(i)
{
	var form= document.getElementById('review_board_form');
	form.action = "BoardCommentUpdateForm.jsp?board_comment_num="+i;
	form.submit();
}
</script>
</html>
