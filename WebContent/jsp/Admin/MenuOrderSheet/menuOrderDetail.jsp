<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="team2.menu.*" %>
<%@ page import="team2.menu_ordersheet.*" %>
<%@ page import="team2.menu_order_detail.*" %>
<%@ page import="team2.supplier.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%
	int orderNum = Integer.parseInt(request.getParameter("sheetNum"));
	int count = 0;
	
	Menu_Order_DetailDBBean dbpro = Menu_Order_DetailDBBean.getInstance();
	count = dbpro.getMenu_Order_DetailCount();
	List<Menu_Order_DetailDataBean> menuDetailList = null;
	
	MenuDBBean mDBPro = MenuDBBean.getInstance();
	SupplierDBBean sDBPro = SupplierDBBean.getInstance();
	if (count > 0){
		menuDetailList = dbpro.getMenu_Order_DetailByOrderSheet(orderNum);
	}
	
%>
<jsp:useBean id="menuDetail" class="team2.menu_order_detail.Menu_Order_DetailDataBean">
     <jsp:setProperty name="menuDetail" property="*"/>
 </jsp:useBean>
 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="../admincss/admin_style.css"></link>
<link rel="stylesheet" type="text/css" href="../admincss/header_style.css"></link>
<link rel="stylesheet" type="text/css" href="../admincss/myordersheet_style.css"></link>
<title>BOBBOX :: 메뉴주문서 주문</title>
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
		<div id="rootBar"><a href="Main.jsp">홈</a>&nbsp;&nbsp;>&nbsp;&nbsp;<a href="../Menu/AdminMenu.jsp">메뉴관리</a>&nbsp;&nbsp;>&nbsp;&nbsp;<a href="menuOrderSheet.jsp">메뉴주문서관리</a>&nbsp;&nbsp;>&nbsp;&nbsp;<span id="now_page">메뉴 상세 주문서</span></div>
			<div id="con-tit"><img src="../../../img/menudetail.png" /></div>
			<table id="orderBoxTop">
				<tr>
					<th>공급업체</th>
					<td><input type="text" readonly="readonly" id="detailSupplier" /></td>
					<th>주문일자</th>
					<td><input type="text" id="menupaydate" readonly="readonly"/></td>
				</tr>
				<tr>
					<th>대표자명</th>
					<td>
						<input type="text" readonly="readonly" value="" id="supplier_Man"/>
					</td>
					<th>계좌정보</th>
					<td>
						<input type="text" readonly="readonly" value="" id="supplier_Bank" />
						<input type="text" readonly="readonly" value="" id="supplier_Account" />
					</td>
				</tr>
			</table>
			
			<table id="orderBoxBottom">
				<tr>
					<th id="detailnum">번호</th>
					<th>품명</th>
					<th>수량</th>
					<th>가격</th>
				</tr>
<% for(int i=0; i<menuDetailList.size(); i++) {
	menuDetail = menuDetailList.get(i);
	String supName = sDBPro.getSupplierNameBySupplierNum(mDBPro.getSupplierNumByMenuNum(menuDetail.getMenu_num()));
	SupplierDataBean supplier = sDBPro.findSupplierInfo(mDBPro.getSupplierNumByMenuNum(menuDetail.getMenu_num()));
	int menuOrderSheetNum = menuDetail.getMenu_ordersheet_num();
	Timestamp payDate = dbpro.getMenuPayDateByMenuOrderSheetNum(menuOrderSheetNum);
%> 
				<tr>
					<td><%=i+1%></td>
					<td><%=menuDetail.getMenu_name()%>
						<input type="hidden" value="<%=supName %>" id="supplierName" />
						<input type="hidden" value="<%=supplier.getSupplier_man_name() %>" id="supplierMan" />
						<input type="hidden" value="<%=supplier.getSupplier_bank() %>" id="supplierBank" />
						<input type="hidden" value="<%=supplier.getSupplier_account_data() %>" id="supplierAccount"/>
						<input type="hidden" value="<%=payDate %>" id="payDate"/>
					</td>
					<td><%=menuDetail.getMenu_quantity() %> 개</td>
					<td><input type="text" value="<%=menuDetail.getMenu_sum_price() %>" name="sumP" id="sumPrice<%=i%>" readonly="readonly"/> 원</td>
				</tr>
<% } %>
			</table>
		</form>
	</div>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
<script src="../../../js/format.js"></script>
<script>
var sName = document.getElementById('supplierName').value;
var sMan = document.getElementById('supplierMan').value;
var sBank = document.getElementById('supplierBank').value;
var sAccount = document.getElementById('supplierAccount').value;
var pay = document.getElementById('payDate').value;

document.getElementById('detailSupplier').value = sName;
document.getElementById('supplier_Man').value = sMan;
document.getElementById('supplier_Bank').value = sBank;
document.getElementById('supplier_Account').value = sAccount;
document.getElementById('menupaydate').value = pay;

var sumPrice = new Array();
for (var i=0; i<<%=menuDetailList.size()%>; i++){
	sumPrice[i] = document.getElementById('sumPrice'+i);
	sumPrice[i].value = sumPrice[i].value.format();
}
</script>
</html>