<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="team2.book.*" %> 
<%@ page import="java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
	String bookDate = request.getParameter("bookDate");
	int count = 0;
	List<BookDataBean> bookList = null; 
	BookDBBean dbPro = BookDBBean.getInstance();
	count = dbPro.getBookCount();
	
	if (count > 0) {
		bookList = dbPro.getBook(bookDate);
	}
%>
<jsp:useBean id="book" class="team2.book.BookDataBean">
     <jsp:setProperty name="book" property="*"/>
 </jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="../../../js/jquery-2.1.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="../../../css/book_style.css"></link>
<link rel="stylesheet" type="text/css" href="../admincss/header_style.css"></link>
<link rel="stylesheet" type="text/css" href="../admincss/footer_style.css"></link>
<title>BOBBOX :: 장부관리</title>
</head>


<body>
	<div id="header" class="width800">
		<div id="logo">
            <img height="80px" src="../../../img/BOBBOX_LOGO_Text.png" />
		</div>
        <div id="admin-hello">
            관리자님, 안녕하세요.
            <a href="Logout.jsp">로그아웃</a>
        </div>
	</div>
	<div id="contents">
		<form name="bookForm" method="POST" action="" id="bookForm">
			<div id="rootBar"><a href="../AdminMain.jsp">Home</a>&nbsp;&nbsp;>&nbsp;&nbsp;<a href="AdminBook.jsp">장부관리</a>&nbsp;&nbsp;>&nbsp;&nbsp;<span id="now_page">장부 상세보기</span></div>
			<div id="con-tit" class="disInline"><img src="../../../img/book.png" /></div>
			<div id="standDate" class="disInline">날짜 : <%=bookDate %></div>
			<table>
				<tr>
					<th>번호</th>
					<th>회원 ID</th>
					<th>공급업체</th>
					<th>수입</th>
					<th>지출</th>
				</tr>
<%
for (int i = 0 ; i < bookList.size() ; i++) {
	book = bookList.get(i);
%>
				<tr>
				<td><%=book.getBook_num() %></td>
				<td><input type="text" value="<%=book.getMember_id() %>" id="memId<%=i%>" name="member" readonly="readonly"/></td>
				<td><input type="text" value="<%=book.getSupplier_name() %>" id="suppName<%=i %>" name="supplier" readonly="readonly"/></td>
				<td><input type="text" value="<%=book.getCharge_price() %>" id="chargePrice<%=i %>" readonly="readonly"/> 원</td>
				<td><input type="text" value="<%=book.getInput_price() %>" id="inputPrice<%=i %>" readonly="readonly"/> 원</td>
				</tr>
<%
}
%>
			</table>
			
			<table id="bottomTable">
				<tr>
					<th>총 수입</th>
					<td><input type="text" value="" id="totalIncome" readonly="readonly"/> 원</td>
					<th>총 지출</th>
					<td><input type="text" value="" id="totalExpense" readonly="readonly" /> 원</td>
					<th>매출</th>
					<td><input type="text" value="" id="totalSale" readonly="readonly" /> 원</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
<script src="../../../js/format.js"></script>
<script>
/**
 * '-' 채우기
 */
var mem = new Array();
var supp = new Array();
for (i=0; i<<%=bookList.size()%>; i++){
	mem[i] = document.getElementById('memId'+i);
	supp[i] = document.getElementById('suppName'+i);
	if(mem[i].value == 'admin'){
		mem[i].value = '-';
	} else {
		supp[i].value = '-';
	}
}

/**
 * 총수입 찍기
 */
var charge = new Array();
var totalCharge = 0;
for (i=0; i<<%=bookList.size()%>; i++){
	charge[i] = document.getElementById('chargePrice'+i);
	if (charge[i] != 0){
		totalCharge += parseInt(charge[i].value);
		charge[i].value = charge[i].value.format();
	}
	
}
document.getElementById('totalIncome').value = totalCharge.format();

/**
 * 총지출 찍기
 */
var input = new Array();
var totalInput = 0;
for (i=0; i<<%=bookList.size()%>; i++){
	input[i] = document.getElementById('inputPrice'+i);
	if(input[i] != 0){
		totalInput += parseInt(input[i].value);
		input[i].value = input[i].value.format();
	}
	
}
document.getElementById('totalExpense').value = totalInput.format();

/**
 * 매출 찍기
 */
document.getElementById('totalSale').value = (totalCharge-totalInput).format();

</script>
</html>