<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="team2.keep.KeepDBBean"%>
<%@ page import="team2.member.MemberDBBean"%>
 
<% request.setCharacterEncoding("utf-8");%>

	<jsp:useBean id="keep" class="team2.keep.KeepDataBean">
		<jsp:setProperty name="keep" property="*"/>
 	</jsp:useBean>
<% 
	String[] keepArray = new String[] {};
	String dosirak_name = request.getParameter("dosirak_name");
	keepArray = request.getParameterValues("menu_selecting");
	String container = request.getParameter("container_selecting");
	String selected = "";
	String member_id = "";
	member_id = (String)session.getAttribute("member_id");
	
	MemberDBBean memberdb = MemberDBBean.getInstance();
	int member_num = memberdb.getMember_num(member_id);
	
	if (keepArray != null) {  
		if(keepArray.length == 1) {  
			selected = keepArray[0];
		} else {
			for (int i = 0; i < keepArray.length; i++) {  
				selected += keepArray[i];  
				if( i < keepArray.length -1) {  
					selected += ",";  
				}  
			}  
		} 
		//out.println("selected: "+selected);
	}
	//response.sendRedirect("../keep/keep.jsp");
	int containerselected = Integer.parseInt(container);
	keep.setContainer_num(containerselected);
	keep.setSave_yes_no("0");
	keep.setMenu_num(selected);
	keep.setMember_num(member_num);
	keep.setDosirak_name(dosirak_name);
	
	KeepDBBean dbpro = KeepDBBean.getInstance();
	
	dbpro.insertKeep(keep);
		
 try{%>
	 <script>
	history.go(-1);
	alert("장바구니 담기가 완료되었습니다. 결제를 진행하시려면 하단의 주문하기 버튼을 클릭해 주세요.");
	</script>
	<%
 	}catch(Exception e){
	    e.printStackTrace();
	    out.println(e);
	}
%>