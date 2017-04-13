<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="team2.review_board.Review_BoardDBBean"%>
<%@ page import="team2.member.MemberDBBean"%>
<%@ page import="java.sql.Timestamp"%>

<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="review_board" scope="page"
	class="team2.review_board.Review_BoardDataBean">
	<jsp:setProperty name="review_board" property="*" />
</jsp:useBean>

<%
	
	String member_id = "";
	member_id = (String)session.getAttribute("member_id");

	MemberDBBean memberdb = MemberDBBean.getInstance();
	int member_num = memberdb.getMember_num(member_id);
	review_board.setMember_num(member_num);
	review_board.setReview_board_date(new Timestamp(System.currentTimeMillis()));

    Review_BoardDBBean dbPro = Review_BoardDBBean.getInstance();
    dbPro.insertReview_Board(review_board);

    response.sendRedirect("reviewBoardList.jsp");
%>