<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team2.review_board.Review_BoardDBBean"%>
<%@ page import="team2.review_board.Review_BoardDataBean"%>
<%@ page import="team2.board_comment.Board_CommentDBBean"%>
<%@ page import="team2.board_comment.Board_CommentDataBean"%>
<%@ page import="team2.member.MemberDBBean"%>
<%@ page import = "java.sql.Timestamp" %>

<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="board_comment" scope="page" class="team2.board_comment.Board_CommentDataBean">
   <jsp:setProperty name="board_comment" property="*"/>
</jsp:useBean>

<%
	int review_board_num = Integer.parseInt(request.getParameter("review_board_num"));
	int board_comment_num = Integer.parseInt(request.getParameter("board_comment_num"));
	String pageNum = request.getParameter("pageNum");
	
	String member_id = "";
	member_id = (String) session.getAttribute("member_id");
	
	MemberDBBean memberdb = MemberDBBean.getInstance();
	int member_num = memberdb.getMember_num(member_id);

	board_comment.setMember_num(member_num);

  	Board_CommentDBBean dbPro = Board_CommentDBBean.getInstance(); 
  	int check = dbPro.deleteBoard_Comment(board_comment, board_comment_num, member_num);
  	
  	 if(check==1){
%>
<meta http-equiv="Refresh" content="0;url=boardForm.jsp?review_board_num=<%=review_board_num%>&pageNum=<%=pageNum%>">
<%}else{%>
    <script type="text/javascript">      
       <!--      
         alert("해당 권한이 없습니다");
         history.go(-1);
       -->
   </script>
<%} %>