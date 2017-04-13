<%@ page import="com.mysql.fabric.xmlrpc.base.Value"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team2.member.MemberDBBean" %>
<%@ page import="team2.member.MemberDataBean" %>
<%@ page import="team2.menu.MenuDBBean" %>
<%@ page import="team2.menu.MenuDataBean" %> 
<%@ page import="team2.cybermoney.CybermoneyDBBean" %>
<%@ page import="team2.cybermoney.CybermoneyDataBean" %> 
<%@ page import="team2.admin_board.*" %>
<%@ page import="java.util.*" %> 

<%
	MemberDBBean memberdb = MemberDBBean.getInstance();
	CybermoneyDBBean cyberdb = CybermoneyDBBean.getInstance();
	List<MenuDataBean> menuList = null; 
	MenuDBBean menudb = MenuDBBean.getInstance();
	String[] menuArray = {};
	Admin_BoardDBBean boarddb = Admin_BoardDBBean.getInstance();
	
	String menu_sort = request.getParameter("menu_sort");
	String menu_selecting = request.getParameter("menu_selecting");
	
	//메뉴 분류를 새로 선택하기 전 담아뒀던 List 재입력
	if(menu_selecting != null) {
		menuArray = menu_selecting.split(",");
	}
	
	int pageSize = 10;
	String pageNum = null;
	if (pageNum == null) {
	    pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int count = 0;
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	if (menu_sort != null) {
		menuList = menudb.getSortedMenuList(menu_sort);
	}else {
		menu_sort = "밥/죽";
		menuList = menudb.getSortedMenuList(menu_sort);
	}
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
<link rel="stylesheet" type="text/css" href="../../css/content_style.css"></link>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
</head>



<body>
	<jsp:include page="../header.jsp" flush="false" />
    <form method="POST" name="selectMenuForm" action="orderListPro.jsp">
    <div id="menu_type">
	     <select name="menu_big_class" onchange="sortMenu(this)">
	   		<option value="big-null">선택하세요.</option>
	   		<option value="밥/죽">밥/죽</option>
	   		<option value="국/탕/찌개">국/탕/찌개</option>
	   		<option value="반찬">반찬</option>
	   		<option value="후식/기타">후식/기타</option>
	  </select>
	     <% if(member_id != null){%>
	     	<span><%=member_id %>님, 보유 밥풀 : <%=cybermoney.getSum_bobpul() - cybermoney2.getSum_use_bobpul()%> 풀</span>
	     <% } else { %>
	     	<span>안녕하세요, BOBBOX 입니다.</span>
	     <% } %>
    </div>
    
	<div id="contents">
        <div class="menu_list" id="notice"><span id="kr">공지사항</span><br><span id="en">NOTICE</span>
        	<div id="notice-list">
        	<%
        	int k = boarddb.getAdmin_BoardCount();
        	for(int i=k; i>(k-4); i--) {
        		Admin_BoardDataBean board = boarddb.getAdmin_Board(i);
        	%>
        		<div>· <a href="../Board/AdminboardForm.jsp?admin_board_num=<%=board.getAdmin_board_num() %>&pageNum=<%=pageNum%>"><%=board.getAdmin_board_title() %></a></div>
        	<%}%>
        	</div>
        </div>
<%
	for (int i = 0 ; i < 5 ; i++) {
		MenuDataBean menu = menuList.get(i);
%>
        <div class="menu_list" id="menu_list<%=i%>">
        	<img src="../../fileSave/<%=menu.getMenu_image() %>" />
        	<!-- 메뉴정보 -->
        	<div class="menu_info" id="menu_info<%=i%>">
        	<div class="menu_name"><%=menu.getMenu_name()%></div>
        		<div id="menu_nut">
        			<div>
	        			<span>열량: <%=menu.getMenu_kcal() %>kcal</span>
        			</div>
        			<div>
	        			<span>탄수화물: <%=menu.getMenu_carbor() %>g</span>
	        			<span id="menu_floatRight">단백질: <%=menu.getMenu_protein() %>g</span>
	        		
        			</div>
        			<div>
	        			<span>지방: <%=menu.getMenu_fat() %>g</span>
	        			<span id="menu_floatRight">나트륨: <%=menu.getMenu_natrium() %>mg</span>
        			</div>
        		</div>
        		<div id="menu_select<%=i%>" class="menu_select" name="<%=menu.getMenu_name() %>" charge="<%=menu.getMenu_charge() %>" num="<%=menu.getMenu_num() %>"onclick="goBox(this)"><img id="selectimg" src="../../img/check.jpg"/></div>
        	</div>
        </div>
        
<% } %>
        <div class="menu_list" id="order_menu" onclick="howtoorder()"><span id="kr">주문방법</span><span id="en">ORDER</span></div>
<%
	for (int i=5; i<11; i++) {
		MenuDataBean menu = menuList.get(i);
%>
		<div class="menu_list" id="menu_list<%=i%>">
		<img src="../../fileSave/<%=menu.getMenu_image() %>" />
			<div class="menu_info" id="menu_info<%=i%>">
			<div class="menu_name"><%=menu.getMenu_name()%></div>
        		<div id="menu_nut">
        			<div>
	        			<span>열량: <%=menu.getMenu_kcal() %>kcal</span>
        			</div>
        			<div>
	        			<span>탄수화물: <%=menu.getMenu_carbor() %>g</span>
	        			<span id="menu_floatRight">단백질: <%=menu.getMenu_protein() %>g</span>
        			</div>
        			<div>
	        			<span>지방: <%=menu.getMenu_fat() %>g</span>
	        			<span id="menu_floatRight">나트륨: <%=menu.getMenu_natrium() %>mg</span>
        			</div>
        		</div>
        		<div id="menu_select<%=i%>" class="menu_select" name="<%=menu.getMenu_name() %>" charge="<%=menu.getMenu_charge() %>" num="<%=menu.getMenu_num() %>"onclick="goBox(this)"><img id="selectimg" src="../../img/check.jpg"/></div>
        	</div>
		</div>
		
<% } %>
        <div class="menu_list" id="bobbox"><span id="en">BOBBOX</span><br><span id="bobbox_con">저희 밥박스는 어머니의 마음으로<br>항상 정성을 다하여<br>음식을 만들겠습니다</span><br><span id="kr">(주)밥박스</span></div>
<%
	for (int i=11; i<menuList.size(); i++){
		MenuDataBean menu = menuList.get(i);
%>
		<div class="menu_list" id="menu_list<%=i%>">
		<img src="../../fileSave/<%=menu.getMenu_image() %>" />
			<div class="menu_info" id="menu_info<%=i%>">
			<div class="menu_name"><%=menu.getMenu_name()%></div>
        		<div id="menu_nut">
        			<div>
	        			<span>열량: <%=menu.getMenu_kcal() %>kcal</span>
        			</div>
        			<div>
	        			<span>탄수화물: <%=menu.getMenu_carbor() %>g</span>
	        			<span id="menu_floatRight">단백질: <%=menu.getMenu_protein() %>g</span>
        			</div>
        			<div>
	        			<span>지방: <%=menu.getMenu_fat() %>g</span>
	        			<span id="menu_floatRight">나트륨: <%=menu.getMenu_natrium() %>mg</span>
        			</div>
        		</div>
        		<div id="menu_select<%=i%>" class="menu_select" name="<%=menu.getMenu_name() %>" charge="<%=menu.getMenu_charge() %>" num="<%=menu.getMenu_num() %>"onclick="goBox(this)"><img id="selectimg" src="../../img/check.jpg"/></div>
        	</div>
		</div>
<% 
	}
}catch(Exception e){
	e.printStackTrace();
}
%>	
	</div>
	
	</form>
	<jsp:include page="orderListBox.jsp" flush="false" />
	<jsp:include page="../footer.jsp" flush="false" />
	
	<div>
    <%
    if(menuArray.length > 0){
    for(int i=0; i<menuArray.length; i++){
		MenuDataBean selectMenu = menudb.getMenu(Integer.parseInt(menuArray[i]));
		int menu_num = selectMenu.getMenu_num();
		String menuName = selectMenu.getMenu_name();
		String menuCharge = selectMenu.getMenu_charge();
		%>
		<script>
		var menuName = "<%=menuName%>";
		var menuCharge = "<%=menuCharge%>";
		$("#menu-list").append("<input type='hidden' id='pick"+<%=menu_num%>+"' class='pick"+<%=menu_num%>+"' value='"+<%=menu_num%>+"' name='menu_selecting' />");
		$("#menu-list-detail").append("<div class='pick"+<%=menu_num%>+"' id='orderList'><span>" + menuName + "</span><span id='menu_charge'>" + menuCharge + "<span id='bobfull'> 밥풀</span>"+"<span id='menu_out'><input type='button' value='x' onclick='cancel("+<%=menu_num%>+")'></span></span></div>");
		</script>
		<%
	}
    }
    %>
    </div>
