<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team2.member_order.*" %>
<%@ page import="team2.member_order_detail.*" %>
<%@ page import="team2.delivery.*" %>
<%@ page import="java.util.List" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="memberOrder" class="team2.member_order.Member_OrderDataBean">
	<jsp:setProperty name="memberOrder" property="*"/>
</jsp:useBean>
<jsp:useBean id="memberOrderDetail" class="team2.member_order_detail.Member_Order_DetailDataBean">
	<jsp:setProperty name="memberOrderDetail" property="*" />
</jsp:useBean>
<jsp:useBean id="delivery" class="team2.delivery.DeliveryDataBean">
	<jsp:setProperty name="delivery" property="*" />
</jsp:useBean>
 <%
 	int count = 0;
 	List<Member_OrderDataBean> memberOrderList = null;
 	Member_OrderDBBean dbpro = Member_OrderDBBean.getInstance();
 	count = dbpro.getMemberOrderCount();
 	
 	if (count > 0){
 		memberOrderList = dbpro.getMemberOrderList();
 	}
 	
 	int dCount = 0;
 	List<Member_Order_DetailDataBean> memberOrderDetailList = null;
 	Member_Order_DetailDBBean dDBPro = Member_Order_DetailDBBean.getInstance();
 	dCount = dDBPro.getMember_Order_DetailCount();
 	
 	if (dCount > 0){
 		memberOrderDetailList = dDBPro.getMemberOrderDetailList();
 	}
 	
 	int delCount = 0;
 	List<DeliveryDataBean> deliveryList = null;
	DeliveryDBBean delDBPro = DeliveryDBBean.getInstance();
	delCount = delDBPro.getDeliveryCount();
	
	if (delCount > 0){
		deliveryList = delDBPro.getDeliveryList();
	}
 	
 %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>관리자</title>
<link rel="stylesheet" type="text/css" href="../admincss/header_style.css"></link>
<link rel="stylesheet" type="text/css" href="../admincss/order_style.css"></link>
</head>
<body>
	<div id="header">
		<div id="logo">
            <img height="80px" src="../../../img/BOBBOX_LOGO_Text.png" />
		</div>
        <div id="admin-hello">
            관리자님, 안녕하세요.
            <a href="../../Login/Logout.jsp">로그아웃</a>
        </div>
	</div>
    <div id="order-header">
    	<div id="rootBar"><a href="../AdminMain.jsp">Home</a>&nbsp;&nbsp;>&nbsp;&nbsp;<span id="now_page">주문관리</span></div>
    </div>
	<div id="contents">        
    <form name="orderForm" id="orderForm" method="POST">
    <div id="head-tit"><img src="../../../img/order.png" /></div>
    	<div class="floatRight">
	        <input type="button" value="접수완료" onclick="updateDelivery(1)" name="stateBtn" />
	        <input type="button" value="배송출발" onclick="updateDelivery(2)" name="stateBtn" />
	        <input type="button" value="배송완료" onclick="updateDelivery(3)" name="stateBtn" />
			<input type="button" value="숨기기" onclick="updateDelivery(4)" name="stateBtn" />
		</div>
		<table>
			<tr>
				<th><input type="checkbox" onclick="allCk(this.checked)" /></th>
				<th>주문번호</th>
				<th>상태</th>
				<th>주문일시</th>
				<th>회원ID</th>
				<th>배송예정일</th>
				<th>배송시간</th>
				<th>배송지</th>
				<th>주문수량(개)</th>
				<th>주문금액(원)</th>
			</tr>
<%
for(int i=0; i<memberOrderDetailList.size(); i++){
	memberOrderDetail = memberOrderDetailList.get(i);
	delivery = deliveryList.get(i);
	if (delivery.getDelivery_statement().equals("4")){ %>
		<input type="hidden" id="statement<%=i%>" name="stateTxt" readonly="readonly"/>
		<input type="hidden" value="<%=delivery.getDelivery_statement() %>" id="statehidden<%=i %>" />	
<%
	} else {
%>
	<tr id="detailTr">
	<td><input type="checkbox" name="order_chk" value="<%=delivery.getDelivery_num()%>"/></td>
	<td><%=memberOrderDetail.getMember_order_num() %></td>
	<td onclick="goDetail(<%=memberOrderDetail.getMember_order_detail_num()%>)">
		<input type="text" id="statement<%=i%>" name="stateTxt" readonly="readonly"/>
		<input type="hidden" value="<%=delivery.getDelivery_statement() %>" id="statehidden<%=i %>" />
	</td>
	<td onclick="goDetail(<%=memberOrderDetail.getMember_order_detail_num()%>)"><%=memberOrderDetail.getMember_pay_date() %></td>
	<td onclick="goDetail(<%=memberOrderDetail.getMember_order_detail_num()%>)"><%=memberOrderDetail.getMember_id() %></td>
	<td onclick="goDetail(<%=memberOrderDetail.getMember_order_detail_num()%>)"><%=memberOrderDetail.getOrder_delivery_date() %></td>
	<td onclick="goDetail(<%=memberOrderDetail.getMember_order_detail_num()%>)"><%=memberOrderDetail.getOrder_delivery_time() %></td>
	<td onclick="goDetail(<%=memberOrderDetail.getMember_order_detail_num()%>)"><%=memberOrderDetail.getOrder_where() %></td>
	<td onclick="goDetail(<%=memberOrderDetail.getMember_order_detail_num()%>)"><%=memberOrderDetail.getOrder_quantity() %></td>
	<td onclick="goDetail(<%=memberOrderDetail.getMember_order_detail_num()%>)"><%=memberOrderDetail.getOrder_price() %></td>
</tr>
<%
	}
}
%>
		</table>
	</form>
	</div>
	<jsp:include page="../footer.jsp" flush="false"/>
</body>
<script>
var orderForm = document.getElementById('orderForm');
var stateArray = new Array();
for (var i=0; i<<%=memberOrderDetailList.size()%>; i++){
	stateArray[i] = document.getElementById('statehidden'+i);
	var hiddenVal = stateArray[i].value;
	var stateVal = document.getElementById('statement'+i);
	
	if (hiddenVal == '0') {
		stateVal.value = '접수대기';
	} else if (hiddenVal == '1') {
		stateVal.value = '접수완료';
	} else if (hiddenVal == '2') {
		stateVal.value = '배송출발';
	} else if (hiddenVal == '3') {
		stateVal.value = '배송완료';
	}
}

 /* 주문상세로 이동 */
function goDetail(detailNum){
	orderForm.action='AdminOrderDetail.jsp?detailNum='+detailNum;
	orderForm.submit();
}
 /* 전체 체크 */
function allCk(objCheck){ 
	var checks = document.getElementsByName('order_chk');
	for(var i=0; i<checks.length; i++ ){
	 checks[i].checked = objCheck; 
	}
}

 /* 배송 상태 수정*/
function updateDelivery(state){
	orderForm.action = 'updateDeliveryPro.jsp?state='+state;
	orderForm.submit();
}
</script>
</html>