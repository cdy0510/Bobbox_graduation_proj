<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디 찾기</title>
<%
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
%>
</head>
<body>
<%
	PreparedStatement pstmt = null;
	String str=null;
	ResultSet rs = null;
	try{
		Class.forName("org.gjt.mm.mysql.Driver");
		String url="jdbc:mysql://128.134.114.250:3306/2014a2";
		String user="2014a2";
		String password="coocoo";
		Connection conn = DriverManager.getConnection(url, user, password);
		String sql =  "select * from member where member_name=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name); 
		rs = pstmt.executeQuery();
		
		while(rs.next()){
			String id = rs.getString("member_id");
			%>
			<script type="text/javascript">
				alert("아이디는 "+<%=id %>+" 입니다.");
				window.close();
			</script>
			<% 
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}

	%>
</body>
</html>