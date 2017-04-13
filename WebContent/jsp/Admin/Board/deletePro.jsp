<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team2.review_board.Review_BoardDBBean" %>
<%@ page import = "java.sql.Timestamp" %>

<%
	request.setCharacterEncoding("utf-8");
%>

<%
	int review_board_num = Integer.parseInt(request.getParameter("review_board_num"));
  String pageNum = request.getParameter("pageNum");

  Review_BoardDBBean dbPro = Review_BoardDBBean.getInstance(); 
  dbPro.deleteReview_Board2(review_board_num);
%>
	<meta http-equiv="Refresh" content="0;url=reviewBoardList.jsp?pageNum=<%=pageNum%>">