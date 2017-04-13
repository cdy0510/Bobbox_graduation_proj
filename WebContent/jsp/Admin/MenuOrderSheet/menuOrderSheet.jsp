<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="team2.supplier.*" %>
<%@ page import="team2.menu_order_detail.*" %>
<%@ page import="team2.menu_ordersheet.*" %>
<%@ page import="team2.menu.*" %>
<jsp:useBean id="menuOrderSheet" class="team2.menu_ordersheet.Menu_OrderSheetDataBean">
     <jsp:setProperty name="menuOrderSheet" property="*"/>
 </jsp:useBean>
 
<jsp:useBean id="menu" class="team2.menu.MenuDataBean">
     <jsp:setProperty name="menu" property="*"/>
 </jsp:useBean>
<% request.setCharacterEncoding("utf-8"); %>
<%
	int count = 0;
	List<Menu_OrderSheetDataBean> menuOrderSheetList = null; 
	SupplierDBBean sDBPro = SupplierDBBean.getInstance();
	MenuDBBean mDBPro = MenuDBBean.getInstance();
	Menu_OrderSheetDBBean dbPro = Menu_OrderSheetDBBean.getInstance();
	Menu_Order_DetailDBBean detailDBPro = Menu_Order_DetailDBBean.getInstance();
	count = dbPro.getMenuOrderSheetCount();
	
	if (count > 0) {
		menuOrderSheetList = dbPro.getMenuOrderSheetList();
	}
/*	
	int mCount = 0;
	List<MenuDataBean> menuList = null; 
	MenuDBBean mDBPro = MenuDBBean.getInstance();
	mCount = mDBPro.getMenuCount();
	
	if (mCount > 0) {
		menuList = mDBPro.getMenuList();
	}
*/
%> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="../../../js/jquery-2.1.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="../../../css/myordersheet_style.css"></link>
<link rel="stylesheet" type="text/css" href="../admincss/header_style.css"></link>
<link rel="stylesheet" type="text/css" href="../admincss/footer_style.css"></link>
<title>BOBBOX :: 메뉴주문서 작성</title>
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
		<form name="orderSheetForm" method="POST" action="" id="orderSheetForm">
			<div id="rootBar"><a href="../AdminMain.jsp">홈</a>&nbsp;&nbsp;>&nbsp;&nbsp;<a href="../Menu/AdminMenu.jsp">메뉴관리</a>&nbsp;&nbsp;>&nbsp;&nbsp;<span id="now_page">메뉴주문서관리</span></div>
			<div id="con-tit" class="disInline"><img src="../../../img/menuordersheet.png" /></div>
			<div id="con-sub-tit" class="disInline">수령 체크 후, 장부에서 확인할 수 있습니다.</div>
			<table>
				<tr>
					<th id="sheet_num">주문서 번호</th>
					<th id="sheet_date">주문 날짜</th>
					<th id="supplier">공급업체</th>
					<th id="sum">총 금액</th>
					<th id="pay_option">결제 방법</th>
					<th id="receipt">수령여부</th>
					<th id="btn">-</th>
				</tr>
<%
int index = 0;
String receipt = "";
	for (int i=0; i<menuOrderSheetList.size(); i++){
		menuOrderSheet = menuOrderSheetList.get(i);
		receipt = menuOrderSheet.getMenu_receipt_yes_no();
%>
				<tr>
					<td>
						<input type="text" id="sheet_num" name="sheetNum" value="<%=menuOrderSheet.getMenu_ordersheet_num()%>" readonly="readonly"/>
					</td>
					<td>
						<input type="button" id="sheetDate" onclick="goDetail(<%=menuOrderSheet.getMenu_ordersheet_num()%>)" value="<%=menuOrderSheet.getMenu_pay_date() %>" name="menu_pay_date"/>
					</td>
					<td><%=sDBPro.getSupplierNameBySupplierNum(mDBPro.getSupplierNumByMenuNum(detailDBPro.getMenuNumByMenuOrderSheetNum(menuOrderSheet.getMenu_ordersheet_num())))%></td>
					<td><input type="text" value="<%=menuOrderSheet.getMenu_order_sum_price() %>" readonly="readonly" id="sumPrice<%=i%>" name="sumPrice"/> 원
					</td>
					<td><%=menuOrderSheet.getMenu_payment_option() %></td>
					<td><input type="checkbox" value="YES" id="radioYes<%=index %>" name="menu_receipt_yes_no" <%=("YES".equals(receipt))?"disabled checked":""%> /><span class="radioTxt">수령</span>
						<input type="hidden" value="<%=menuOrderSheet.getMenu_receipt_yes_no()%>" id="radioValue<%=index%>" name="receipthidden"/>
					</td>
					<td>
						<input type="button" id="updateBtn" value="변경" onclick="goUpdate(<%=menuOrderSheet.getMenu_ordersheet_num()%>)" <%=("YES".equals(receipt))?"hidden ":""%> />
					</td>
				</tr>
<%
index++;
}
%>
			</table>
		</form>
	</div>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
<script src="../../../js/format.js"></script>
<script>

$(document).ready(function() {
	
	var receipts = document.orderSheetForm.receipthidden;
	var radioBtn = document.orderSheetForm.menu_receipt_yes_no;
	
	
	for (var i=0; i<radioBtn.length; i++){
		var yes = document.getElementById("radioYes"+i);
		var no = document.getElementById("radioNo"+i);
		var val = document.getElementById("radioValue"+i);
		if(val.value == "YES") {
			yes.checked = true;
		}else {
			no.checked = true;
		}
	}
	
});

function goDetail(sheetNum){
	var orderSheetForm = document.getElementById("orderSheetForm");
	orderSheetForm.action = "menuOrderDetail.jsp?sheetNum="+sheetNum;
	orderSheetForm.submit();
}

function goUpdate(updateNum){
	var r = confirm("한번 변경된 값은 다시 변경되지 않습니다.");
    if (r == true) {
    	var orderSheetForm = document.getElementById("orderSheetForm");
		orderSheetForm.action = "updateMenuOrderPro.jsp?updateNum="+updateNum;
		orderSheetForm.submit();
    }
}

/**
 * 콤마 찍기
 */
var sumPrice = new Array();
for (var i=0; i<<%=menuOrderSheetList.size()%>; i++){
	sumPrice[i] = document.getElementById('sumPrice'+i);
	sumPrice[i].value = sumPrice[i].value.format();
}
</script>
</html>