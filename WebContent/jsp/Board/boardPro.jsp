<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="team2.board_comment.Board_CommentDBBean"%>
<%@ page import="team2.member.MemberDBBean"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="board_comment" scope="page"
	class="team2.board_comment.Board_CommentDataBean">
	<jsp:setProperty name="board_comment" property="*" />
</jsp:useBean>

<%
	int review_board_num = Integer.parseInt(request
			.getParameter("review_board_num"));
	String pageNum = request.getParameter("pageNum");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	String member_id = "";
	member_id = (String) session.getAttribute("member_id");

	MemberDBBean memberdb = MemberDBBean.getInstance();
	int member_num = memberdb.getMember_num(member_id);

	board_comment.setMember_num(member_num);
	board_comment.setBoard_comment_date(new Timestamp(System
			.currentTimeMillis()));

	Board_CommentDBBean dbPro = Board_CommentDBBean.getInstance();
	dbPro.insertBoard_Comment(board_comment);
	
	response.sendRedirect("boardForm.jsp?review_board_num="+review_board_num+"&pageNum="+pageNum);

	%>

