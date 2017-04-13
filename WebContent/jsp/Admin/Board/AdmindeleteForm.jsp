<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team2.admin_board.Admin_BoardDBBean" %>
<%@ page import = "java.sql.Timestamp" %>

<%
	request.setCharacterEncoding("utf-8");
%>

<%
	int admin_board_num = Integer.parseInt(request.getParameter("admin_board_num"));
  String pageNum = request.getParameter("pageNum");

  Admin_BoardDBBean dbPro = Admin_BoardDBBean.getInstance(); 
  dbPro.deleteAdmin_Board(admin_board_num);
%>
	<meta http-equiv="Refresh" content="0;url=AdminBoard.jsp?pageNum=<%=pageNum%>">
