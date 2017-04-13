<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="../../css/order_box_style.css"></link>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>


<form name="orderListForm" id="orderListForm" action="" method="POST">
	<div id="footer-order">
			<div id="footer-menu-select"><img src="../../img/menu_select.png" /></div>
	</div>
	<div id="footer-menu-list">
		<div id="menu-list-detail"></div>
		<div id="menu-price">
			<div id="menu-list"></div>
			<div id="keep-btn"><img src="../../img/pickup.png" onclick="goOrder();" /></div>
		</div>
		<div id="menu-list-closed">× 닫기</div>
	</div>
</form>


<script type="text/javascript">
function goOrder(){
	var orderListForm = document.getElementById("orderListForm");
	orderListForm.action = "orderListPro.jsp";
	orderListForm.submit();
}
</script>