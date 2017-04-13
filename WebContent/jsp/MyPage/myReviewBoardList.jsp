<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team2.review_board.Review_BoardDBBean"%>
<%@ page import="team2.review_board.Review_BoardDataBean"%>
<%@ page import="team2.board_comment.Board_CommentDBBean"%>
<%@ page import="team2.board_comment.Board_CommentDataBean"%>
<%@ page import="team2.member.MemberDataBean"%>
<%@ page import="team2.member.MemberDBBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>    
<% request.setCharacterEncoding("utf-8");%>
<%!int pageSize = 15;
    SimpleDateFormat sdf = 
        new SimpleDateFormat("yyyy-MM-dd HH:mm");%>

<%
	String pageNum = request.getParameter("pageNum");

		if (pageNum == null) {
			pageNum = "1";
		}

    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0;
    int number = 0;
    int x = 0;
    List<Review_BoardDataBean> Reivew_boardList = null; 
    
    String member_id = "";
	member_id = (String) session.getAttribute("member_id");

	MemberDBBean memberdb = MemberDBBean.getInstance();
	int member_num = memberdb.getMember_num(member_id);
    
    Review_BoardDBBean dbPro = Review_BoardDBBean.getInstance();
    count = dbPro.getReview_BoardCount();
  
    if (count > 0) {
    	Reivew_boardList = dbPro.getReview_Boards(startRow, endRow);
    }

	number = count-(currentPage-1)*pageSize;
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<title>주문리스트</title>
<link rel="stylesheet" href="../../css/my_order_list_style.css" />
<link rel="stylesheet" href="../../css/mypage_style.css" />
<script src="../../../js/jquery-2.1.0.min.js"></script>
</head>
<body>
	<jsp:include page="header.jsp" flush="false" />
	<div id="rootBar"><a href="Main.jsp">홈</a>&nbsp;&nbsp;>&nbsp;&nbsp;<a href="myOrderList.jsp">마이페이지</a>&nbsp;&nbsp;>&nbsp;&nbsp;<span id="now_page">전체주문내역</span></div>
	<jsp:include page="myPageTopNav.jsp" flush="false" />
	<jsp:include page="myPageLeftNav.jsp" flush="false" />
	<div id="contents">
		<div id="con-tit"><b>내가 쓴 게시물</b></div>		
		<table>
			<tr>
				<th>작성일</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
			</tr>
			<%
				for (int i = 0; i <Reivew_boardList.size(); i++) {
				       Review_BoardDataBean review_board = Reivew_boardList.get(i);
					   int review_board_num = review_board.getReview_board_num();
					   if(member_num == review_board.getMember_num()) { 
				       
				       Board_CommentDBBean boarddb = Board_CommentDBBean.getInstance();
				       x = boarddb.getBoard_CommentCount2(review_board_num);		   
			%>
			<tr>
				<td><%=sdf.format(review_board.getReview_board_date())%></td>
				<td><a href="../Board/boardForm.jsp?review_board_num=<%=review_board.getReview_board_num()%>&pageNum=<%=currentPage%>">
						<%=review_board.getReview_board_title()%>[<%=x%>]</a></td>
				<td><%=review_board.getMember_id()%></td>
				<td><span id="order-sit"><%=review_board.getReview_board_count()%></span></td>
			</tr>
			<%}%>
			<%}%>
		</table>
		</div>
	<div id="page_num_area">
	<%
    if (count > 20) {
        int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage =1;
		
		if(currentPage % 15 != 0)
           startPage = (int)(currentPage/15)*15 + 1;
		else
           startPage = ((int)(currentPage/15)-1)*15 + 1;

		int pageBlock = 15;
        int endPage = startPage + pageBlock - 1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 15) { %>
          <a href="myReviewBoardList.jsp?pageNum=<%= startPage - 15 %>">[이전]</a>
<%      }
        
        for (int i = startPage ; i <= endPage ; i++) {  %>
           <a href="myReviewBoardList.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%      }
        
        if (endPage < pageCount) {  %>
        <a href="myReviewBoardList.jsp?pageNum=<%= startPage + 15 %>">[다음]</a>
<%
        }
    }
%>
	</div>
	
	<jsp:include page="footer.jsp" flush="false" />
</body>
</html>