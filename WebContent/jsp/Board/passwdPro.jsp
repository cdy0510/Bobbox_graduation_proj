<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team2.QandA_board.QandA_BoardDBBean"%>
<%@ page import="team2.QandA_board.QandA_BoardDataBean"%>
<%@ page import="team2.member.MemberDataBean"%>

<% request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="QandA_board" scope="page" class="team2.QandA_board.QandA_BoardDataBean">
   <jsp:setProperty name="QandA_board" property="*"/>
</jsp:useBean>
<%
  int QandA_board_num = Integer.parseInt(request.getParameter("QandA_board_num"));
  String pageNum = request.getParameter("pageNum");
  int QandA_board_passwd = Integer.parseInt(request.getParameter("QandA_board_passwd"));
 
  QandA_board.setQandA_board_passwd(QandA_board_passwd);
  QandA_BoardDBBean dbPro = QandA_BoardDBBean.getInstance(); 
  int check = dbPro.getQandA_Board_Passwd(QandA_board_num);
 
  if(check == QandA_board_passwd){
	 
%>
<meta http-equiv="Refresh" content="0;url=QandAboardForm.jsp?QandA_board_num=<%=QandA_board_num%>&pageNum=<%=pageNum%>">
<%}else{%>
    <script type="text/javascript">     
         alert("비밀번호가 맞지 않습니다");
         history.go(-1);
   </script>
<%} %>