</body>
<script type="text/javascript">
//주문 방법 띄우기
function howtoorder(){
	window.open('HowtoOrder.jsp','newwindow','top=10, left=100, width=470, height=680');
}
//메뉴 정보 띄우기
var before = 0;
$( ".menu_list" ).each(function( index, element ) {
	$( "#menu_list"+index ).mouseover(function() {
		$("#menu_info"+before).css("display","none");
		$("#menu_info"+index).css("display","inline");
		before = index;
	});
});

//orderListBox hide/show
$(document).ready(function(){
	$("#footer-menu-list").hide();
	
    $("#menu-list-closed").click(function(){
        $("#footer-menu-list").hide();
        $("#footer-menu-select").show();
    });
    
    $("#footer-menu-select").click(function(){
        $("#footer-menu-list").show();
        $("#footer-menu-select").hide();
    });
});

//메뉴 선택시 실행
function goBox(menu) {
	var menuName = menu.getAttribute('name');
	var menuCharge = menu.getAttribute('charge');
	var menu_num = menu.getAttribute('num');
	var YN = $( "#pick"+menu_num ).hasClass("pick"+menu_num);
	
	//리스트로 보내버리자
	if(YN == true){
		alert("이미 선택한 메뉴 입니다.");
	}else{
		$("#footer-menu-list").show();
		$("#menu-list").append("<input type='hidden' id='pick"+menu_num+"' class='pick"+menu_num+"' value='"+menu_num+"' name='menu_selecting' />");
		$("#menu-list-detail").append("<div class='pick"+menu_num+"' id='orderList'><span>" + menuName + "</span><span id='menu_charge'>" + menuCharge + "<span id='bobfull'> 밥풀</span>"+"<span id='menu_out'><input type='button' value='x' onclick='cancel("+menu_num+")'></span></span></div>");
	}
}

//취소 버튼 클릭시
function cancel(i) {
	$( ".pick"+i ).remove();
}

//분류 변경시
function sortMenu(classification) {
    var obj = classification.options[classification.selectedIndex].value;	//셀렉트에서 선택된 value값
    document.orderListForm.action = "indexPro.jsp?menu_sort="+obj;
    document.orderListForm.submit();
}
</script>

</html>