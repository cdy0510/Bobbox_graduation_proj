<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="team2.admin_comment.Admin_CommentDBBean"%>
<%@ page import="team2.member.MemberDBBean"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="admin_comment" scope="page"
	class="team2.admin_comment.Admin_CommentDataBean">
	<jsp:setProperty name="admin_comment" property="*" />
</jsp:useBean>

<%
	int QandA_board_num = Integer.parseInt(request
			.getParameter("QandA_board_num"));
	String pageNum = request.getParameter("pageNum");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	admin_comment.setAdmin_comment_date(new Timestamp(System
			.currentTimeMillis()));

	Admin_CommentDBBean dbPro = Admin_CommentDBBean.getInstance();
	admin_comment.setQandA_board_num(QandA_board_num);
	dbPro.insertAdmin_Comment(admin_comment);
	
	response.sendRedirect("AdminQandAboardForm.jsp?QandA_board_num="+QandA_board_num+"&pageNum="+pageNum);

	%>

