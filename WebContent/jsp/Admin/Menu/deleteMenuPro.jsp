<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="team2.menu.MenuDBBean" %>

<%
	String deleteArray[] = request.getParameterValues("menu_chk");  
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
	
	MenuDBBean dbpro = MenuDBBean.getInstance();
	dbpro.deleteMenu(selected);
	response.sendRedirect("AdminMenu.jsp");
%>


<jsp:useBean id="menu" class="team2.menu.MenuDataBean">
     <jsp:setProperty name="menu" property="*"/>
 </jsp:useBean>