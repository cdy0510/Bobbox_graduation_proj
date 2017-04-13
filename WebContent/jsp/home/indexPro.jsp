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
	String[] keepArray = new String[] {};
	keepArray = request.getParameterValues("menu_selecting");  
	String menu_sort = request.getParameter("menu_sort");
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
		}%>
		<script>
		location.href="index.jsp?menu_sort=<%=menu_sort%>&menu_selecting=<%=selected%>";
		</script>
		<%
	}else {%>
		<script>
		location.href="index.jsp?menu_sort=<%=menu_sort%>";
		</script>
	<%
	}
%>
