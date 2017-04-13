<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%@ page import="team2.member_order_detail.*" %>
<%@ page import="team2.keep.*" %>
<%@ page import="team2.member.*" %>
<%@ page import="team2.delivery.*" %>
<%@ page import="java.util.*" %>
<%

	MemberDBBean dbmember = MemberDBBean.getInstance();
	String memberId = "";
	memberId = (String)session.getAttribute("member_id");
	int memberNum = dbmember.getMember_num(memberId);

	int count = 0;
	Member_Order_DetailDBBean dbpro = Member_Order_DetailDBBean.getInstance();
	count = dbpro.getMember_Order_DetailCount();
	List<Member_Order_DetailDataBean> memberOrderDetailList = null;
	Member_Order_DetailDataBean memberOrderDetail = null;

	if (count > 0) {
		memberOrderDetailList =  dbpro.getMemberOrderDetailListByMemberId(memberId);
	}
	
	int kCount = 0;
	KeepDBBean kDBPro = KeepDBBean.getInstance();
	kCount = kDBPro.getKeepCount();
	List<KeepDataBean> keepList = null;
	KeepDataBean keep = null;
	
	if (kCount > 0){
		keepList =  kDBPro.getKeepListByMemberNum(memberNum);
	}
	
	DeliveryDBBean dDBPro = DeliveryDBBean.getInstance();
	DeliveryDataBean delivery = null;
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<title>주문리스트</title>
<link rel="stylesheet" href="../../css/my_order_list_style.css" />
<link rel="stylesheet" href="../../css/mypage_style.css" />
<script src="../../../js/jquery-2.1.0.min.js"></script>
</head>
<body>
	<jsp:include page="header.jsp" flush="false" />
	<div id="rootBar"><a href="../home/index.jsp">홈</a>&nbsp;&nbsp;>&nbsp;&nbsp;<a href="myOrderList.jsp">마이페이지</a>&nbsp;&nbsp;>&nbsp;&nbsp;<span id="now_page">전체주문내역</span></div>
	<jsp:include page="myPageTopNav.jsp" flush="false" />
	<jsp:include page="myPageLeftNav.jsp" flush="false" />
	<div id="contents">
		<div id="con-tit"><img src="../../img/allorderlist.gif" /></div>		
		<table>
			<tr>
				<th>주문일</th>
				<th>상품명</th>
				<th>주문번호</th>
				<th>주문상태</th>
			</tr>
<%
if(count < 1) {
	%>
	<tr>
		<td colspan="4">주문된 상품이 없습니다.</td>
	</tr>
	<%
}else {
for (int i=0; i<memberOrderDetailList.size(); i++){
	memberOrderDetail = memberOrderDetailList.get(i);
	keep = keepList.get(i);
	delivery = dDBPro.getDelivery(memberOrderDetail.getMember_order_detail_num());
%>
			<tr>
				<td><%=memberOrderDetail.getMember_pay_date() %></td>
				<td><%=keep.getDosirak_name() %></td>
				<td><%=memberOrderDetail.getMember_order_detail_num() %></td>
				<td><input type="text" name="orderState" id="state<%=i %>" />
					<input type="hidden" value="<%=delivery.getDelivery_statement() %>" id="statehidden<%=i %>" />
				</td>
			</tr>
<% 
	}
}
%>
		</table>
		
		<div id="delivery-tit">
			<img src="../../img/order_delivery.gif" />
		</div>
		<div id="delivery-sub-tit">주문/결제 Tip!</div>
		<div id="delivery-info">
			<ul>
				<li>무통장 입금 주문하신 경우, <span class="txtBold">5일내에 전용계좌로 입금</span>하셔야 하며 <span class="txtBold">입금자명과 회원명이 달라도 결제처리</span> 됩니다.</li>
				<li>(입금확인중 주문건이 있는 경우 마이옥션 메인페이지 상단에 계좌정보가 노출 됩니다.)</li>
				<li>입금확인중/결제완료 단계에서 주문수정 버튼을 클릭하시면 <span class="txtBold">배송지정보와 배송시요구사항을 변경</span>하실 수 있습니다.</li>
				<li>결제수단 변경은 어려우니, 결제수단 변경이 필요한 경우 취소 후 재주문을 부탁 드립니다.</li>
				<li>결제번호를 클릭하시면 주문상세내역을 확인하실 수 있으며, <span class="txtBold">영수증은 주문상세내역에서 출력</span>하실 수 있습니다.</li>
			</ul>
		</div>
		<div id="delivery-sub-tit">배송 Tip!</div>
		<div id="delivery-info">
			<ul>
				<li>상품이 택배사로 인도되면 배송중상태가 되며, 배송조회를 클릭하시면 상품의 위치를 확인할 수 있습니다. 배송 관련 문의는 택배사로</li>
				<li>문의하시면 빠른 확인이 가능합니다. </li>
				<li>택배 송장 조회결과 <span class="txtBold">배송완료</span>인 상품은 배송완료상태로 변경되며, <span class="txtBold">8일 후에는 자동으로 구매결정 처리</span> 됩니다.</li>
				<li>구매결정 시 상품후기를 작성하시면 밥풀을 받으실 수 있으며, <span class="txtBold">구매결정 이후에는 반품 및 교환이 되지 않습니다.</span></li>
			</ul>
		</div>
	</div>
	
	<jsp:include page="footer.jsp" flush="false" />
</body>
<%if(count > 0) { %>
<script>
var state = new Array();
var stateHidden = new Array();
for (i=0; i<<%=memberOrderDetailList.size()%>; i++){
	stateHidden[i] = document.getElementById('statehidden'+i);
	state[i] = document.getElementById('state'+i);
	if (stateHidden[i].value == '0'){
		state[i].value = '접수대기';
	} else if (stateHidden[i].value == '1'){
		state[i].value = '접수완료';
	} else if (stateHidden[i].value == '2'){
		state[i].value = '배송출발';
	} else if (stateHidden[i].value == '3'){
		state[i].value = '배송완료';	
	}
	
}
</script>
<%} %>
</html>