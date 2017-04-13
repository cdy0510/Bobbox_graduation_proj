<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%@ page import="team2.supplier.SupplierDBBean" %>
<%@ page import="team2.supplier.SupplierDataBean" %>
<%@ page import="java.util.List" %>
<%
	int i = Integer.parseInt(request.getParameter("supplierNumber"));
	try {
		SupplierDBBean dbPro = SupplierDBBean.getInstance();
		SupplierDataBean supplier =  dbPro.findSupplierInfo(i);
%>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<title>회원정보 수정</title>
<link rel="stylesheet" href="../../../css/insert_menu_style.css" />
<script src="../../../js/jquery-2.1.0.min.js"></script>
<script src="../../../js/supplier.js"></script>
</head>
<body>
<div class="box">
<form name="updateSupplierForm" method="post" action="updateSupplierPro.jsp" >
    <a href="../AdminMain.jsp"><img id="logo" src="../../../img/BOBBOX_LOGO_Text.png" /></a><br><br>
   	<input type="hidden" name="supplier_num" value="<%=supplier.getSupplier_num() %>">
    <div id="must_write">
		<div class="line">
			<div class="label">업체명</div><input type="text" name="supplier_name" value="<%=supplier.getSupplier_name() %>">
		</div>
		<div class="line">
			<div class="label">대표자명</div><input type="text" name="supplier_man_name" value="<%=supplier.getSupplier_man_name() %>">
		</div>
   		<div class="line">
           	<div class="label">주소</div><input type="text" name="supplier_address" value="<%=supplier.getSupplier_address() %>">
        </div>
   		<div class="line">
   			<div class="label">이메일</div><input type="text" name="supplier_mail" value="<%=supplier.getSupplier_mail() %>">
   		</div>
        <div class="line">
           	<div class="label">연락처</div><input type="text" name="supplier_tel" placeholder="'-'를 제외한 숫자만 작성  ex)01033335555" onblur="fnCheckTel_up()" value="<%=supplier.getSupplier_tel() %>"><br>
        </div>
           <div id="account_data">
           	<div class="label">계좌번호</div>
           	<select id="supplier_bank" name="supplier_bank">
           		<option value="국민">국민</option>
           		<option value="신한">신한</option>
           		<option value="우리">우리</option>
           		<option value="하나">하나</option>
           		<option value="농협">농협</option>
           		<option value="씨티">씨티</option>
           		<option value="외환">외환</option>
           		<option value="기업">기업</option>
           		<option value="수협">수협</option>
           		<option value="우체국">우체국</option>
           		<option value="신협">신협</option>
           		<option value="새마을">새마을</option>
           	</select>
       		<input type="text" id="supplier_account_data" name="supplier_account_data" placeholder="계좌번호" value="<%=supplier.getSupplier_account_data() %>" >
           </div>
        
	</div>
    <input type="submit" value="업체 정보 수정" />
    <script type="text/javascript">
	var ch1 = document.updateSupplierForm.supplier_bank;
	for (var i=0; i<ch1.length; i++){
		if(ch1[i].value == '<%=supplier.getSupplier_bank()%>'){
			ch1[i].selected = true;
		}
	}
	</script>
	</form>
 
 <%
	 }catch(Exception e){}%>

</div>

</body>
</html>