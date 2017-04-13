<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="team2.book.*" %> 
<% request.setCharacterEncoding("utf-8"); %>
<%
	int count = 0;
	List<BookDataBean> bookList = null; 
	BookDBBean dbPro = BookDBBean.getInstance();
	
	count = dbPro.getBookCount();
	
	if (count > 0) {
		bookList = dbPro.getBookList();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="../../../js/jquery-2.1.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="../../../css/book_style.css"></link>
<link rel="stylesheet" type="text/css" href="../admincss/header_style.css"></link>
<link rel="stylesheet" type="text/css" href="../../../css/admin_footer_style.css"></link>
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
			<div id="rootBar"><a href="../AdminMain.jsp">Home</a>&nbsp;&nbsp;>&nbsp;&nbsp;<span id="now_page">장부관리</span></div>
			<div id="con-tit"><img src="../../../img/book.png" /></div>
			<table>
				<tr>
					<th>번호</th>
					<th>날짜</th>
					<th>수입내역</th>
					<th>지출</th>
					<th>매출</th>
				</tr>
<%
for (int i=0; i<bookList.size(); i++) {
	BookDataBean book = bookList.get(i);
%>
				<tr>
				<td><%=book.getBook_num() %></td>
				<td><input type="text" id="date" value="<%=book.getBook_date() %>" readonly="readonly" onclick="goDetail('<%=book.getBook_date()%>')"/></td>
				<td><span class="txtBlue">+</span><input type="text" value="<%=book.getSum_charge() %>" id="sumCharge<%=i %>" readonly="readonly"/> 원</td>
				<td><span class="txtRed">-</span><input type="text" value="<%=book.getSum_input() %>" id="sumInput<%=i %>" readonly="readonly"/> 원</td>
				<td><input type="text" id="sales<%=i %>" readonly="readonly"/> 원</td>
				</tr>
<%
}
%>
			</table>
		</form>
	</div>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
<script src="../../../js/format.js"></script>
<script>
/**
 * 일별 매출 계산, 콤마 찍기
 */
var sumCharge = new Array();
var sumInput = new Array();
var sales = new Array();

for (i=0; i<<%=bookList.size()%>; i++){
	sumCharge[i] = document.getElementById('sumCharge'+i);
	sumInput[i] = document.getElementById('sumInput'+i);

	sales[i] = document.getElementById('sales'+i);
	sales[i].value = (parseInt(sumCharge[i].value)-parseInt(sumInput[i].value)).format();

	sumCharge[i].value = sumCharge[i].value.format();
	sumInput[i].value = sumInput[i].value.format();
	
}
/**
 * 장부 상세 보기
 */
function goDetail(bookDate){
	var bookForm = document.getElementById('bookForm');
	bookForm.action = "bookDetail.jsp?bookDate="+bookDate;
	bookForm.submit();
}
</script>
</html>