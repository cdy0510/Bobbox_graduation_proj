<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="team2.keep.KeepDBBean" %>
<jsp:useBean id="keep" class="team2.keep.KeepDataBean">
     <jsp:setProperty name="keep" property="*"/>
</jsp:useBean>
<%
String member_id = "";
member_id = (String)session.getAttribute("member_id");

if(member_id == null){%>
	<script>
	alert("로그인 후 이용해 주세요.");
	history.go(-1);
	</script>
<%}
	   
	String[] keepArray = new String[] {};
	keepArray = request.getParameterValues("menu_selecting");  
	String selected = "";
	
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
	}else {%>
		<script>
		alert("선택된 메뉴가 없습니다.");
		history.go(-1);
		</script>	
<%  }
%>
<html>
<form id="myForm" action="../keep/keep.jsp" method="POST">
	<input type="hidden" name="menu_selecting" value="<%=selected %>">
</form>
<script>
document.getElementById("myForm").submit();
</script>
</html>
