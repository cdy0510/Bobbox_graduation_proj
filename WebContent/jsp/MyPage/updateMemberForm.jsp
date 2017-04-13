<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%@ page import="team2.member.MemberDBBean" %>
<%@ page import="team2.member.MemberDataBean" %>
<%@ page import="java.util.List" %>
<%

	String member_id = "";
	member_id = (String)session.getAttribute("member_id");
	
	MemberDataBean member= null;
	
	MemberDBBean dbpro = MemberDBBean.getInstance();
    member = dbpro.getMember(member_id); 
	
	try {
		member_id = (String)session.getAttribute("member_id");
%>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<title>회원정보 수정</title>
<link rel="stylesheet" href="../../css/mypage_style.css" />
<link rel="stylesheet" href="../../css/update_member_style.css" />
<script src="../../js/jquery-2.1.0.min.js"></script>
<script src="../../js/join.js"></script>
</head>
<body>
<jsp:include page="header.jsp" flush="false" />
<div class="box">
<form name="updateMemberForm" method="post" action="updateMemberPro.jsp" >
	<div id="rootBar"><a href="Main.jsp">홈</a>&nbsp;&nbsp;>&nbsp;&nbsp;<a href="myOrderList.jsp">마이페이지</a>&nbsp;&nbsp;>&nbsp;&nbsp;<span id="now_page">회원정보수정</span></div>
	
   	<div id="must_write">
   		<input type="hidden" name="member_num" value="<%=member.getMember_num() %>">
   		<div class="line">
        	<div class="label">아이디</div><input type="text" readonly="readonly" name="member_id" value="<%=member.getMember_id() %>">   
        </div>
   		<div>
   			<div class="label">비밀번호</div><input type="password" name="member_passwd" value="<%=member.getMember_passwd() %>">
   		</div>
   	</div><br>
       
    <div id="sub_write">
		<div class="line">
			<div class="label">회원명</div><input type="text" readonly="readonly" name="member_name" value="<%=member.getMember_name() %>">
		</div>
		<div class="line">
   			<div class="label">성별</div>
   			<select id="gender" name="member_gender" onFocus="this.initialSelect = this.selectedIndex;"
onChange="this.selectedIndex = this.initialSelect;">
   				<option value="남자">남자</option>
   				<option value="여자">여자</option>
   			</select>
   		</div>
   		<div class="line">
   			<div class="label">이메일</div><input type="text" name="member_mail" value="<%=member.getMember_mail() %>">
   		</div>
        <div class="line">
        	<div class="label">주소</div><input type="text" name="member_address" value="<%=member.getMember_address() %>">
        </div>
        <div class="line">
        	<div class="label">연락처</div><input type="text" name="member_tel" value="<%=member.getMember_tel() %>"><br>
        </div>
        <div class="line">
        	<div class="label">생년월일</div><input type="text" name="member_birth" value="<%=member.getMember_birth() %>">
        </div>
        <div class="line">
        	<div class="label">등급</div>
        	<select id="grade" name="member_grade" onFocus="this.initialSelect = this.selectedIndex;"
onChange="this.selectedIndex = this.initialSelect">
   				<option value="Green">Green</option>
   				<option value="Gold">Gold</option>
   			</select>
        </div>
	</div>
	
    <input type="submit" value="회원정보 수정" />
    <script type="text/javascript">
	var ch1 = document.updateMemberForm.member_gender;
	for (var i=0; i<ch1.length; i++){
		if(ch1[i].value == '<%=member.getMember_gender()%>'){
			ch1[i].selected = true;
		}
	}
	
	var ch2 = document.updateMemberForm.member_grade;
	for (var i=0; i<ch2.length; i++){
		if(ch2[i].value == '<%=member.getMember_grade()%>'){
			ch2[i].selected = true;
		}
	}
	</script>
 </form>
 <%
	 }catch(Exception e){
		 e.printStackTrace();
	 }%>

</div>
<jsp:include page="footer.jsp" flush="false" />
</body>
</html>