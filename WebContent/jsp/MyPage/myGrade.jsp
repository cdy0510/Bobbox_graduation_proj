<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%@ page import="team2.member.MemberDBBean"%>
<%@ page import="team2.member.MemberDataBean"%>
<%@ page import="team2.cybermoney.CybermoneyDBBean"%>
<%@ page import="team2.cybermoney.CybermoneyDataBean"%>
<% 
	
	CybermoneyDBBean cyberdb = CybermoneyDBBean.getInstance();
	MemberDBBean memberdb = MemberDBBean.getInstance();
	String member_id = "";	
	
	try{
		member_id = (String)session.getAttribute("member_id");
		String member_name = memberdb.getMember_name(member_id);
		String member_grade = memberdb.getMember_grade(member_id);
		int member_order_count = memberdb.getMember_order_count(member_id);
		int member_num = memberdb.getMember_num(member_id);
		CybermoneyDataBean cybermoney2 = cyberdb.getUse_bobpul(member_num);
		CybermoneyDataBean chargePrice = cyberdb.getCharge_price(member_num);
		%>		
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<title>BOBBOX :: 회원등급</title>
<link rel="stylesheet" href="../../css/my_grade_style.css" />
<link rel="stylesheet" href="../../css/mypage_style.css" />
<script src="../../../js/jquery-2.1.0.min.js"></script>
</head>
<body>
	<jsp:include page="header.jsp" flush="false" />
	<div id="rootBar"><a href="Main.jsp">홈</a>&nbsp;&nbsp;>&nbsp;&nbsp;<a href="myOrderList.jsp">마이페이지</a>&nbsp;&nbsp;>&nbsp;&nbsp;<span id="now_page">회원등급</span></div>
	<jsp:include page="myPageTopNav.jsp" flush="false" />
	<jsp:include page="myPageLeftNav.jsp" flush="false" />
	<div id="contents">
	
		<div id="con-tit"><img src="../../img/grade.png" /></div>
		<div id="grade">
			<div id="now-grade">
				<div id="grade-tit"><%=member_name %> 님의 회원 등급입니다.</div>		
		<% if(member_grade != null){
			if(member_grade.equals("Green")){%>
				<img src="../../img/greenbig.png" id="bigicon"/>
				<% } else { %>
				<img src="../../img/goldbig.png" id="bigicon"/>
				<% } %>
			<% } %>
				<div id="buy-info">
					<div id="buy-count"><span id="info-tit">구매건수 : </span><span class="floatRight"><span id="db-info"><%=member_order_count%></span><span id="info-tit"> 건</span></span></div>
					<div id="buy-price"><span id="info-tit">구매금액 : </span><span class="floatRight"><span id="db-info"><input type="text" id="orderPrice" value="<%=cybermoney2.getSum_use_bobpul()%>" readonly="readonly"/></span><span id="info-tit"> 풀</span></span></div>
				</div>
				<div id="today">( 산정기준: 2014년 10월 18일 )</div>
			</div>
			<div id="green">
			
			<div id="gold-grade">	
				<div id="grade-tit"><%=member_name %> 님의 목표 회원 등급은 <br> <span id="gold-txt">GOLD</span> 입니다.</div>
				<div id="need-tit">GOLD 로 상승하시려면?</div>
				<img src="../../img/arrowgrade.gif" id="arrow"/>
				<table>
					<tr>
						<td rowspan="2" id="gold-icon"><img src="../../img/goldicon.png" /></td>
						<td id="need-txt">필요 구매건수</td>
						<td id="db-need"><input type="text" id="needCount" readonly="readonly"/> 건</td>
					</tr>
					<tr>
						<td id="need-txt">필요 구매금액</td>
						<td id="db-need"><input type="text" id="needPrice" readonly="readonly"/> 원</td>
					</tr>
				</table>
			</div>
		  </div>
			<!-- if 등급=GOLD-->
		<div id="gold">	
			<div id="gold-grade">
				<div id="grade-tit"><%=member_name %> 님은 최고등급인 <br> <span id="gold-txt">GOLD</span> 입니다.</div>
				<div id="gold-sub-tit">GOLD 등급은 계속 유지되며,
									<br> GOLD 회원만의 혜택을 누려보세요.</div>
			</div>
		</div>	 
			 
			<div id="standard">
				<div id="grade-tit"><img src="../../img/standtitle.png" /></div>
				<img src="../../img/standard.png" id="stand-table"/>
			</div>
		</div>
		
		<div id="con-tit"><img src="../../img/benefit.png" /></div>
		<div id="benefit">
			<div id="benefit-table">
				<table>
					<tr>
						<th>구분</th>
						<th>할인율</th>
						<th>할인횟수</th>
						<th>비고</th>
					</tr>
					<tr>
						<td>생일축하쿠폰</td>
						<td>20%</td>
						<td>연 1회</td>
						<td id="benefit-etc">생일 14일 전후 기간내에 사용가능.</td>
					</tr>
					<tr>
						<td>매일매일 할인쿠폰</td>
						<td>5%</td>
						<td>일 1회</td>
						<td id="benefit-etc">중복사용 불가.</td>
					</tr>
					<tr>
						<td>배송비 무료쿠폰</td>
						<td>무료배송</td>
						<td>일 1회</td>
						<td id="benefit-etc">중복사용 가능.</td>
					</tr>
				</table>
			</div>
		</div>
		
	</div>
	<jsp:include page="footer.jsp" flush="false" />
</body>
<script src="../../js/format.js"></script>
<script type="text/javascript">
	
	var grade = "<%=member_grade%>";
	 if(grade == "Green"){
		 document.getElementById('green').style.display = "inline";
	 }else{
		 document.getElementById('gold').style.display = "inline";
	 }
	 
	 /* 필요구매건수, 필요 구매금액*/
	 var needPrice = document.getElementById('needPrice');
	 var sumCharge = <%=chargePrice.getSum_charge_price()%>;
	 needPrice.value = 1000000 - parseInt(sumCharge);
	 needPrice.value = needPrice.value.format();
	 
	 var needCount = document.getElementById('needCount');
	 var orderCount = <%=member_order_count%>;
	 needCount.value = 10 - orderCount;
	 
	 var orderPrice = document.getElementById('orderPrice');
	 orderPrice.value = orderPrice.value.format();
</script>
</html>
<%  
    }catch(Exception e){
		e.printStackTrace();
	}
%>		