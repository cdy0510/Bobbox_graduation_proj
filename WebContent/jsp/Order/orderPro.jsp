<%@page import="team2.keep.KeepDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*" %>
<%@ page import="java.util.List"%>
<%@ page import="team2.member_order.Member_OrderDBBean"%>
<%@ page import="team2.member_order_detail.Member_Order_DetailDBBean"%>
<%@ page import="team2.keep.KeepDBBean"%>
<%@ page import="team2.cybermoney.CybermoneyDBBean"%>
<%@ page import="team2.cybermoney.CybermoneyDataBean" %>
<%@ page import="team2.menu.MenuDBBean"%>
<%@ page import="team2.member.MemberDBBean"%>
<%@ page import="team2.delivery.DeliveryDBBean"%>

<% request.setCharacterEncoding("utf-8");%>

<%
	MemberDBBean memberdb = MemberDBBean.getInstance();
	Member_OrderDBBean modb = Member_OrderDBBean.getInstance();
	Member_Order_DetailDBBean moddb = Member_Order_DetailDBBean.getInstance();
	DeliveryDBBean deldb = DeliveryDBBean.getInstance();
	KeepDBBean keepdb = KeepDBBean.getInstance();
	MenuDBBean menudb = MenuDBBean.getInstance();
	CybermoneyDBBean cyberdb = CybermoneyDBBean.getInstance();
	
	String member_id = (String)session.getAttribute("member_id");
	int member_num = memberdb.getMember_num(member_id);
	int member_order_num = 0;
	
	String member_order_sum_price = request.getParameter("member_order_sum_price");
	
	String[] keep_num = request.getParameterValues("keep_num");
	String[] order_quantity = request.getParameterValues("order_quantity");
	String[] order_delivery_date = request.getParameterValues("order_delivery_date");
	String[] order_delivery_time = request.getParameterValues("order_delivery_time");
	String[] order_price = request.getParameterValues("order_price");
	String order_where = request.getParameter("order_where");
	String deliver_message = request.getParameter("deliver_message");
	
try{%> 
	<jsp:useBean id="member_order" class="team2.member_order.Member_OrderDataBean">
		<jsp:setProperty name="member_order" property="*"/>
 	</jsp:useBean>
 	
 	<jsp:useBean id="member_order_detail" class="team2.member_order_detail.Member_Order_DetailDataBean">
		<jsp:setProperty name="member_order_detail" property="*"/>
	</jsp:useBean>
	
	<jsp:useBean id="delivery" class="team2.delivery.DeliveryDataBean">
		<jsp:setProperty name="delivery" property="*"/>
	</jsp:useBean>
	
	<jsp:useBean id="cybermoney" class="team2.cybermoney.CybermoneyDataBean">
		<jsp:setProperty name="cybermoney" property="*"/>
	</jsp:useBean>
	
	<jsp:useBean id="keep" class="team2.keep.KeepDataBean">
		<jsp:setProperty name="keep" property="*"/>
	</jsp:useBean>
<% 
	//회원 테이블 update
	memberdb.updateOrderCount(member_num);

	//회원 주문 테이블 insert
	member_order.setMember_pay_date(new Timestamp(System.currentTimeMillis()));
	member_order.setMember_order_sum_price(member_order_sum_price);
	
	member_order_num = modb.insertMember_Order(member_order);
	
	
	
	for(int i=0; i<keep_num.length; i++){
		//회원 주문 상세 테이블 insert
		member_order_detail.setKeep_num(Integer.parseInt(keep_num[i]));
		member_order_detail.setOrder_quantity(order_quantity[i]);
		member_order_detail.setOrder_delivery_date(order_delivery_date[i]);
		member_order_detail.setOrder_delivery_time(order_delivery_time[i]);
		member_order_detail.setOrder_price(order_price[i]);
		member_order_detail.setOrder_where(order_where);
		member_order_detail.setMember_order_num(member_order_num);
		int member_order_detail_num = moddb.insertMember_Order_Detail(member_order_detail);
		
		//배송 테이블 insert
		delivery.setMember_order_detail_num(member_order_detail_num);
		delivery.setDelivery_statement("0");
		delivery.setDeliver_message(deliver_message);
		deldb.insertDelivery(delivery);
		
		//메뉴 테이블 update
		String menuList = keepdb.getMenuList(Integer.parseInt(keep_num[i]));
		String[] menuArray = menuList.split(",");
		for(int j=0; j<menuArray.length; j++){
			menudb.updateOrderCount(order_quantity[i], Integer.parseInt(menuArray[j]));
		}
		
		//사이버머니 테이블 insert
		java.util.Date date = new java.util.Date();
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
		String strDate = simpleDate.format(date);
		cybermoney.setMember_num(member_num);
		cybermoney.setUse_date(strDate);
		cybermoney.setUse_bobpul(Integer.parseInt(order_price[i]));
		
		cyberdb.insertOutput(cybermoney);
		
		//담아두기 테이블 update
		keep.setSave_yes_no("3");
		keepdb.updateSave_yes_no(member_num);
	}
	%>
		<script>
			alert('주문완료');
			location.href = "../MyPage/myOrderList.jsp";
		</script>
	<%
	}catch(Exception e){
		e.printStackTrace();
		out.println(e);
		
	}%>