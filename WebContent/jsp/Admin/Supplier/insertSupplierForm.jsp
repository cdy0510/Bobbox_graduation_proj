<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
  <title>공급업체 등록</title>
  <link rel="stylesheet" href="../../../css/insert_menu_style.css" />
  <script src="../../../js/jquery-2.1.0.min.js"></script>
  <script src="../../../js/supplier.js"></script>
</head>
<body>
<div class="box">
<form name="supplierForm" method="post" action="insertSupplierPro.jsp">
    <a href="../AdminMain.jsp"><img id="logo" src="../../../img/BOBBOX_LOGO_Text.png" /></a><br><br>
       <div id="must_write">
   		<div class="line">
   			<div class="label">업체명</div><input type="text" name="supplier_name">
   		</div>
   		<div class="line">
   			<div class="label">대표자명</div><input type="text" name="supplier_man_name">
   		</div>
   		<div class="line">
           	<div class="label">주소</div><input type="text" name="supplier_address">
        </div>
   		<div class="line">
   			<div class="label">이메일</div><input type="text" name="supplier_mail">
   		</div>
        <div class="line">
           	<div class="label">연락처</div><input type="text" name="supplier_tel" placeholder="'-'를 제외한 숫자만 작성  ex)01033335555" onblur="fnCheckTel()"><br>
        </div>
           <div id="birth">
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
       		<input type="text" id="supplier_account_data" name="supplier_account_data" placeholder="계좌번호">
           </div>
   	</div>
    <input type="button" value="업체 등록" onclick="lastCheck()"/>
 </form>
</div>
</body>
    
    
</html>