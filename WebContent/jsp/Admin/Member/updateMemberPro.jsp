<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="team2.member.MemberDBBean"%>

<% request.setCharacterEncoding("utf-8");%>

	<jsp:useBean id="member" class="team2.member.MemberDataBean">
		<jsp:setProperty name="member" property="*"/>
 	</jsp:useBean>
<% 
	MemberDBBean dbpro = MemberDBBean.getInstance();
	
	dbpro.updateMember(member);
		
 try{
	response.sendRedirect("AdminMember.jsp");
	
 	}catch(Exception e){
	    e.printStackTrace();
	}
%>