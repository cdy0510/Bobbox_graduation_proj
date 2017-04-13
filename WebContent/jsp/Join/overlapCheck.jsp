<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="team2.member.MemberDBBean"%>
<% 
	String uid = request.getParameter("uid");

	StringBuffer str = new StringBuffer();
	str.append("<?xml version='1.0' encoding='utf-8'?>");
	str.append("<root>");

	MemberDBBean member = MemberDBBean.getInstance();
	str.append(member.overlapCheck(uid));

	str.append("<id>" + uid + "</id>");
	str.append("</root>");

	response.setContentType("text/xml;charset=utf-8");
	response.getWriter().write(str.toString());
%>