<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team2.cybermoney.*"%>
<%@ page import="team2.member.*" %>
<%@ page import="java.util.List" %>
<% request.setCharacterEncoding("utf-8");%>
<%

	MemberDBBean memberdb = MemberDBBean.getInstance();
	String member_id = "";
	member_id = (String)session.getAttribute("member_id");
	int member_num = memberdb.getMember_num(member_id);
	
	
	int count = 0;
	CybermoneyDBBean cyberPro = CybermoneyDBBean.getInstance();
	count = cyberPro.getCybermoneyCount();
	List<CybermoneyDataBean> cybermoneyList = null;
	CybermoneyDataBean cybermoney = null;
	if (count > 0){
		cybermoneyList = cyberPro.getCybermoneyByMemberNum(member_num);
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<title>주문리스트</title>
<link rel="stylesheet" href="../../css/bobful_used_list_style.css" />
<link rel="stylesheet" href="../../css/mypage_style.css" />
<script src="../../../js/jquery-2.1.0.min.js"></script>
</head>
<body>
	<jsp:include page="header.jsp" flush="false" />
	<div id="rootBar"><a href="Main.jsp">홈</a>&nbsp;&nbsp;>&nbsp;&nbsp;<a href="myOrderList.jsp">마이페이지</a>&nbsp;&nbsp;>&nbsp;&nbsp;<span id="now_page">사용내역</span></div>
	<jsp:include page="myPageTopNav.jsp" flush="false" />
	<jsp:include page="myPageLeftNav.jsp" flush="false" />
	<div id="contents">
		<div id="con-tit"><img src="../../img/used_list_18.png" /></div>
		<div id="today">기준 : <input type="date" id="bytoday" readonly="readonly"/></div>
		<table>
			<tr>
				<th>날짜</th>
				<th>내역</th>
				<th>사용밥풀</th>
				<th>충전밥풀</th>
				<th>비고</th>
			</tr>
<%
for (int i=0; i<cybermoneyList.size(); i++){
	cybermoney = cybermoneyList.get(i);
%>
			<tr>
				<% if (cybermoney.getUse_date().equals("")) {%>
					<td><%=cybermoney.getCharge_date() %></td>
				<%} else { %>
					<td><%=cybermoney.getUse_date() %></td>
				<%}
				 if (cybermoney.getUse_date().equals("")){ %>
					 <td>밥풀 충전</td>
				<%} else { %>
					 <td>도시락 결제</td>
				<% } %>
				<td><input type="text" value="<%=cybermoney.getUse_bobpul() %>" name="useBobpul" id="_bobpul<%=i%>"/></td>
				<td><input type="text" value="<%=cybermoney.getBobpul() %>" name="chargePrice" id="_charge<%=i %>" /></td>
				<td></td>
			</tr>
<%
}
%>
		</table>
		
	</div>
	
	<jsp:include page="footer.jsp" flush="false" />
</body>
<script src="../../js/format.js"></script>
<script>
document.getElementById('bytoday').valueAsDate = new Date();
var bobpul = new Array();
var _bobpul = new Array();
var _charge = new Array();

for(var i=0; i<<%=cybermoneyList.size()%>; i++){
	bobpul[i] = document.getElementById('bobpul'+i);
	bobpul[i].value = bobpul[i].value.format();
	
	_bobpul[i] = document.getElementById('_bobpul'+i);
	_bobpul[i].value = _bobpul[i].value.format();
	
	
	
	_charge[i] = document.getElementById('_charge'+i);
	_charge[i].value = _charge[i].value.format();
}
</script>
</html>