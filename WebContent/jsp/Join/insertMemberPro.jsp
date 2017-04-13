<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="team2.member.MemberDBBean" %>
<% request.setCharacterEncoding("utf-8");%>
<% try{%> 
 <jsp:useBean id="member" class="team2.member.MemberDataBean">
     <jsp:setProperty name="member" property="*"/>
 </jsp:useBean>
 
<%
  MemberDBBean dbpro = MemberDBBean.getInstance();
  dbpro.insertMember(member);
  response.sendRedirect("../home/index.jsp");
 }catch(Exception e){
		e.printStackTrace();
	}%>