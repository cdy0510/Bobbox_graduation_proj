<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../css/sub_style.css" />
<script>
function popid(){window.open('../../html/id_find.html','newwindow','top=10, left=10, width=400, height=350');}
function poppw(){window.open('../../html/pw_find.html','newwindow','top=10, left=10, width=400, height=400');}
</script>
</head>
<body>
<div class="box">
	<a href="../home/index.jsp"><img src="../../img/BOBBOX_LOGO_Text.png" /></a><br><br>
	<form method="post" action="LoginPro.jsp">
		<input type="text" placeholder="id" name="member_id"><br>
		<input type="password" placeholder="password" name="member_passwd"><br>
		<div class="btn_area">
			<input type="submit" value="로그인">
			<input type="button" value="회원가입" onclick="location.href='../../html/TOSForm.html'">
		</div>
		<a href="javascript:popid()">아이디 찾기</a>&nbsp&nbsp<a href="javascript:poppw()">비밀번호 찾기</a>
	</form>
</div>
</body>
</html>