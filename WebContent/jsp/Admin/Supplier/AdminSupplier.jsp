<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="team2.supplier.SupplierDBBean" %>
<%@ page import="team2.supplier.SupplierDataBean" %>

<% 
	int pageSize = 10;

	String pageNum = null;
	
	if (pageNum == null) {
	    pageNum = "1";
	} 

	int currentPage = Integer.parseInt(pageNum);
	int count = 0;
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	List<SupplierDataBean> supplierList = null; 
	SupplierDBBean dbPro = SupplierDBBean.getInstance();

	count = dbPro.getSupplierCount();
	
	if (count > 0) {
		supplierList = dbPro.getSupplierList(startRow, pageSize);
    }
	 
	
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>관리자</title>
<link rel="stylesheet" type="text/css" href="../admincss/header_style.css"></link>
<link rel="stylesheet" type="text/css" href="../../../css/menu_style.css"></link>
<link rel="stylesheet" type="text/css" href="../../../css/footer_style.css"></link>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
</head>
<body>
	<div id="header">
		<div id="logo">
            <img height="80px" src="../../../img/BOBBOX_LOGO_Text.png" />
		</div>
        <div id="admin-hello">
            관리자님, 안녕하세요.
            <a href="Logout.jsp">로그아웃</a>
        </div>
	</div>
    <div id="content-header">
        <span id="rootBar"><a href="../AdminMain.jsp">Home</a>&nbsp;&nbsp;>&nbsp;&nbsp;<span id="now_page">공급업체 관리</span></span>
       	<span class="floatRight" id="btnBox">
	        <span id="menu-btn" onclick="location.href='insertSupplierForm.jsp'">등록</span>
	        <span id="menu-btn" onclick="deleteGo();">삭제</span>
        </span>
    </div>
	<div id="contents">        
        <form name="supplierForm" id="supplierForm" action="" method="POST">
	        <table>
	            <tr>
	                <th id="chk"><input type="checkbox" onclick="allCk(this.checked);"></th>
	                <th id="num">번호</th>
	                <th id="suppliername">업체명</th>
	                <th id="address">주소</th>
	                <th id="tel">전화번호</th>
	                <th id="mail">메일</th>
	                <th id="bank">은행명</th>
	                <th id="acount">계좌번호</th>
	                <th id="btn">-</th>
	            </tr>
<% for (int i = 0 ; i < supplierList.size() ; i++) {
	SupplierDataBean supplier = supplierList.get(i);
%>
	            <tr>
	                <td><input type="checkbox" value="<%=supplier.getSupplier_num()%>" name="supplier_chk" /></td>
	                <td><%=supplier.getSupplier_num() %></td>
	                <td><%=supplier.getSupplier_name() %></td>
	                <td><%=supplier.getSupplier_address() %></td>
	                <td><%=supplier.getSupplier_tel() %></td>
	                <td><%=supplier.getSupplier_mail() %></td>
	                <td><%=supplier.getSupplier_bank() %></td>
	                <td><%=supplier.getSupplier_account_data() %></td>
	                <td><input type="button" id="update-btn" value="수정" onclick="updateGo(<%=supplier.getSupplier_num() %>)"></td>
	            </tr>
<%} %>
	        </table>
        </form>
	</div>
	
	<jsp:include page="../footer.jsp" flush="false" />
</body>
<script type="text/javascript">
function allCk(objCheck){ 
	var checks = document.getElementsByName('supplier_chk');
	for(var i=0; i<checks.length; i++ ){
	 checks[i].checked = objCheck; 
	}
}

function deleteGo(){
	if (confirm('정말로 삭제하시겠습니까?')){
		var supplierForm = document.getElementById("supplierForm");
		supplierForm.action = "deleteSupplierPro.jsp";
		supplierForm.submit();
	}
	return false;
}

function updateGo(i){
	var supplierForm = document.getElementById("supplierForm");
	supplierForm.action = "updateSupplierForm.jsp?supplierNumber="+i;
	supplierForm.submit();
	
	return false;
}
</script>
</html>