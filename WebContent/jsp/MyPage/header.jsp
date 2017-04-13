<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="team2.member.MemberDBBean"%>
<%@ page import="team2.member.MemberDataBean"%>

<%
	MemberDBBean dbpro = MemberDBBean.getInstance();

	String member_id = "";
   try{
	   member_id = (String)session.getAttribute("member_id");
%>
<link rel="stylesheet" type="text/css" href="../../css/mypage_header_style.css"></link>
<div id="header">
	<ul>
		<% if(member_id == null){ %>
		<li><a href="../Login/LoginForm.jsp">로그인</a></li>
		<% } else { %>
		<li><a href="../Login/Logout.jsp">로그아웃</a></li>
		<% } %>
		<li>BOBBOX</li>
		<li><a href="../Board/reviewBoardList.jsp">게시판</a></li>
		<li><a href="myOrderList.jsp">마이페이지</a></li>
		<li><a href="../Board/QandABoardList.jsp">고객센터</a></li>
	</ul>
	<div>
		<a href="../home/index.jsp"><img height="80px" src="../../img/BOBBOX_LOGO_Text.png" /></a>
	</div>
</div>
<% 
	   
    }catch(Exception e){
		e.printStackTrace();
	}
%>