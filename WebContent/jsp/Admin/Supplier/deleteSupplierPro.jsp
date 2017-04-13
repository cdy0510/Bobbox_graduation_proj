<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="team2.supplier.SupplierDBBean" %>

<%
	String deleteArray[] = request.getParameterValues("supplier_chk");  
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
	
	SupplierDBBean dbpro = SupplierDBBean.getInstance();
	dbpro.deleteSupplier(selected);
	response.sendRedirect("AdminSupplier.jsp");
%>


<jsp:useBean id="supplier" class="team2.supplier.SupplierDataBean">
     <jsp:setProperty name="supplier" property="*"/>
 </jsp:useBean>