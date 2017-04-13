<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team2.admin_board.Admin_BoardDBBean" %>
<%@ page import = "java.sql.Timestamp" %>

<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="admin_board" scope="page" class="team2.admin_board.Admin_BoardDataBean">
   <jsp:setProperty name="admin_board" property="*"/>
</jsp:useBean>
<%
	int admin_board_num = Integer.parseInt(request.getParameter("admin_board_num"));
	String pageNum = request.getParameter("pageNum");
	Admin_BoardDBBean dbPro = Admin_BoardDBBean.getInstance();
	int check = dbPro.updateAdmin_Board(admin_board, admin_board_num); 
	if(check==1){
%>
<meta http-equiv="Refresh" content="0;url=AdminBoard.jsp?pageNum=<%=pageNum%>">
<% }else{%>
      <script type="text/javascript">      
      <!--      
        alert("비밀번호가 맞지 않습니다");
        history.go(-1);
      -->
     </script>
<%
  }
%> 