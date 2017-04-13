<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="team2.member.MemberDBBean"%>
<%@ page import="team2.member.MemberDataBean"%>
<%@ page import="team2.container.ContainerDBBean"%>
<%@ page import="team2.container.ContainerDataBean"%>
<%@ page import="team2.menu.MenuDBBean"%>
<%@ page import="team2.menu.MenuDataBean"%>
<%@ page import="team2.cybermoney.CybermoneyDBBean" %>
<%@ page import="team2.cybermoney.CybermoneyDataBean" %> 
<%@ page import="java.util.List"%>
 
<%
	MemberDBBean memberdb = MemberDBBean.getInstance();
	CybermoneyDBBean cyberdb = CybermoneyDBBean.getInstance();

	int pageSize = 10;
	String pageNum = null;
	if (pageNum == null) {
	    pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int count = 0;
	int count_m = 0;
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	List<ContainerDataBean> containerList = null; 
	List<MenuDataBean> menuList = null;
	ContainerDBBean containerdb = ContainerDBBean.getInstance();
	MenuDBBean dbmenu = MenuDBBean.getInstance();
	
	count = containerdb.getContainerCount();
	count_m = dbmenu.getMenuCount();
	
	if (count > 0) {
		containerList = containerdb.getContainerList(startRow, pageSize);
	}
	if(count_m > 0) {
		menuList = dbmenu.getMenuList();
	}
	String selected = request.getParameter("menu_selecting");
	String[] menuArray = selected.split("\\,");
	%>
<%
	String member_id = "";
   try{
	   member_id = (String)session.getAttribute("member_id");
	   int member_num = memberdb.getMember_num(member_id);
	   
	   //소유 밥풀 계산
	   CybermoneyDataBean cybermoney = cyberdb.getBobpul(member_num);
	   CybermoneyDataBean cybermoney2 = cyberdb.getUse_bobpul(member_num);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>밥먹고하조.com</title>
<link rel="stylesheet" type="text/css" href="../../css/keep_list_style.css"></link>
<script src="../../js/jquery-2.1.0.min.js"></script>
<script type="text/javascript">
var orderList = new Array();
var selectList = new Array();
var i = 0;
function goKeep(menu, container) {
	var menuName = menu.getAttribute('name');
	var menuImage = menu.getAttrubute('image');
	var menu_num = menu.getAttribute('num');
	
	orderList.push("<div id='orderList'><span>" + menuName + "</span><span id='menu_charge'>" + menuCharge + "<span id='bobfull'> 밥풀</span>"+"<span id='menu_out'><input type='button' value='x' onclick='cancel(i)'></span>"+"</span></div>");
	selectList.push(menu_num);
	console.log("selectList : "+selectList);
	console.log("menu_select : " + menu_num);
	
	$("#footer-menu-list").show();
	$("#menu-list-detail").html(orderList);
}
function cancel(i) {
	document.orderListForm.i.innerHTML = "";
}
</script>
</head>
<body>
	<jsp:include page="../header.jsp" flush="false" />

	<div id="hello">
		<% if(member_id != null){%>
		<span><%=member_id %>님, 보유 밥풀 : <%=cybermoney.getSum_bobpul() - cybermoney2.getSum_use_bobpul()%> 풀</span>
		<% } else { %>
		<span>안녕하세요, BOBBOX 입니다.</span>
		<% } %>
	</div>
	<form name="keepForm">
		<div id="content">
		<img id="stepimg" src="../../img/step_background.png">
		
		<!-- 용기 리스트 -->
			<div id="cont-list">
				<div id="container-img-box">


				<%
			for (int i = 0 ; i < containerList.size() ; i++) {
				ContainerDataBean container = containerList.get(i);
	%>
				<div class="container" id="container<%=i%>">
					<img name="container_image" src="../../fileSave/<%=container.getContainer_image() %>" /><br>
					<input type="text" id="name<%=i%>" name="container_name" value="<%=container.getContainer_name()%>" readonly="readonly">
					<div id="cont_price"><input type="text" id="container_price<%=i%>" name="container_price" value="<%=container.getContainer_price()%>" readonly="readonly" style="width: 20px;"> 풀</div>
					<input type="hidden" name="container_selecting" value="<%=container.getContainer_num()%>">
				</div>
				<%}%>
				</div>
			</div>

			<!-- 선택한 용기에 대한 칸정보 리스트 -->
			<div id="can-list">
				<div id="can-list-box">
				<% 
				for (int i = 0 ; i < containerList.size(); i++) {
					ContainerDataBean container = containerList.get(i);%>
				<div id="can-image-box">
					<img id="detail_image" class="detail_image<%=i%>" src="../../fileSave/<%=container.getContainer_detail_image()%>">
				</div>
				<%} %>
				<div>
					<div>
						<div id="cannametitle">칸이름</div>
						<div id="menutitle">메뉴</div>
					</div>
				<% 
				for (int i = 0 ; i < containerList.size(); i++) {
					ContainerDataBean container = containerList.get(i);
					for(int j = 1; j < container.getRoom_count()+1; j++){%>
					<div id="roomnumber" class="roomnumber<%=i%>">
						<div id="canname"><input class="check_menu<%=j%>" name="can" type="radio" value="<%=j%>">칸<%=j%></div>
						<div id="menu"><input type="text" id="canmenu<%=j%>" name="canmenu"></div>
					</div>
					<%}%>
				<%} %>
				</div>
				</div>
			</div>



			<!-- 메인페이지에서 선택했던 메뉴리스트 -->
			<div id="keep-list">
				<div id="keep-img-box">
				<%
				for (int i=0; i<menuArray.length; i++){
					String menuName = "";
					String menuImage = "";
					int menuNum = 0;
					String menuPrice = "";
					
					for(int j=0; j<menuList.size(); j++){
						MenuDataBean menu = menuList.get(j);
						String num = Integer.toString(menu.getMenu_num());
						if (menuArray[i].equals(num)){
							menuName = menu.getMenu_name();
							menuImage = menu.getMenu_image();
							menuNum = menu.getMenu_num();
							menuPrice = menu.getMenu_charge();
						}
					}%>
				<div class="keep" id="keep<%=i%>">
					<img name="menu_image" src="../../fileSave/<%=menuImage%>" /><br>
					<input type="text" id="menu_list<%=i%>" class="menuList" value="<%=menuName%>" readonly="readonly"><br>
					<div id="me_price"><input type="text" id="menu_price<%=i%>" value="<%=menuPrice%>" readonly="readonly" style="width: 30px;"> 풀</div>
					<input type="hidden" name="menu_selecting" value="<%=menuNum%>">
				</div>

				<%}%>
				</div>
	
<%	}catch(Exception e){
		e.printStackTrace();
	}%>
	
	</div>
		</div>
	</form>
	
	<!-- 선택한 용기 및 메뉴가 보임 -->
	<form name="choiceForm">
		<div id="box">
			<!-- 담기는 곳 -->
			<div id="choice">
				<div id="dosirakName"><label>도시락 이름 : </label><input type="text" id="dosirak_name_input" name="dosirak_name">
				<div id="sum_input"><label>총 합계 : </label><input type="text" id="dosirak_price" name="dosirak_price" style="width: 100px;" readonly="readonly"> 풀</div>
				</div>
				<div id="containerchoice"></div>
	<%			for(int i=0; i<7; i++) { %>
					<div id="choicebox<%=i%>" class="choicebox"></div>
	<%			} %>
			</div>
			<div>
				<img id="keep-btn" src="../../img/savebasket.png" onclick="keepBasket()">
				<img id="keep-btn" src="../../img/savebox.png" onclick="keepOver()">
			</div>
		</div>
		<img id="back-btn" src="../../img/backbtn.png" onclick="location.href='../home/index.jsp'">
		<img id="order-btn" src="../../img/orderbtn.png" onclick="order()">
	</form>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
<script type="text/javascript">
$( document ).ready(function() {
	var now = new Date();
	var month = (now.getMonth() + 1);               
	var day = now.getDate();
	var hour = now.getHours();
	var minute = now.getMinutes();
	var second = now.getSeconds();
	if(month < 10) 
		month = "0" + month;
	if(day < 10) 
		day = "0" + day;
	var today = now.getFullYear() + "" + month + day + hour + minute + second;
	$('#dosirak_name_input').val(today+"도시락");
});

function keepOver() {
	var form = document.choiceForm;
	form.action = "keepPro.jsp";
	form.submit();
}
function keepBasket() {
	var form = document.choiceForm;
	form.action = "basketPro.jsp";
	form.submit();
}
function order() {
	var form = document.choiceForm;
	form.action = "../Order/order.jsp";
	form.submit();
}
//용기 클릭하면 칸정보 뜸
var before = 0;
var can = document.keepForm.can;
var canmenu = document.keepForm.canmenu;
var menuinfo = document.keepForm.menuinfo;
var menuNumberList = new Array();
var containerNumberList = new Array();
var dosirak_price = 0;
$( ".container" ).each(function( index, element ) {
	$( "#container"+index ).click(function() {
		$(".container").css("outline","0 none");
		$(".detail_image"+before).css("display","none");
		$(".roomnumber"+before).css("display","none");
		$(".container" ).css( "box-shadow", "0 none" );
		$(".detail_image"+index).css("display","inline");
		$(".roomnumber"+index).css("display","inline");
		for(var i=0;i<7;i++) {
			document.getElementById('choicebox'+i).innerHTML = "";
		}
		before = index;
		// element == this
		$( element ).css( "outline", "1px solid #C7C7C7" );
		$( element ).css( "box-shadow", "0px 0px 30px #bdbdbd" );
		document.getElementById('containerchoice').innerHTML = $(element).html();
		containerNumberList.push(index);
		dosirak_price = Number(document.getElementById('container_price'+index).value);
		document.getElementById('dosirak_price').value = dosirak_price;
	});
});

//칸 클릭후 메뉴 담기
$( ".keep" ).each(function( index, element ) {
	$( "#keep"+index ).click(function() {
		$(".keep").css("outline","0 none");
		$(".keep" ).css( "box-shadow", "0 none" );
		// element == this
		$( element ).css( "outline", "1px solid #C7C7C7" );
		$( element ).css( "box-shadow", "0px 0px 30px #bdbdbd" );
		for(var i=0;i<can.length;i++){
			if(can[i].checked == true) {
				canmenu[i].value = document.getElementById('menu_list'+index).value;
				for(var j=1; j<8; j++){
					if(can[i].value == j){
						document.getElementById('choicebox'+(j-1)).innerHTML = $(element).html();
					}
				}
			}
		}
		dosirak_price += Number(document.getElementById('menu_price'+index).value);
		document.getElementById('dosirak_price').value = dosirak_price;
	});
});

</script>
</html>


