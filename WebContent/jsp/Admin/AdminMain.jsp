<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team2.member.MemberDBBean" %>
<%@ page import="team2.member.MemberDataBean" %>

<% 
	MemberDBBean dbpro = MemberDBBean.getInstance();
%>
<%
	String member_id = "";
   try{
	   member_id = (String)session.getAttribute("member_id");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>관리자페이지</title>
<link rel="stylesheet" type="text/css" href="admincss/header_style.css"></link>
<link rel="stylesheet" type="text/css" href="../../css/footer_style.css"></link>
<link rel="stylesheet" type="text/css" href="../../css/admin_style.css"></link>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
</head>
<body>
	<div id="header">
		<div id="logo">
            <img height="80px" src="../../img/BOBBOX_LOGO_Text.png" />
		</div>
        <div id="admin-hello">
            관리자님, 안녕하세요.
            <a href="../Login/Logout.jsp">로그아웃</a>
        </div>
	</div>
	
	<div id="box">
		<div id="menu_title">
			<img src="../../img/admin_menu.png">
		</div>
		<hr>
		<div id="content">
	        <a href="Menu/AdminMenu.jsp"><img src="../../img/menu_management.png"></a>
	        <a href="Container/AdminContainer.jsp"><img src="../../img/container_management.png"></a>
	        <a href="Member/AdminMember.jsp"><img src="../../img/member_management.png"></a>
	        <a href="Supplier/AdminSupplier.jsp"><img src="../../img/supplier_management.png"></a>
	        <a href="Delivery/AdminDelivery.jsp"><img src="../../img/delivery_management.png"></a>
	        <a href="Order/AdminOrder.jsp"><img src="../../img/order_management.png"></a>
	        <a href="Board/AdminBoard.jsp"><img src="../../img/board_management.png"></a>
	        <a href="Books/AdminBook.jsp"><img src="../../img/books_management.png"></a>
        </div>
    </div>
    <jsp:include page="adminfooter.jsp" flush="false" />
    
</body>
</html>
<% 
	   
    }catch(Exception e){
		e.printStackTrace();
	}
%>