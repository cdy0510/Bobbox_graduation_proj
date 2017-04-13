<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="team2.menu.MenuDBBean" %>
<%@ page import="team2.menu.MenuDataBean" %>
<%@ page import="team2.supplier.SupplierDBBean" %>
<%@ page import="team2.supplier.SupplierDataBean" %>
 
<%
	String supplier_name = request.getParameter("supplier_name");
	List<MenuDataBean> menuList = null; 
	MenuDBBean menudb = MenuDBBean.getInstance();
	
	
	if (supplier_name != null) {
		menuList = menudb.getSupplierMenuList(supplier_name);
	}else {
		supplier_name = "(주)세진물산";
		menuList = menudb.getSupplierMenuList(supplier_name);
	}
	
	// Supplier
	int sPageSize = 10;
	String sPageNum = null;
	if (sPageNum == null) {
		sPageNum = "1";
	}
	int sCurrentPage = Integer.parseInt(sPageNum);
	int sCount = 0;
	int sStartRow = (sCurrentPage - 1) * sPageSize + 1;
	int sEndRow = sCurrentPage * sPageSize;
	
	List<SupplierDataBean> supplierList = null; 
	SupplierDBBean sDBPro = SupplierDBBean.getInstance();
	
	int count = sDBPro.getSupplierCount();
	
	if (count > 0) {
		supplierList = sDBPro.getSupplierList(sStartRow, sPageSize);
	}

%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>관리자</title>
<link rel="stylesheet" type="text/css" href="../admincss/header_style.css"></link>
<link rel="stylesheet" type="text/css" href="../../../css/menu_style.css"></link>
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
    <div id="content-header">
    	<div id="rootBar"><a href="../AdminMain.jsp">Home</a>&nbsp;&nbsp;>&nbsp;&nbsp;<span id="now_page">메뉴관리</span>&nbsp;&nbsp;>&nbsp;&nbsp;<a href="../MenuOrderSheet/menuOrderSheet.jsp">메뉴주문서관리</a></div>
    	<form name="supplierForm" id="supplierForm" method="POST" target="menuFrame">
    		<select name="supplier_num" onchange="showMenu(this)">
    		<option value="-">공급업체 선택</option>
<% 
for(int j=0; j<supplierList.size(); j++) {
	SupplierDataBean supplier = supplierList.get(j);
%>
   				<option value="<%=supplier.getSupplier_name()%>"><%=supplier.getSupplier_name() %></option>
 				<%
}
   				%>
   			</select>
    	</form>
    	<span class="floatRight" id="btnBox">
       		<span id="menu-btn" onclick="orderGo();">주문</span>
	        <span id="menu-btn" onclick="location.href='insertMenuForm.jsp'">등록</span>
	        <span id="menu-btn" onclick="deleteGo();">삭제</span>
	    </span>
    </div>
	<div id="contents">        
        <form name="menuForm" id="menuForm" method="POST">
		<table>
		    <tr>
		       <th id="chk"><input type="checkbox" onclick="allCk(this.checked);"></th>
		       <th id="num">번호</th>
		       <th id="big-class">대분류</th>
		       <th id="menu-name">이름</th>
		       <th id="bob-full">밥풀</th>
		       <th id="kcal">열량(kcal)</th>
		       <th id="supp">공급업체</th>
		       <th id="cost">공급원가</th>
		       <th id="btn">-</th>
		   </tr>
		<% for (int i = 0 ; i < menuList.size() ; i++) {
			MenuDataBean menu = menuList.get(i);
%>
			<tr>
			    <td><input type="checkbox" value="<%=menu.getMenu_num()%>" name="menu_chk" /></td>
			    <td><%=menu.getMenu_num() %></td>
			    <td><%=menu.getMenu_big_class() %></td>
			    <td><%=menu.getMenu_name() %></td>
			    <td><%=menu.getMenu_charge() %></td>
			    <td><%=menu.getMenu_kcal() %></td>
			    <td><%=menu.getSupplier_name() %></td>
			    <td><input type="text" value="<%=menu.getMenu_cost() %>" id="cost<%=i%>" class="cost"/> 원</td>
			    <td><input type="button" id="update-btn" value="수정" onclick="updateGo(<%=menu.getMenu_num() %>)"></td> 
			</tr>
		<%} %>
		 </table>
	</form>
	</div>
	<jsp:include page="../footer.jsp" flush="false"/>
</body>
<script src="../../../js/format.js"></script>
<script type="text/javascript">

function allCk(objCheck){ 
	var checks = document.getElementsByName('menu_chk');
	for(var i=0; i<checks.length; i++ ){
	 checks[i].checked = objCheck; 
	}
}

function orderGo(){
	var check = document.getElementsByName('menu_chk');
	var j=0;
	for (var i=0; i<check.length; i++){
		if (check[i].checked == true){
			j++;
		}
	}
	if (j>0) {
		var menuForm = document.getElementById("menuForm");
		menuForm.action = "../MenuOrderSheet/insertMenuOrderSheet.jsp";
		menuForm.submit();	
	} else {
		alert('1개 이상의 메뉴를 체크해주세요.');
	}
}

function deleteGo(){
	if (confirm('정말로 삭제하시겠습니까?')){
		var menuForm = document.getElementById("menuForm");
		menuForm.action = "deleteMenuPro.jsp";
		menuForm.submit();
	}
	return false;
}

function updateGo(i){
	var menuForm = document.getElementById("menuForm");
	menuForm.action = "updateMenuForm.jsp?menuNumber="+i;
	menuForm.submit();
	return false;
}

function showMenu(parentBox){
	var obj = parentBox.options[parentBox.selectedIndex].value;
	document.supplierForm.action = "AdminMenu.jsp?supplier_name="+ obj;
	document.supplierForm.submit();
}


/**
 * 공급원가 ,찍기
 */
var cost = new Array();
for (var k=0; k<<%=menuList.size()%>; k++){
	cost[k] = document.getElementById('cost'+k);
	cost[k].value = cost[k].value.format();
}
</script>
</html>