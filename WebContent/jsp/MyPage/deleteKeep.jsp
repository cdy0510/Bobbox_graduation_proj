<%@page import="team2.keep.KeepDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>

<%
	String keep_num = request.getParameter("keep_num"); 
	KeepDBBean keepdb = KeepDBBean.getInstance();
	keepdb.deleteKeep_num(Integer.parseInt(keep_num)); 
	response.sendRedirect("myBobbox.jsp");
%>
