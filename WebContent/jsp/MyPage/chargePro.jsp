<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%@ page import="team2.account_admin.Account_AdminDBBean"%>
<%@ page import="team2.account_admin.Account_AdminDataBean"%>
<%@ page import="team2.book.BookDBBean"%> 
<%@ page import="team2.cybermoney.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.*" %>
<jsp:useBean id="cybermoney" scope="page"
	class="team2.cybermoney.CybermoneyDataBean">
	<jsp:setProperty name="cybermoney" property="*" />
</jsp:useBean>
<jsp:useBean id="book" scope="page"
	class="team2.book.BookDataBean">
	<jsp:setProperty name="book" property="*" />
</jsp:useBean>

<%

	java.util.Date date = new java.util.Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
	String strDate = simpleDate.format(date);
	
    String howto = request.getParameter("howto");
	String whopay = request.getParameter("whopay");
	String price = request.getParameter("price");
	String bank = request.getParameter("bank");
	String bobpul=request.getParameter("bobpul");
	String member_num= request.getParameter("member_num");
	

	Account_AdminDBBean dbpro = Account_AdminDBBean.getInstance();
	String account = dbpro.getAccount_num(bank);
	
	cybermoney.setCharge_price(Integer.parseInt(price));
	cybermoney.setCharge_date(strDate);
	CybermoneyDBBean cyberdb = CybermoneyDBBean.getInstance();
    cyberdb.insertCybermoney2(cybermoney);
    
    BookDBBean bookdb = BookDBBean.getInstance();
    int chargeNum = cyberdb.getCybermoneyCount();
    book.setBook_date(strDate);
    book.setCharge_num(chargeNum); 
    book.setMenu_input_num(1);
    bookdb.insertBook(book);
    
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
	<div id="tit">충전이 완료되었습니다.</div>
	<form action="chargePro.jsp" method="POST">
		<div id="contents">
			<div id=sub-tit>결제 정보 확인</div>
			<table>
				<tr>
					<th>결제 수단</th>
					<td><%=howto %></td>
				</tr>
				<tr>
					<th>은행</th>
					<td><%=bank %></td>
				</tr>
				<tr>
					<th>입금주</th>
					<td><%=whopay%></td>
				</tr>
				<tr>
					<th>결제 금액</th>
					<td><%=price %> 원</td>
					
				</tr>
			</table>
			
			<div id="sub-tit">입금 정보</div>
			<table>
				
				<tr>
					<th>은행</th>
					<td><%=bank %></td>
				</tr>
				<tr>
					<th>계좌번호</th>
					<td><span id="accountNum"><%=account %></span></td>
				</tr>
	
				<tr>
					<th>예금주</th>
					<td>(주)밥박스</td>
				</tr>
			</table>
			<div id="btnOK">
				<input type="button" value="확인" onclick="javascript:popClose()"/>
			</div>
		</div>
	</form>
</body>
<script>
function popClose(){
	window.close();
}
</script>
</html>


