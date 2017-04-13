<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team2.review_board.Review_BoardDBBean"%>
<%@ page import="team2.review_board.Review_BoardDataBean"%>
<%@ page import="team2.member.MemberDataBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
  int review_board_num = Integer.parseInt(request.getParameter("review_board_num"));
  String pageNum = request.getParameter("pageNum");

%>
<html>
<head>
<title>게시판</title>
<script src="../../js/jquery-2.1.0.min.js"></script>
<link rel="stylesheet" href="../../css/passwd_style.css" />
<script type="text/javascript">      
  function deleteSave(){	
	if(!document.delForm.passwd.value){
	   alert("비밀번호를 입력하십시요.");
	   document.delForm.passwd.focus();
	   return false;
    }
  }    
</script>
</head>
<body>
<jsp:include page="header.jsp" flush="false" />
<form method="POST" name="passwd" 
   action="deletePro.jsp?review_board_num=<%=review_board_num%>&pageNum=<%=pageNum%>" 
   onsubmit="return deleteSave()"> 
 <div class="box">  
 <table>
  <tr height="30">
 	 <td>
       <b>비밀번호를 입력해 주세요.</b>
       </td>
  </tr>
  <tr height="30">
     <td align=center >비밀번호 :   
       <input type="password" name="review_board_passwd" size="8" maxlength="12">
	   <input type="hidden" name="review_board_num" value="<%=review_board_num%>">
 </tr>
 <tr height="30">
 <td>
      <div class="ok"><input type="submit" value="확인"/>
      <input type="button" value="글목록" 
       onclick="document.location.href='reviewBoardList.jsp?pageNum=<%=pageNum%>'"/></div>     
   </td>
 </tr>  
</table> 
</div>
</form>
</body>
</html>