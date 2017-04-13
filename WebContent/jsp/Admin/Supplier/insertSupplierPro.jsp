<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="team2.supplier.SupplierDBBean" %>
<% request.setCharacterEncoding("utf-8");%>
<% try{%>
 <jsp:useBean id="supplier" class="team2.supplier.SupplierDataBean">
     <jsp:setProperty name="supplier" property="*"/>
 </jsp:useBean>
 
<%
  SupplierDBBean dbpro = SupplierDBBean.getInstance();
  dbpro.insertSupplier(supplier);
  response.sendRedirect("AdminSupplier.jsp");
 }catch(Exception e){
		e.printStackTrace();
	}%>