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
	String dosirak_price = request.getParameter("dosirak_price");
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
	keep.setSave_yes_no("1");
	keep.setMenu_num(selected);
	keep.setMember_num(member_num);
	keep.setDosirak_name(dosirak_name);
	keep.setDosirak_price(dosirak_price);
	
	KeepDBBean dbpro = KeepDBBean.getInstance();
	
	dbpro.insertKeep(keep);
		
 try{%>
	 <script>
	history.go(-1);
	alert("도시락을 저장이 완료되었습니다. 저장하신 도시락은 ' 마이페이지 > 밥박스 활동 > 나만의 도시락 '에서 확인할 수 있습니다.");
	</script>
	<%
 	}catch(Exception e){
	    e.printStackTrace();
	    out.println(e);
	}
%>