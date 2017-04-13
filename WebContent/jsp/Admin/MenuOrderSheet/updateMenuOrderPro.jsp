<%@page import="team2.menu_input.Menu_InputDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*" %>
<%@ page import="team2.menu_ordersheet.*"%>
<%@ page import="team2.book.*" %>
<% request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="menuOrderSheet" class="team2.menu_ordersheet.Menu_OrderSheetDataBean">
     <jsp:setProperty name="menuOrderSheet" property="*"/>
 </jsp:useBean>
<% 
	int num = Integer.parseInt(request.getParameter("updateNum"));
	String receipt = request.getParameter("menu_receipt_yes_no");
	Menu_OrderSheetDBBean dbpro = Menu_OrderSheetDBBean.getInstance();
	dbpro.updateMenuOrderSheet(receipt, num);
%>
<jsp:useBean id="menuInput" class="team2.menu_input.Menu_InputDataBean">
    <jsp:setProperty name="menuInput" property="*"/>
</jsp:useBean>
<%
	Menu_InputDBBean inputDBPro = Menu_InputDBBean.getInstance();
	menuInput.setMenu_ordersheet_num(num);
	menuInput.setMenu_input_date(new Timestamp(System.currentTimeMillis()));
	inputDBPro.insertMenuInput(menuInput);
%>
<jsp:useBean id="book" class="team2.book.BookDataBean">
    <jsp:setProperty name="book" property="*"/>
</jsp:useBean>
<%
	java.util.Date date = new java.util.Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
	String strDate = simpleDate.format(date);
	
	int inputNum = inputDBPro.getMenuInputCount();
	BookDBBean bookDBPro = BookDBBean.getInstance();
	book.setBook_date(strDate);
	out.println(inputNum);
	book.setMenu_input_num(inputNum);
	book.setCharge_num(1);
	bookDBPro.insertBook(book);
%>
<%	
try{
	response.sendRedirect("menuOrderSheet.jsp");
}catch(Exception e){
    	e.printStackTrace();
}
%>