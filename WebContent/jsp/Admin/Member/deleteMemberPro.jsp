<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="team2.member.MemberDBBean" %>

<%
	String deleteArray[] = request.getParameterValues("member_chk");  
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
	
	MemberDBBean dbpro = MemberDBBean.getInstance();
	dbpro.deleteMember(selected);
	response.sendRedirect("AdminMember.jsp");
%>


<jsp:useBean id="member" class="team2.member.MemberDataBean">
     <jsp:setProperty name="member" property="*"/>
 </jsp:useBean>