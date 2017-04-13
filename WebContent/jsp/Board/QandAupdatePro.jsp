<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team2.QandA_board.QandA_BoardDBBean" %>
<%@ page import = "java.sql.Timestamp" %>

<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="QandA_board" scope="page" class="team2.QandA_board.QandA_BoardDataBean">
   <jsp:setProperty name="QandA_board" property="*"/>
</jsp:useBean>
<%	
	int QandA_board_num = Integer.parseInt(request.getParameter("QandA_board_num"));
	String pageNum = request.getParameter("pageNum");

	QandA_BoardDBBean dbPro = QandA_BoardDBBean.getInstance();
    int check = dbPro.updateQandA_Board(QandA_board, QandA_board_num); 
	
    System.out.println(check);
    if(check==1){
%>
<meta http-equiv="Refresh" content="0;url=QandABoardList.jsp?pageNum=<%=pageNum%>">
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