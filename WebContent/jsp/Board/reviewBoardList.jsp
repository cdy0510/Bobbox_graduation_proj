<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="team2.review_board.Review_BoardDBBean"%>
<%@ page import="team2.review_board.Review_BoardDataBean"%>
<%@ page import="team2.board_comment.Board_CommentDBBean"%>
<%@ page import="team2.board_comment.Board_CommentDataBean"%>
<%@ page import="team2.member.MemberDataBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%!int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");%>

<%
	String pageNum = request.getParameter("pageNum");

	if (pageNum == null) {
		pageNum = "1";
	}

	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int review_board_count = 0;
	int number = 0;
	int count = 0;
	List<Review_BoardDataBean> review_boardList = null;

	Review_BoardDBBean dbPro = Review_BoardDBBean.getInstance();
	review_board_count = dbPro.getReview_BoardCount();

	if (review_board_count > 0) {
		review_boardList = dbPro.getReview_Boards(startRow, endRow);
	}

	number = review_board_count - (currentPage - 1) * pageSize;
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시판</title>
<link href="../../css/header_style.css" rel="stylesheet" type="text/css">
<link href="../../css/board_list_style.css" rel="stylesheet"
	type="text/css">
<script src="../../js/jquery-2.1.0.min.js"></script>
<style type="text/css">
#board_kind {
	background-image: url("../../img/board_review.jpg");
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
			<a href="AdminBoardList.jsp"><span id="notice_board"></span></a> <a
				href="QandABoardList.jsp"><span id="qna_board"></span></a> <a
				href="reviewBoardList.jsp"><span id="review_board"></span></a>
		</div>
		<div id="board_area">
			<table>
				<tr id="table-header">
					<td id="board-num">글번호</td>
					<td id="board-title">제목</td>
					<td id="board-writer">작성자</td>
					<td id="board-day">작성일</td>
					<td id="board-read-count">조회수</td>
				</tr>
				<%
					for (int i = 0; i < review_boardList.size(); i++) {
						Review_BoardDataBean review_board = review_boardList.get(i);
						int review_board_num = review_board.getReview_board_num();

						Board_CommentDBBean boarddb = Board_CommentDBBean.getInstance();
						count = boarddb.getBoard_CommentCount2(review_board_num);
				%>
				<tr id="table-content">
					<td id="board-num"><%=number--%></td>
					<td id="board-title"><a
						href="boardForm.jsp?review_board_num=<%=review_board.getReview_board_num()%>&pageNum=<%=currentPage%>">
							<%=review_board.getReview_board_title()%>[<%=count%>]
					</a></td>
					<td id="board-writer"><%=review_board.getMember_id()%></td>
					<td id="board-day"><%=sdf.format(review_board.getReview_board_date())%></td>
					<td id="board-read-count"><%=review_board.getReview_board_count()%></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<div id="page_num_area">
			<%
				if (review_board_count > 0) {
					int pageCount = review_board_count / pageSize
							+ (review_board_count % pageSize == 0 ? 0 : 1);
					int startPage = 1;

					if (currentPage % 10 != 0)
						startPage = (int) (currentPage / 10) * 10 + 1;
					else
						startPage = ((int) (currentPage / 10) - 1) * 10 + 1;

					int pageBlock = 10;
					int endPage = startPage + pageBlock - 1;
					if (endPage > pageCount)
						endPage = pageCount;

					if (startPage > 10) {
			%>
			<a href="reviewBoardList.jsp?pageNum=<%=startPage - 10%>">[이전]</a>
			<%
				}

					for (int i = startPage; i <= endPage; i++) {
			%>
			<a href="reviewBoardList.jsp?pageNum=<%=i%>">[<%=i%>]
			</a>
			<%
				}

					if (endPage < pageCount) {
			%>
			<a href="reviewBoardList.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
			<%
				}
				}
			%>
		</div>
		<div id="btnarea">
				<input type="button" value="글쓰기" onclick="location.href='boardWriteForm.jsp'">
			</div>
	</div>	
</body>
</html>
