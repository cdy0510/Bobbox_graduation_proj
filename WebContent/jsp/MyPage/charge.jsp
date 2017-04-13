<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%@ page import="team2.member.MemberDBBean"%>
<%@ page import="team2.member.MemberDataBean"%>
<%@ page import="team2.cybermoney.CybermoneyDBBean"%>
<%@ page import="team2.cybermoney.CybermoneyDataBean"%>
<%@ page import="team2.account_admin.Account_AdminDBBean"%> 
<%@ page import="team2.account_admin.Account_AdminDataBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	
	int count = 0;
	List<Account_AdminDataBean> account_adminList = null; 
	Account_AdminDBBean dbPro = Account_AdminDBBean.getInstance();
	
	count = dbPro.getAccount_AdminCount();

	if (count > 0) {
		account_adminList = dbPro.getAccount_Admins();
	}
	

	MemberDBBean dbpro = MemberDBBean.getInstance();
		
	String member_id = "";	
	try{
		member_id = (String)session.getAttribute("member_id");
		String member_name = dbpro.getMember_name(member_id);
		int member_num = dbpro.getMember_num(member_id);
		
		
%>

<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>BOBBOX :: 충전</title>
<link rel="stylesheet" href="../../css/charge_style.css" />
<script src="../../js/jquery-2.1.0.min.js"></script>
</head>
<body>
<% 


%>
	<div id="tit">밥풀 충전하기</div>
	<form action="chargePro.jsp" method="POST" name="chargeForm">
		<div id="contents">
			<div id="sub-tit">결제 수단 선택</div>
			<div id="radioBox">
				<input type="radio" value="무통장입금" name="howto" checked="checked">무통장입금
				<span id="alignCenter"><input type="radio" value="신용카드"
					name="howto">신용카드</span> <input type="radio" value="휴대폰"
					name="howto">휴대폰
			</div>
			<div id="sub-tit">결제 금액 선택</div>
			<div id="radioBox">
				<div class="howprice">
					<input type="radio" name="howmuch" onclick="showPrice()" id="howmuch0"
						value="10000"> 10,000원 <span class="txtBold">(1,000
						풀)<input type="radio" value="1000" name="bobpul" id="bobpul0" style="display:none;"/></span>
				</div>
				<div class="howprice">
					<input type="radio" name="howmuch" onclick="showPrice()" id="howmuch1"
						value="50000"> 50,000원 <span class="txtBold">(5,250
						풀)<input type="radio" value="5250" name="bobpul" id="bobpul1" style="display:none;"/></span>
				</div>
				<div class="howprice">
					<input type="radio" name="howmuch" onclick="showPrice()" id="howmuch2"
						value="100000"> 100,000원 <span class="txtBold">(10,500
						풀)<input type="radio" value="10500" name="bobpul" id="bobpul2" style="display:none;"/></span>
				</div>
				<div class="howprice">
					<input type="radio" name="howmuch" onclick="showPrice()" id="howmuch3"
						value="200000"> 200,000원 <span class="txtBold">(21,000
						풀)<input type="radio" value="21000" name="bobpul" id="bobpul3" style="display:none;"/></span>
				</div>
			</div>
			<div id="sub-tit">결제 정보</div>
			<table>
				<tr>
					<% if(member_name != null){%>
					<th>입금주</th>
					<td><input type="text" name="whopay" value="<%=member_name%>" />
					<input type="hidden" value="<%=member_num%>" name="member_num" />
					</td>
					<% } else { %>
					<th>입금주</th>
					<td><input type="text" name="whopay" value="손님"></td>
					<% } %>
				</tr>
				<tr>
					<th>결제금액</th>
					<td><input type="text" id="price" name="price"><span
						id="won"></span></td>
				</tr>

				<tr>
					<th>은행</th>
					<td><select name="bank">
							<%
					for (int i = 0; i <count; i++) {
									Account_AdminDataBean account_admin = account_adminList.get(i);
				%>
							<option><%=account_admin.getBank_name()%></option>
							<%
					}
				%>
					</select></td>
					
				</tr>

			</table>
			<hr>
			<div id="btn">
				<input type="submit" value="확인" /> <input type="button" value="취소"
					onclick="javascript:popClose()" />
			</div>
		</div>
	</form>
</body>
<script type="text/javascript">
	function popClose() {
		window.close();
	}
	function showPrice() {
		var price = $("input[name='howmuch']:checked").val();
		document.getElementById("price").value = price;
		document.getElementById("won").innerHTML = " 원";

		for (i=0; i<4; i++){
			var much = new Array();
			much[i] = document.getElementById("howmuch"+i);
			var pul = new Array();
			pul[i] = document.getElementById("bobpul"+i);
			
			if (much[i].checked == true) {
				pul[i].checked = true;
			}
		}
	}
</script>
</html>
<%
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
