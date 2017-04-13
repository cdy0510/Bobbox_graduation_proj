<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="team2.member.MemberDBBean"%>
<%@ page import="team2.member.MemberDataBean"%>
<%@ page import="team2.container.ContainerDBBean"%>
<%@ page import="team2.container.ContainerDataBean"%>
<%@ page import="team2.menu.MenuDBBean"%>
<%@ page import="team2.menu.MenuDataBean"%>
<%@ page import="team2.keep.KeepDBBean"%>
<%@ page import="team2.keep.KeepDataBean"%>
<%@ page import="team2.member_order_detail.Member_Order_DetailDBBean"%>
<%@ page import="team2.member_order_detail.Member_Order_DetailDataBean"%>
<%@ page import="team2.cybermoney.CybermoneyDBBean"%>
<%@ page import="team2.cybermoney.CybermoneyDataBean"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>::www.bobbox.com::주문</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css"
	href="../../css/keep_list_style.css"></link>
<script>
	$(function() {
		var spinner = $("#spinner").spinner();
		$("button").button();
	});
</script>
</head>
<body>
	<jsp:include page="../header.jsp" flush="false" />
	<%
		MemberDBBean dbmember = MemberDBBean.getInstance();
		Member_Order_DetailDBBean dbmod = Member_Order_DetailDBBean.getInstance();
		CybermoneyDBBean cyberdb = CybermoneyDBBean.getInstance();
		
		//로그인한 회원의 정보를 불러오는 부분
		String member_id = "";
		member_id = (String)session.getAttribute("member_id");
		int member_num = dbmember.getMember_num(member_id);
		MemberDataBean member = dbmember.findMemberInfo(member_num);
		
		//소유 밥풀 계산
	 	CybermoneyDataBean cybermoney = cyberdb.getBobpul(member_num);
		CybermoneyDataBean cybermoney2 = cyberdb.getUse_bobpul(member_num);

		int pageSize = 10;
		String pageNum = null;
		if (pageNum == null) {
		    pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int count = 0;
		int count_m = 0;
		int count_k = 0;
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		
		List<ContainerDataBean> containerList = null; 
		List<MenuDataBean> menuList = null;
		List<KeepDataBean> keepList = null;
		
		//DBBean과 연결
		ContainerDBBean dbcontainer = ContainerDBBean.getInstance();
		MenuDBBean dbmenu = MenuDBBean.getInstance();
		KeepDBBean dbkeep = KeepDBBean.getInstance();
		
		//DB내의 컬럼 갯수 산출
		count = dbcontainer.getContainerCount();
		count_m = dbmenu.getMenuCount();
		count_k = dbkeep.getBasketCount();
		
		if (count > 0) {
			containerList = dbcontainer.getContainerList(startRow, pageSize);
		}
		if(count_m > 0) {
			menuList = dbmenu.getMenuList();
		}
		if(count_k > 0) {
			keepList = dbkeep.getKeepList(member_num);
		}else {
			%>
			<script>
			alert("장바구니에 담긴 도시락이 없습니다.");
			history.go(-1);
			</script>
			<%
		}
		
		
		try{
		   
		   String selected = "";
		   String selectedcontainer = "";
		   for(int i=0;i<keepList.size();i++){
				KeepDataBean keep = keepList.get(i);
				selected = keep.getMenu_num();
				selectedcontainer += keep.getContainer_num() + ",";
		   }
			String[] menuArray = selected.split("\\,");
			String[] containerArray = selectedcontainer.split("\\,");
	%>
	<div id="hello">
		<%
			if(member_id != null){
		%>
		<span><%=member_id%>님, 보유 밥풀 : <%=cybermoney.getSum_bobpul() - cybermoney2.getSum_use_bobpul()%> 풀</span>
		<%
			} else {
		%>
		<span>안녕하세요, BOBBOX 입니다.</span>
		<%
			}
		%>
	</div>
	<div id="content">
		<img id="stepimg" src="../../img/order_title.png">

		<!-- 만들어둔 도시락 리스트 -->
		<div id="cont-list">
			<div id="container-img-box">
				<%
					for (int i = 0; i < keepList.size(); i++) {
						KeepDataBean keep = keepList.get(i);	//담아뒀던 목록 불러오기
						ContainerDataBean selectcontainer = dbcontainer.getSelectContainer(Integer.parseInt(containerArray[i]));
				%>
				<div class="container" id="container<%=i%>">
					<input type="hidden" id="keep_num<%=i%>" value="<%=keep.getKeep_num()%>"><img name="container_image" id="dosirak_image<%=i%>" src="../../fileSave/<%=selectcontainer.getContainer_image()%>" /><br>
					<div id="dorirakNameInput">
						<input type="text" id="name<%=i%>" class="dosirak_name" name="dosirak_name" value="<%=keep.getDosirak_name()%>" readonly="readonly">
					</div>
					<div id="dosirakPrice">
						<input type="text" id="dosirak_price<%=i%>" name="dosirak_price" value="<%=keep.getDosirak_price()%>" readonly="readonly" style="width: 40px;"> 풀
					</div>
				</div>
				<%
					}
				%>
			</div>
		</div>

		<!-- 도시락별로 날짜와 수량 선택 -->
		<div id="can-list">
			<div id="can-list-box">
				<div>
					<div id="title">수령날짜</div>
					<div id="datecontent">
						<input type="date" id="datePicker">
					</div>
					<div id="title">수령시간</div>
					<div id="datecontent">
						<select id="selectTime">
							<option value="아침">아침</option>
							<option value="점심">점심</option>
							<option value="저녁">저녁</option>
						</select>
					</div>
					<div id="title">수량</div>
					<div id="datecontent">
						<input id="spinner" name="value" min="1" size="3" value="1">
					</div>
					<div id="btn-area">
						<button id="getvalue">결정</button>
					</div>
				</div>
			</div>
		</div>



		<!-- 배송정보 입력 -->
		<div id="keep-list">
			<div id="deliveryInfo">
				<div id="title">결제 정보</div>
				<table id="payInfo">
					<tr>
						<td class="label">총 수량</td>
						<td><input type="text" id="sumAmount" value="0" size="5"><span>개</span></td>
					</tr>
					<tr>
						<td class="label">총 금액</td>
						<td><input type="text" id="sumPrice" value="0" size="5"><span>밥풀</span></td>
					</tr>
				</table>
				<div id="title">주문자 정보</div>
				<table>
					<tr>
						<td class="label">주문하시는 분</td>
						<td><input type="text" id="order_name" name="order_name" value="<%=member.getMember_name()%>"></td>
					</tr>
					<tr>
						<td class="label">주소</td>
						<td><input type="text" id="order_address" name="order_address" value="<%=member.getMember_address()%>"></td>
					</tr>
					<tr>
						<td class="label">휴대전화</td>
						<td><input type="text" id="order_tel" name="order_tel" value="<%=member.getMember_tel()%>"></td>
					</tr>
					<tr>
						<td class="label">이메일</td>
						<td><input type="text" id="order_mail" name="order_mail" value="<%=member.getMember_mail()%>"></td>
					</tr>
				</table>
				<div id="title">배송지 정보</div>
				<table>
					<tr>
						<td colspan="2"><input type="checkbox" id="sameData">주문자와 정보 동일</td>
					</tr>
					<tr>
						<td class="label">*받으시는 분</td>
						<td><input type="text" id="receive_name" name="receive_name"></td>
					</tr>
					<tr>
						<td class="label">*주소</td>
						<td><input type="text" id="receive_address" name="receive_address"></td>
					</tr>
					<tr>
						<td class="label">*휴대전화</td>
						<td><input type="text" id="receive_tel" name="receive_tel"></td>
					</tr>
					<tr>
						<td class="label">배송 메세지</td>
						<td>
							<textarea id="field" onkeyup="countChar(this)"></textarea>
							<span id="limitText">(<span id="charNum">0</span>/50 )</span>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>

	<!-- 선택한 용기 및 메뉴가 보임 -->
	<form name="orderForm">
		<div id="box">
			<!-- 담기는 곳 -->
			<table id="list-table">
				<tr>
					<td class="table-title" id="td_img">이미지</td>
					<td class="table-title" id="td_name">도시락명</td>
					<td class="table-title" id="td_date">수령받을 날짜</td>
					<td class="table-title" id="td_amount">수량</td>
					<td class="table-title" id="td_price">단가</td>
					<td class="table-title" id="td_sum">합계</td>
					<td class="table-title" id="td_cancel">-</td>
				</tr>
			</table>
		</div>
		<div id="hidden_data"></div>
		<input type="hidden" name="order_where" id="order_where">
		<input type="hidden" name="member_order_sum_price" id="member_order_sum_price">
		<input type="hidden" name="deliver_message" id="deliver_message">
		<img id="back-btn" src="../../img/backbtn.png" onclick="history.go(-1)">
		<img id="order-btn" src="../../img/orderbtn.png" onclick="order()">
	</form>
	<%
		}catch(Exception e){
		e.printStackTrace();
			}
	%>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
<script>
//배송날짜 선택에 default로 오늘 날짜 넣기
$(document).ready(function() {
	var now = new Date();
	var month = (now.getMonth() + 1);
	var day = now.getDate();
	if (month < 10)
		month = "0" + month;
	if (day < 10)
		day = "0" + day;
	var today = now.getFullYear() + '-' + month + '-' + day;
	$('#datePicker').val(today);
	document.getElementById('datePicker').min = today; //최소값을 오늘날짜로 지정
});

var containerNumberList = new Array();
var time = "";
var sumPrice = 0;
var sumAmount = 0;
var str = "";
var amount = 0;
var i = 0;

//용기정보 가져오기 위한 변수들
var keepNum = 0;
var dosirakImage = "";
var dosirakName = "";
var dosirakPrice = 0;

//용기 클릭js
$(".container").each(function(index, element) {
	$("#container" + index).click(function() {
		$(".container").css("outline", "0 none");
		$(".container").css("box-shadow", "0px 0px 0px #fff");
		// element == this
		$(element).css("outline", "1px solid #C7C7C7");
		$(element).css("box-shadow", "0px 0px 30px #bdbdbd");
		str = $(element).html();
		containerNumberList.push(index);
		keepNum = document.getElementById('keep_num' + index).value;
		dosirakImage = $("#dosirak_image" + index).attr('src');
		dosirakName = document.getElementById('name' + index).value;
		dosirakPrice = parseInt(document.getElementById('dosirak_price' + index).value);
	});
});

//스피너 컨트롤 js
$("#getvalue").click(function() {
	var date = document.getElementById('datePicker').value;
	amount = parseInt(document.getElementById('spinner').value);
	time = document.getElementById('selectTime').value;

	sumPrice += dosirakPrice * amount;
	sumAmount += amount;

	document.getElementById('list-table').innerHTML += "<tr class='onechoice"+i+"'><td><img src='"+dosirakImage+"'></td><td>"
			+ dosirakName + "</td><td>" + date + "  [ " + time + " ]</td><td>"
			+ amount + "</td><td>"
			+ dosirakPrice + "</td><td>"+ (dosirakPrice * amount) + "</td><td id='td_cancel'><input type='button' value='삭제' onclick='cancel("
			+ i + ")'></td></tr>";
	document.getElementById('hidden_data').innerHTML += "<input type='hidden' class='onechoice"+i+"' name='keep_num' value='"+keepNum+"'><input type='hidden' class='onechoice"+i+"' name='order_quantity' value='"+sumAmount+"'><input type='hidden' class='onechoice"+i+"' name='order_delivery_date' value='"+date+"'><input type='hidden' class='onechoice"+i+"' name='order_delivery_time' value='"+time+"'><input type='hidden' class='onechoice"
			+ i + "' name='order_price' value='" + (dosirakPrice * amount) + "'>";

	document.getElementById('sumPrice').value = sumPrice;
	document.getElementById('sumAmount').value = sumAmount;
	i++;
});

function cancel(i) {
	$(".onechoice" + i).remove();
}

//배송정보 input text
var receive_name = document.getElementById('receive_name');
var receive_address = document.getElementById('receive_address');
var receive_tel = document.getElementById('receive_tel');

//주문자정보 동일 체크박스를 클릭했을때 실행
$("#sameData").click(function() {
	if (document.getElementById('sameData').checked == true) {
		receive_name.value = document.getElementById('order_name').value;
		receive_address.value = document.getElementById('order_address').value;
		receive_tel.value = document.getElementById('order_tel').value;
	} else {
		receive_name.value = "";
		receive_address.value = "";
		receive_tel.value = "";
	}
});

function order() {
	document.getElementById('order_where').value = receive_address.value;
	document.getElementById('member_order_sum_price').value = sumPrice;
	document.getElementById('deliver_message').value = document.getElementById('field').value;
	
	
	if(receive_name.value=="" || receive_address.value=="" || receive_tel.value=="") {
		alert("배송지 정보를 정확히 작성해 주세요.");
	}else {
		orderForm.action = "orderPro.jsp";
		orderForm.submit();	
	}
}

function countChar(val) {
	var len = val.value.length;
	if (len >= 50) {
		val.value = val.value.substring(0, 50);
	} else {
		$('#charNum').text(50 - len);
	}
};
</script>
</html>


