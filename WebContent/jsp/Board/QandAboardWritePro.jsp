<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="team2.QandA_board.QandA_BoardDBBean"%>
<%@ page import="team2.member.MemberDBBean"%>
<%@ page import="java.sql.Timestamp"%>

<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="QandA_board" scope="page"
	class="team2.QandA_board.QandA_BoardDataBean">
	<jsp:setProperty name="QandA_board" property="*" />
</jsp:useBean>

<%
	String QandA_board_title = request.getParameter("QandA_board_title");
	String QandA_board_content = request.getParameter("QandA_board_content");
	
	
	QandA_board.setQandA_board_title(QandA_board_title);
	QandA_board.setQandA_board_content(QandA_board_content);
	String member_id = "";
	member_id = (String)session.getAttribute("member_id");

	MemberDBBean memberdb = MemberDBBean.getInstance();
	int member_num = memberdb.getMember_num(member_id);
	
	QandA_board.setMember_num(member_num);
	QandA_board.setQandA_board_date(new Timestamp(System.currentTimeMillis()));

    QandA_BoardDBBean dbPro = QandA_BoardDBBean.getInstance();
    dbPro.insertQandA_Board(QandA_board);
    response.sendRedirect("QandABoardList.jsp");
%>