<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%@ page import="team2.member.MemberDBBean"%>
<%@ page import="team2.member.MemberDataBean"%>
<%@ page import="team2.container.ContainerDBBean"%>
<%@ page import="team2.container.ContainerDataBean"%>
<%@ page import="team2.menu.MenuDBBean"%>
<%@ page import="team2.menu.MenuDataBean"%>
<%@ page import="team2.keep.KeepDBBean"%>
<%@ page import="team2.keep.KeepDataBean"%>
<%@ page import="java.util.List"%>
<%
MemberDBBean dbmember = MemberDBBean.getInstance();

int count_k = 0;
int sumPrice = 0;

List<KeepDataBean> keepList = null;

String member_id = "";

//DBBean과 연결
ContainerDBBean dbcontainer = ContainerDBBean.getInstance();
MenuDBBean dbmenu = MenuDBBean.getInstance();
KeepDBBean dbkeep = KeepDBBean.getInstance();

//DB내의 컬럼 갯수 산출
count_k = dbkeep.getKeepCount();
	
try{
	//로그인한 회원의 정보를 불러오는 부분
	member_id = (String)session.getAttribute("member_id");
	int member_num = dbmember.getMember_num(member_id);
	MemberDataBean member = dbmember.findMemberInfo(member_num);
	if(count_k > 0) {
		keepList = dbkeep.getDosirakList(member_num);
	}
	   
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<title>BOBBOX :: 회원등급</title>
<link rel="stylesheet" href="../../css/my_bobbox_style.css" />
<link rel="stylesheet" href="../../css/mypage_style.css" />
<script src="../../../js/jquery-2.1.0.min.js"></script>
</head>
<body>
	<jsp:include page="header.jsp" flush="false" />
	<div id="rootBar"><a href="../home/index.jsp">홈</a>&nbsp;&nbsp;>&nbsp;&nbsp;<a href="myOrderList.jsp">마이페이지</a>&nbsp;&nbsp;>&nbsp;&nbsp;<span id="now_page">나만의 도시락</span></div>
	<jsp:include page="myPageTopNav.jsp" flush="false" />
	<jsp:include page="myPageLeftNav.jsp" flush="false" />
	<div id="contents">
		<div id="con-tit"><img src="../../img/mydosirak.png" /></div>
		<div id="bobbox">
			<span id="tit"><%=dbmember.getMember_name(member_id) %> 님이 만든 도시락 입니다.</span>
			<input type="button" class="btn" id="orderBtn" value="주문" onclick="GoOrder()">
			<div id="table_area">
			<form name="keep_dosirak">
			<table>
			<%						
			for (int i = 0; i < keepList.size(); i++) {
				KeepDataBean keep = keepList.get(i);	//담아뒀던 목록 불러오기
				ContainerDataBean selectcontainer = dbcontainer.getSelectContainer(keep.getContainer_num());
%>
				<tr>
					<td id="check" class="top">
						<input type="checkbox" value="<%=keep.getKeep_num()%>" name="keep_check"/>
					</td>
					<td id="delete" class="top">
						<input type="button" id="deleteBtn" value="삭제" class="btn" onclick="godelete(<%=keep.getKeep_num()%>)"/>
					</td>
					<td id="dosirak" class="top"><span class="txtBold"><%=keep.getDosirak_name() %></span></td>
					<td id="price" class="top"><span class="txtBold"><%=keep.getDosirak_price() %></span> 풀</td>
				</tr>
				<tr>
					<!-- 나만의 도시락 용기 -->
					<td colspan="2" id="container" class="bottom">
						<span>
							<span id="container_image"><img src="../../fileSave/<%=selectcontainer.getContainer_image() %>" /></span>
							<span id="container_name"><%=selectcontainer.getContainer_name() %></span>
						</span>
					</td>
					
					<!-- 나만의 도시락 메뉴 리스트 -->
					<td colspan="2" id="menu" class="bottom">
				<%
				String keepMenu = keep.getMenu_num();
				String[] MenuArray = keepMenu.split("\\,");
				for (int j=0; j<MenuArray.length; j++){
					int menuNum = 0;
					String menuName = "";
					String menuImage = "";
					String menuPrice = "";
					MenuDataBean menu = dbmenu.getMenu(Integer.parseInt(MenuArray[j]));
					menuName = menu.getMenu_name();
					menuImage = menu.getMenu_image();
					menuNum = menu.getMenu_num();
					menuPrice = menu.getMenu_charge();
				%>
						<span class="floatLeft">
							<span id="menu_image"><img src="../../fileSave/<%=menuImage %>" /></span>
							<span id="menu_name"><%=menuName %></span>
						</span>
						
				<%} %>
					</td>
					
				</tr>
				<%} %>
				<%}catch (Exception e) { e.printStackTrace(); }%>
				
			</table>
			</form>
		<div id="bobbox-tit">
			<img src="../../img/aboutdosirak.png" />
		</div>
		<div id="bobbox-sub-tit">맞춤형 도시락 Tip!</div>
		<div id="bobbox-info">
			<ul>
				<li>메인페이지에서 원하는 메뉴를 선택하고 <span class="txtBold">담아두기</span>를 누르시면 주문페이지로 이동합니다.</li>
				<li>원하는 용기를 선택하신 후, <span class="txtBold">해당칸에 선택하신 메뉴 중 하나를 </span>넣으셔야 하며 <span class="txtBold">같은메뉴를 여러변 선택</span> 하실 수 있습니다.</li>
				<li>도시락을 완성하신 경우 <span class="txtBold">도시락의 이름과 저장여부를 선택</span>하실 수 있습니다.</li>
				<li>도시락 저장을 원하시는 경우, <span class="txtBold">마이페이지의 나만의 도시락</span>에서 확인 하실 수 있습니다.</li>
			</ul>
		</div>
		<div id="bobbox-sub-tit">도시락 주문 Tip!</div>
		<div id="bobbox-info">
			<ul>
				<li>나만의 도시락에서 주문 버튼을 클릭하시면 바로 주문 페이지로 이동합니다.</li>
				<li>원하시는 배송날짜와 수량을 작성 하신뒤 수취인의 정보 또한 빠짐없이 상세하기 작성해 주시기 바랍니다.</li>
				<li>밥박스의 모든 도시락은 <span class="txtBold">사이버머니 결제 시스템(BOBFULL)</span>을 도입하여 선 충전후 구매가 가능하며, </li>
				<li>구매결정 시 상품후기를 작성하시면 밥풀을 받으실 수 있으며, <span class="txtBold">구매결정 이후에는 반품 및 교환이 되지 않습니다.</span></li>
			</ul>
			</div>
		</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" flush="false" />
	<script>
	function godelete(i) {
		location.href="deleteKeep.jsp?keep_num="+i;
	}
	function GoOrder() {
		var check = document.getElementsByName('keep_check');
		var j=0;
		for (var i=0; i<check.length; i++){
			if (check[i].checked == true){
				j++;
			}
		}
		if (j>0) {
			var keepForm = document.keep_dosirak;
			keepForm.action = "../Order/orderKeep.jsp";
			keepForm.submit();	
		} else {
			alert('1개 이상의 도시락을 체크해주세요.');
		}
	}
	</script>
</body>
</html>