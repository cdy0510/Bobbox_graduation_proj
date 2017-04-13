<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%@ page import="team2.member.MemberDBBean"%>
<%@ page import="team2.member.MemberDataBean"%>
<%@ page import="team2.cybermoney.CybermoneyDBBean"%>
<%@ page import="team2.cybermoney.CybermoneyDataBean"%>
<%
	
	CybermoneyDBBean cyberdb = CybermoneyDBBean.getInstance();
	MemberDBBean memberdb = MemberDBBean.getInstance();
	String member_id = "";	
	
	try{
		
		member_id = (String)session.getAttribute("member_id");
		String member_name = memberdb.getMember_name(member_id);
		String member_grade = memberdb.getMember_grade(member_id);
		int member_num = memberdb.getMember_num(member_id);
		int member_order_count = memberdb.getMember_order_count(member_id);
		CybermoneyDataBean cybermoney = cyberdb.getBobpul(member_num);
		CybermoneyDataBean cybermoney2 = cyberdb.getUse_bobpul(member_num);

%>
<link rel="stylesheet" href="../../css/mypage_top_nav_style.css" />
<div id="topBar">
	<ul>
		<% if(member_grade != null){
			if(member_grade.equals("Green")){%>
		<li><img src="../../img/greenicon.png"/></li>
		<% } else { %>
		<li><img src="../../img/gold.png"/></li>
		<% } %>
	<% } %>
		<li id="line"></li>
		<li id="grade_info"><span class="txtBold"><%=member_name%></span>님의 구매등급은 <br> <span class="txtGreen"><%=member_grade%></span> 입니다.</li>
		<li id="line"></li>
		<li id="info"><div id="info-txt">밥풀</div><div id="real-info"><span id="db-info"><%=cybermoney.getSum_bobpul() - cybermoney2.getSum_use_bobpul()%></span><span id="sub-txt"> 풀</span></div></li>
		<li id="line"></li>
		<li id="info"><div id="info-txt">주문횟수</div><div id="real-info"><span id="db-info"><%=member_order_count %></span><span id="sub-txt"> 회</span></div></li>
		<li id="line"></li>
		<li id="info"><div id="info-txt">충전내역</div><div id="real-info"><span id="db-info"><%=cybermoney.getSum_bobpul() %></span><span id="sub-txt"> 풀</span></div></li>
		<li id="line"></li>
		<li id="info"></li>
	</ul>
</div>
<%  
    }catch(Exception e){
		e.printStackTrace();
	}
%>		