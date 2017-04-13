<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
  <title>회원가입</title>
  <link rel="stylesheet" href="../../css/join_style.css" />
  <script src="../../js/jquery-2.1.0.min.js"></script>
  <script src="../../js/join.js"></script>
</head>
<body>
<div class="box">
<form name="joinForm" method="post" action="insertMemberPro.jsp">
    <a href="../index.jsp"><img id="logo" src="../../img/BOBBOX_LOGO_Text.png" /></a><br><br>
   	<div id="must_write">
   		<div class="line">
               <div class="label">아이디</div><input type="text" id="uid" name="member_id" onkeyup="ajaxSend()"><br>
               <span id="id_msg"></span>
           </div>
   		<div class="line">
               <div class="label">비밀번호</div><input type="password" id="pw" name="member_passwd" placeholder="영문, 숫자를 조합한 6자 이상으로 작성해주세요." onkeyup="fnCheckPassword()">
           </div>
   		<div>
   			<div class="label">재확인</div><input type="password" id="pw_check" name="member_passwd_check" onblur="checkvalue()"><br>
   			<span id="pw_msg"></span>
   		</div>
   	</div><br>
       
       <div id="sub_write">
   		<div class="line">
   			<div class="label">이름</div><input type="text" name="member_name">
   		</div>
   		<div class="line" id="gender">
   			<div class="label">성별</div>
   			<span id="genderM"><img id="man" src="../../img/man.png"/></span>
   			<span id="genderW"><img id="woman" src="../../img/woman.png"/></span>
   			<input type="hidden" id="gender_value" name="member_gender">
   		</div>
   		<div class="line">
   			<div class="label">이메일</div><input type="text" name="member_mail">
   		</div>
           <div class="line">
           	<div class="label">주소</div><input type="text" name="member_address">
           </div>
           <div class="line">
           	<div class="label">연락처</div><input type="text" name="member_tel" placeholder="'-'를 제외한 숫자만 작성  ex)01033335555" onblur="fnCheckTel()"><br>
           </div>
           <div id="birth">
           	<div class="label">생년월일</div>
           	<input type="text" id="year" name="member_year" size="4" maxlength="4" placeholder="생년">
           	<select id="month" name="member_month" onchange="monthCss()">
           		<option value="00">월</option>
           		<option value="01">01</option>
           		<option value="02">02</option>
           		<option value="03">03</option>
           		<option value="04">04</option>
           		<option value="05">05</option>
           		<option value="06">06</option>
           		<option value="07">07</option>
           		<option value="08">08</option>
           		<option value="09">09</option>
           		<option value="10">10</option>
           		<option value="11">11</option>
           		<option value="12">12</option>
           	</select>
       		<input type="text" id="day" name="member_day" size="2" maxlength="2" placeholder="일" onblur="birthJoin()">
       		<input type="hidden" id="birth_value" name="member_birth">
           </div>
   	</div>
    <input type="button" value="회원가입" onclick="lastCheck()"/>
 </form>
</div>
</body>
    
    
</html>