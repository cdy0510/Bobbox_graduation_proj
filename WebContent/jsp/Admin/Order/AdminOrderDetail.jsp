<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="team2.member_order_detail.*" %>
<%@ page import="team2.keep.*" %>
<%@ page import="team2.menu.*" %>
<%@ page import="team2.delivery.*" %>
<%
	String detailNum = request.getParameter("detailNum");
	Member_Order_DetailDBBean dbpro = Member_Order_DetailDBBean.getInstance();
	Member_Order_DetailDataBean memberDetail = dbpro.getMemberOrderDetail(Integer.parseInt(detailNum));

	KeepDBBean kDBPro = KeepDBBean.getInstance();
	KeepDataBean keep = kDBPro.getKeep(memberDetail.getKeep_num());
	
	String menuNum = keep.getMenu_num();
	String[] menuArray = menuNum.split(",");
	
	MenuDBBean mDBPro = MenuDBBean.getInstance();

	DeliveryDBBean dDBPro = DeliveryDBBean.getInstance();
	DeliveryDataBean delivery = dDBPro.getDelivery(memberDetail.getMember_order_detail_num());
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="../admincss/admin_style.css"></link>
<link rel="stylesheet" type="text/css" href="../admincss/header_style.css"></link>
<link rel="stylesheet" type="text/css" href="../admincss/member_order_detail_style.css"></link>
<title>BOBBOX :: 주문관리</title>
</head>
<body>
	<div id="header" class="width800">
		<div id="logo">
            <img height="80px" src="../../../img/BOBBOX_LOGO_Text.png" />
		</div>
        <div id="admin-hello">
            관리자님, 안녕하세요.
            <a href="Logout.jsp">로그아웃</a>
        </div>
	</div>
	<div id="contents">
		<form action="#" method="POST">
		<div id="rootBar"><a href="../AdminMain.jsp">홈</a>&nbsp;&nbsp;>&nbsp;&nbsp;<a href="../Order/AdminOrder.jsp">주문관리</a>&nbsp;&nbsp;>&nbsp;&nbsp;<span id="now_page">회원 주문 상세</span></div>
			<div id="con-tit"><img src="../../../img/memberdetail.png" /></div>
			<table id="orderBoxTop">
				<tr>
					<th>주문일시</th>
					<td><input type="text" readonly="readonly" value="<%=memberDetail.getMember_pay_date() %>" id="payDate"/></td>
					<th>회원ID</th>
					<td><input type="text" readonly="readonly" value="<%=memberDetail.getMember_id() %>" id="memberId"/></td>
					<th>총밥풀</th>
					<td><input type="text" readonly="readonly" value="<%=memberDetail.getOrder_price() %>" id="sumPrice"/></td>
				</tr>

			</table>
			
			<table id="orderBoxCen">
				<tr>
					<th>수령일자</th>
					<th colspan="5">배송지</th>
					<th>배송시간</th>
					<th>수령자</th>
				</tr>
				<tr>
					<td>
						<input type="text" readonly="readonly" value="<%=memberDetail.getOrder_delivery_date() %>" id="deliveryDate" />
					</td>
					
					<td colspan="5">
						<input type="text" readonly="readonly" id="orderWhere" value="<%=memberDetail.getOrder_where() %>" />
					</td>
					<td>
						<input type="text" readonly="readonly" id="orderTime" value="<%=memberDetail.getOrder_delivery_time() %>" />
					</td>
					<td>
						<input type="text" readonly="readonly" id="deliveryName" value="정다영" />
					</td>
				</tr>
				<tr>
					<th width="80px">배송상태</th>
					<td width="80px"><input type="text" id="delState" readonly="readonly"/>
						<input type="hidden" value="<%=delivery.getDelivery_statement() %>" id="delhidden"/>
					</td>
					<th width="80px">배송메시지</th>
					<td colspan="7"><input type="text" value="<%=delivery.getDeliver_message() %>" id="delMsg" readonly="readonly"/></td>
				</tr>
				
			</table>
			<table id="orderBoxBottom">
				<tr>
					<th class="bottomTh">상품명</th>
					<td id="dosirak"><%=keep.getDosirak_name() %></td>
					<th class="bottomTh">용기</th>
					<td id="container"><%=keep.getContainer_name() %></td>
					<th class="bottomTh">수량</th>
					<td id="quantity"><%=memberDetail.getOrder_quantity() %></td>
					<th class="bottomTh">가격</th>
					<td id="price"><%=keep.getDosirak_price() %></td>
				</tr>

				<tr>
					<th>칸</th>
					<th colspan="7">메뉴</th>
				</tr>
<%
	for (int i=0; i<menuArray.length; i++){
		MenuDataBean menu = mDBPro.getMenu(Integer.parseInt(menuArray[i]));
%>
				<tr>
					<td>칸<%=i+1 %></td>
					<td colspan="7"><%=menu.getMenu_name() %></td>
				</tr>
<%
	}
%>
			</table>
		</form>
	</div>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
<script>
var delhidden = document.getElementById('delhidden');
var delstate = document.getElementById('delState');
console.log(delhidden.value);
if (delhidden.value == '0'){
	delstate.value = '접수대기';
} else if (delhidden.value == '1'){
	delstate.value = '접수완료';
} else if (delhidden.value == '2'){
	delstate.value = '배송출발';
} else if (delhidden.value == '3') {
	delstate.value = '배송완료';
}
</script>
</html>