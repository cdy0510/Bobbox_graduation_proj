<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team2.QandA_board.QandA_BoardDBBean" %>
<%@ page import = "java.sql.Timestamp" %>

<%
	request.setCharacterEncoding("utf-8");
%>

<%
	int QandA_board_num = Integer.parseInt(request.getParameter("QandA_board_num"));
  String pageNum = request.getParameter("pageNum");

  QandA_BoardDBBean dbPro = QandA_BoardDBBean.getInstance(); 
  dbPro.deleteQandA_Board2(QandA_board_num);
%>
	<meta http-equiv="Refresh" content="0;url=QandABoardList.jsp?pageNum=<%=pageNum%>">