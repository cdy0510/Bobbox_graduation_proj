<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team2.QandA_board.QandA_BoardDBBean"%>
<%@ page import="team2.QandA_board.QandA_BoardDataBean"%>
<%@ page import="team2.admin_comment.Admin_CommentDBBean"%>
<%@ page import="team2.admin_comment.Admin_CommentDataBean"%>
<%@ page import = "java.sql.Timestamp" %>

<%
	request.setCharacterEncoding("utf-8");
%>

<%
	int QandA_board_num = Integer.parseInt(request.getParameter("QandA_board_num"));
	int admin_comment_num = Integer.parseInt(request.getParameter("admin_comment_num"));
	String pageNum = request.getParameter("pageNum");

  	Admin_CommentDBBean dbPro = Admin_CommentDBBean.getInstance(); 
  	dbPro.deleteAdmin_Comment(admin_comment_num);
%>
<meta http-equiv="Refresh" content="0;url=AdminQandAboardForm.jsp?QandA_board_num=<%=QandA_board_num%>&pageNum=<%=pageNum%>">
