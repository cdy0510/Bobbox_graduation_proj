<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="team2.container.ContainerDBBean" %>

<%
	String deleteArray[] = request.getParameterValues("container_chk");  
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
	
	ContainerDBBean dbpro = ContainerDBBean.getInstance();
	dbpro.deleteContainer(selected);
	response.sendRedirect("AdminContainer.jsp");
%>


<jsp:useBean id="container" class="team2.container.ContainerDataBean">
     <jsp:setProperty name="container" property="*"/>
</jsp:useBean>