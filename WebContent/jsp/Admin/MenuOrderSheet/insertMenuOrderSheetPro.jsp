<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="team2.menu_ordersheet.*" %>
<%@ page import="team2.menu_order_detail.*" %>
<script src="../../../js/format.js"></script>
<% 	request.setCharacterEncoding("utf-8");
	String numArray[] =  request.getParameterValues("menu_num");
	String quanArray[] = request.getParameterValues("menu_quantity");
	String priceArray[] = request.getParameterValues("menu_sum_price");
try{%>
 <jsp:useBean id="menuOrderSheet" class="team2.menu_ordersheet.Menu_OrderSheetDataBean">
     <jsp:setProperty name="menuOrderSheet" property="*"/>
 </jsp:useBean>
<%
	menuOrderSheet.setMenu_pay_date(new Timestamp(System.currentTimeMillis()));
	menuOrderSheet.setMenu_receipt_yes_no("NO");
	
	Menu_OrderSheetDBBean dbpro = Menu_OrderSheetDBBean.getInstance();
	
	dbpro.insertMenuOrderSheet(menuOrderSheet);
	
	int menuOrderSheetNum = dbpro.getMenuOrderSheetCount();
%>
<jsp:useBean id="menu_order_detail" class="team2.menu_order_detail.Menu_Order_DetailDataBean">
     <jsp:setProperty name="menu_order_detail" property="*"/>
 </jsp:useBean>
<%

	Menu_Order_DetailDBBean detailDBPro = Menu_Order_DetailDBBean.getInstance();

	for(int i=0; i<numArray.length; i++){
		menu_order_detail.setMenu_num(Integer.parseInt(numArray[i]));
		menu_order_detail.setMenu_quantity(quanArray[i]);
		menu_order_detail.setMenu_sum_price(priceArray[i]);
		menu_order_detail.setMenu_ordersheet_num(menuOrderSheetNum);
		detailDBPro.insertMenu_Order_Detail(menu_order_detail);
	}
	%>
		<script>
			alert('주문완료');
			location.href = "menuOrderSheet.jsp";
		</script>
	<%
	}catch(Exception e){
		e.printStackTrace();
	}%>