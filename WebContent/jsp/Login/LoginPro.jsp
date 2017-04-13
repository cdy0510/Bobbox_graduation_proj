<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="team2.member.MemberDBBean" %>
<% request.setCharacterEncoding("utf-8");%>

<%
    String member_id = request.getParameter("member_id");
	String member_passwd  = request.getParameter("member_passwd"); 
	
	MemberDBBean logon = MemberDBBean.getInstance();
    int check= logon.userCheck(member_id, member_passwd);
	
    if(check==1){
		session.setAttribute("member_id", member_id);
		if(member_id.equals("admin")){
			response.sendRedirect("../Admin/AdminMain.jsp");
		}else{
			response.sendRedirect("../home/index.jsp");
		}
	}else if(check==0){%>
	<script> 
	  alert("비밀번호가 맞지 않습니다.");
      history.go(-1);
	</script>
<%}else{ %>
	<script>
	  alert("아이디가 맞지 않습니다..");
	  history.go(-1);
	</script>
<%}%>