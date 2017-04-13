<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="team2.menu.MenuDBBean" %>
<%@ page import="team2.menu.MenuDataBean" %>
<%@ page import="team2.menu_ordersheet.Menu_OrderSheetDBBean" %>
<%@ page import="team2.menu_ordersheet.Menu_OrderSheetDataBean" %>
<% 
	String orderArray[] = request.getParameterValues("menu_chk"); 
%>
<%
	MenuDBBean mDBPro = MenuDBBean.getInstance();
	MenuDataBean menu = mDBPro.getMenu(Integer.parseInt(orderArray[0]));
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="../admincss/header_style.css"></link>
<link rel="stylesheet" type="text/css" href="../../../css/insert_ordersheet_style.css"></link>
<link rel="stylesheet" type="text/css" href="../admincss/footer_style.css"></link>
<title>BOBBOX :: 메뉴주문서 주문</title>
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
	<div id="ordersheet_contents">
	<form action="insertMenuOrderSheetPro.jsp" method="POST">
	<div id="rootBar"><a href="../AdminMain.jsp">홈</a>&nbsp;&nbsp;>&nbsp;&nbsp;<a href="../Menu/AdminMenu.jsp">메뉴관리</a>&nbsp;&nbsp;>&nbsp;&nbsp;<span id="now_page">메뉴주문하기</span></div>
		
			<table id="orderBoxTop">
				<tr>
					<th>공급업체</th>
					<td><input type="text" readonly="readonly" value="<%=menu.getSupplier_name() %>" name="supplier_name"/></td>
					<th>주문일자</th>
					<td><input type="date" id="paydate" readonly="readonly"/></td>
				</tr>
			</table>
			
			<table id="orderBoxMiddle">
				<tr>
					<th id="menuName">품명</th>
					<th id="menuQuan">수량</th>
					<th id="menuPrice">단가</th>
					<th id="menuSum">가격</th>
				</tr>
<% for(int i=0; i<orderArray.length; i++) {
	menu = mDBPro.getMenu(Integer.parseInt(orderArray[i]));
%>
				<tr>
					<td><%=menu.getMenu_name()%>
						<input type="hidden" value="<%=menu.getMenu_num()%>" name="menu_num"/>
					</td>
					<td>
						<select name="menu_quantity" onchange="updateSum()" id="quan<%=i%>">
							<option>0</option>
							<option>50</option>
							<option>100</option>
							<option>200</option>
							<option>300</option>
							<option>400</option>
							<option>500</option>
						</select> 개
					</td>
					<td><input type="text" class="cost_price" id="costPrice<%=i %>" value="<%=menu.getMenu_cost() %>" readonly="readonly"/> 원</td>
					<td><input type="text" class="sum_price" id="sumPrice<%=i %>" name="menu_sum_price" readonly="readonly"/> 원</td>
				</tr>
<% } %>
			</table>
			
			<table id="orderBoxBottom">				
				<tr>
					<th>총금액</th>
					<td><input type="text" name="menu_order_sum_price" readonly="readonly" value="" id="orderSum" class="sum_price"/> 원</td>
					<th>결제방법</th>
					<td>
						<input type="radio" value="무통장입금" checked="checked" name="menu_payment_option"/>무통장입금
						<input type="radio" value="신용카드" name="menu_payment_option"/>신용카드
					</td>
				</tr>
			</table>
			
			<div id="submit-btn"><input type="submit" value="주문하기" onclick="updateFormat()"/></div>
		</form>
	</div>
	<jsp:include page="../footer.jsp" flush="false"/>
</body>
<script src="../../../js/format.js"></script>
<script>
document.getElementById('paydate').valueAsDate = new Date();

function updateSum(){
	var arrayLength = <%=orderArray.length%>;
	var quan = new Array();
	var price = new Array();
	var sum = new Array();
	var orderSum = document.getElementById('orderSum');
	var osum = 0;
	orderSum.value="";
	
	for (var j=0; j<arrayLength; j++){
		quan[j] = document.getElementById('quan'+j);
		price[j] = document.getElementById('costPrice'+j);
		sum[j] = document.getElementById('sumPrice'+j);
		if (quan[j]!="0"){
			price[j].value = price[j].value.replace(/[^\d]+/g, '');
			sum[j].value = (quan[j].value)*(price[j].value);
			osum += parseInt(sum[j].value);
		}
		orderSum.value = osum.format();
		price[j].value = price[j].value.format();
		sum[j].value = sum[j].value.format();
	}
}

var cost = new Array();
for (k=0; k<<%=orderArray.length%>; k++){
	cost[k] = document.getElementById('costPrice'+k);
	cost[k].value = cost[k].value.format();
}

function updateFormat(){
	orderSum.value = orderSum.value.replace(/[^\d]+/g, '');
}
</script>
</html>