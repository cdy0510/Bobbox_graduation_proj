<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="team2.admin_board.Admin_BoardDBBean"%>
<%@ page import="team2.member.MemberDBBean"%>
<%@ page import="java.sql.Timestamp"%>

<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="admin_board" scope="page"
	class="team2.admin_board.Admin_BoardDataBean">
	<jsp:setProperty name="admin_board" property="*" />
</jsp:useBean>

<%

	admin_board.setAdmin_board_date(new Timestamp(System.currentTimeMillis()));

    Admin_BoardDBBean dbPro = Admin_BoardDBBean.getInstance();
    dbPro.insertAdmin_Board(admin_board);

    response.sendRedirect("AdminBoard.jsp");
%>