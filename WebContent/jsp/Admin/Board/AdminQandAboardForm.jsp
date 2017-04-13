<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="team2.member.MemberDBBean"%>
<%@ page import="team2.member.MemberDataBean"%>	
<%@ page import="team2.QandA_board.QandA_BoardDBBean"%>
<%@ page import="team2.QandA_board.QandA_BoardDataBean"%>
<%@ page import="team2.admin_comment.Admin_CommentDBBean"%>
<%@ page import="team2.admin_comment.Admin_CommentDataBean"%>
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
		
	int QandA_board_num = Integer.parseInt(request.getParameter("QandA_board_num"));
	String pageNum = request.getParameter("pageNum");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	int currentPage = Integer.parseInt(pageNum);
	int count = 0;
	
	MemberDBBean memberdb = MemberDBBean.getInstance();
	String member_id = "";

	List<Admin_CommentDataBean> admin_commentList = null; 
	
	Admin_CommentDBBean boarddb = Admin_CommentDBBean.getInstance();
    
	count = boarddb.getAdmin_CommentCount();
    
		try {
			member_id = (String)session.getAttribute("member_id");
			QandA_BoardDBBean dbPro = QandA_BoardDBBean.getInstance();
			QandA_BoardDataBean QandA_board = dbPro.getQandA_Board(QandA_board_num);
			
			if (count > 0) {
		    	admin_commentList = boarddb.getAdmin_Comments(QandA_board_num);
		    } 
	  		 
%>

	<form>
		<div id="board-top">
			<table>
				<tr>
					<td id="board-type">[Q&A]</td>
					<td id="board-title"><%=QandA_board.getQandA_board_title()%></td>
					<td id="board-day"><%=sdf.format(QandA_board.getQandA_board_date())%></td>
					<td id="board-read-count"><%=QandA_board.getQandA_board_count()%></td>
				</tr>
			</table>
		</div>
		<div class="border-line"></div>
		<div>
			<table>
				<tr>
					<td id="writer"><%=QandA_board.getMember_id()%></td>
				</tr>
				<tr>
					<td>
						<pre id="board-content">
							<%=QandA_board.getQandA_board_content()%>
						</pre>
					</td>
				</tr>
			</table>
		</div>
		</form>
		
		<form id="boardForm" name="boardForm" method="post" action="AdminQandAboardPro.jsp">
		
		<input type="hidden" name="QandA_board_num" value="<%=QandA_board_num %>" />
		<input type="hidden" name="pageNum" value="<%=pageNum %>" />
		<div>
			<table id="reple">
				<% 	
				if(admin_commentList != null) {
					for (int i = 0; i <admin_commentList.size(); i++) {
				       Admin_CommentDataBean admin_comment = admin_commentList.get(i);			
			    %>
				<tr>
					<td id="reple-writer">관리자</td>
					<td colspan="3" id="reple-day"><%=admin_comment.getAdmin_comment_content()%>
			     	<input type="hidden" name="admin_comment_num" value="<%=admin_comment.getAdmin_comment_num()%>"/>
			     	</td>
					<td id="reple-delete"><input type="button" value="삭제" onclick="goDelete(<%=admin_comment.getAdmin_comment_num()%>)"></td>
				</tr>
				<% 	}
				}%>

				<tr>
					<td colspan="5"><div id="border-line"></div></td>
				</tr>	
				<tr>
					<td id="reple-writer">관리자</td>
					<td colspan="3" id="reple-content"><input type="text" name="admin_comment_content"></td>
					<td id="reple-create"><input type="submit" value="댓글쓰기"/></td>
				</tr>
			</table>
		</div>
		</form>
		<div id="btnarea">
			<input type="button" value="삭제"> 
			<input type="button" value="목록" onclick="location.href='AdminQandABoard.jsp'">
		</div>
	 <%} catch (Exception e) {
		}
	%>
</body>
<script>
function goDelete(i)
{
	var form= document.getElementById('boardForm');
	form.action = "AdminCommentdeleteForm.jsp?admin_comment_num="+i;
	form.submit();
}
</script>
</html>
