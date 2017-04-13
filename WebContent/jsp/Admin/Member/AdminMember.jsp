<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="team2.member.MemberDBBean" %>
<%@ page import="team2.member.MemberDataBean" %>

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
	
	List<MemberDataBean> memberList = null; 
	MemberDBBean dbPro = MemberDBBean.getInstance();

	count = dbPro.getMemberCount();
	
	if (count > 0) {
		memberList = dbPro.getMemberList(startRow, pageSize);
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
    	<span id="rootBar"><a href="../AdminMain.jsp">홈</a>&nbsp;&nbsp;>&nbsp;&nbsp;<span id="now_page">회원관리</span></span>
       	<span class="floatRight" id="btn-box">
	        <span id="menu-btn" onclick="location.href='updateMemberForm.jsp'">수정</span>
	        <span id="menu-btn" onclick="deleteGo();">삭제</span>
        </span>
    </div>
	<div id="contents">        
        <form name="memberForm" id="memberForm" action="" method="POST">
	        <table>
	            <tr>
	                <th id="chk"><input type="checkbox" onclick="allCk(this.checked);"></th>
	                <th id="num">번호</th>
	                <th id="name">이름</th>
	                <th id="id">아이디</th>
	                <th id="password">비밀번호</th>
	                <th id="address">주소</th>
	                <th id="tel">전화번호</th>
	                <th id="mail">메일</th>
	                <th id="gender">성별</th>
	                <th id="birth">생년월일</th>
	                <th id="grade">등급</th>
	                <th id="btn">-</th>
	            </tr>
<% for (int i = 0 ; i < memberList.size() ; i++) {
	MemberDataBean member = memberList.get(i);
%>
	            <tr>
	                <td><input type="checkbox" value="<%=member.getMember_num()%>" name="member_chk" /></td>
	                <td><%=member.getMember_num() %></td>
	                <td><%=member.getMember_name() %></td>
	                <td><%=member.getMember_id() %></td>
	                <td><%=member.getMember_passwd() %></td>
	                <td><%=member.getMember_address() %></td>
	                <td width='120px'><%=member.getMember_tel() %></td>
	                <td><%=member.getMember_mail() %></td>
	                <td width='50px'><%=member.getMember_gender() %></td>
	                <td><%=member.getMember_birth() %></td>
	                <td><%=member.getMember_grade() %></td>
	                <td><input type="button" id="update-btn" value="수정" onclick="updateGo(<%=member.getMember_num() %>)"></td>
	            </tr>
<%} %>
	        </table>
        </form>
	</div>
	
	<jsp:include page="../footer.jsp" flush="false" />
</body>
<script type="text/javascript">
function allCk(objCheck){ 
	var checks = document.getElementsByName('member_chk');
	for(var i=0; i<checks.length; i++ ){
	 checks[i].checked = objCheck; 
	}
}

function deleteGo(){
	if (confirm('정말로 삭제하시겠습니까?')){
		var memberForm = document.getElementById("memberForm");
		memberForm.action = "deleteMemberPro.jsp";
		memberForm.submit();
	}
	return false;
}

function updateGo(i){
	var memberForm = document.getElementById("memberForm");
	memberForm.action = "updateMemberForm.jsp?memberNumber="+i;
	memberForm.submit();
	
	return false;
}

</script>
</html>