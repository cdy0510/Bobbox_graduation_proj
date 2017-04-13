<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="team2.review_board.Review_BoardDBBean" %>

<%
	String deleteArray[] = request.getParameterValues("board_chk");  
	String selected = "";
	
	if (deleteArray != null) {  
		if(deleteArray.length == 1) {  
			selected = deleteArray[0];
		} else {
			for (int i = 0; i < deleteArray.length; i++) {  
				selected += deleteArray[i];  
				if( i < deleteArray.length -1) {  
					selected += ",";  
				}  
			}  
		} 
		out.println(selected);
	}  
	
	Review_BoardDBBean dbpro = Review_BoardDBBean.getInstance();
	dbpro.deleteReview_Board2(selected);
	response.sendRedirect("reviewBoardList.jsp");
%>


<jsp:useBean id="review_board" class="team2.review_board.Review_BoardDataBean">
     <jsp:setProperty name="review_board" property="*"/>
</jsp:useBean>