<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="team2.delivery.*" %>

<%
	String updateArray[] = request.getParameterValues("order_chk");
	String state = request.getParameter("state");
	String selected = "";
	
	if (updateArray != null) {  
		if(updateArray.length == 1) {  
			selected = updateArray[0];
		} else {
			for (int i = 0; i < updateArray.length; i++) {  
				selected += updateArray[i];  
				if( i < updateArray.length -1) {  
					selected += ",";  
				}  
			}  
		} 
	}
	
	DeliveryDBBean dbpro = DeliveryDBBean.getInstance();
	dbpro.updateStatement(selected, state);
	
	out.println("selected: "+selected);
	out.println("statement: "+state);
	response.sendRedirect("AdminOrder.jsp");
%>