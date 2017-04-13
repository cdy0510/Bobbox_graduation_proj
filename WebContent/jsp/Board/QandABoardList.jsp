<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="team2.QandA_board.QandA_BoardDBBean"%>
<%@ page import="team2.QandA_board.QandA_BoardDataBean"%>
<%@ page import="team2.admin_comment.Admin_CommentDBBean"%>
<%@ page import="team2.admin_comment.Admin_CommentDataBean"%>
<%@ page import="team2.member.MemberDataBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%!int pageSize = 10;
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
    List<QandA_BoardDataBean> QandA_boardList = null; 
    
    QandA_BoardDBBean dbPro = QandA_BoardDBBean.getInstance();
    count = dbPro.getQandA_BoardCount();
  
    if (count > 0) {
        QandA_boardList = dbPro.getQandA_Boards(startRow, endRow);
    }

	number = count-(currentPage-1)*pageSize;
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시판</title>
<link href="../../css/header_style.css" rel="stylesheet" type="text/css">
<link href="../../css/board_list_style.css" rel="stylesheet"
	type="text/css">
<script src="../../js/jquery-2.1.0.min.js"></script>
<script>
	function popPasswd(){
		window.open('passwd.jsp', 'newwindow', 'top=30, left=100, width=415, height=540');
	}
</script>
<style type="text/css">
#board_kind {
	background-image: url("../../img/board_qna.jpg");
	width: 700px;
	height: 43px;
	border-bottom: 1px solid #fff;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" flush="false" />
	
	<div id="board_page">
	<div id="board_kind">
		<a href="AdminBoardList.jsp"><span id="notice_board"></span></a>
		<a href="QandABoardList.jsp"><span id="qna_board"></span></a>
		<a href="reviewBoardList.jsp"><span id="review_board"></span></a>
	</div>
	<div id="board_area">	
		<table>
			<tr id="table-header">
				<td id="board-num">글번호</td>
				<td id="board-title">제목</td>
				<td id="board-writer">작성자</td>
				<td id="board-day">작성일</td>
				<td id="board-read-count">조회수</td>
			</tr>
			<%
				for (int i = 0; i <QandA_boardList.size(); i++) {
				       QandA_BoardDataBean QandA_board = QandA_boardList.get(i);
					   int QandA_board_num = QandA_board.getQandA_board_num();
				       
				       Admin_CommentDBBean boarddb = Admin_CommentDBBean.getInstance();
				       x = boarddb.getAdmin_CommentCount2(QandA_board_num);		   
			%>
			<tr id="table-content">
				<td id="board-num"><%=QandA_board.getQandA_board_num()%></td>
				<td id="board-title"><a href="passwd.jsp?QandA_board_num=<%=QandA_board.getQandA_board_num()%>&pageNum=<%=currentPage%>">
						<%=QandA_board.getQandA_board_title()%>[<%=x%>]</a></td>
				<td id="board-writer"><%=QandA_board.getMember_id()%></td>
				<td id="board-day"><%=sdf.format(QandA_board.getQandA_board_date())%></td>
				<td id="board-read-count"><%=QandA_board.getQandA_board_count()%></td>
			</tr>
			<%}%>
		</table>
	</div>
	<div id="page_num_area">
	<%
    if (count > 0) {
        int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage =1;
		
		if(currentPage % 10 != 0)
           startPage = (int)(currentPage/10)*10 + 1;
		else
           startPage = ((int)(currentPage/10)-1)*10 + 1;

		int pageBlock = 10;
        int endPage = startPage + pageBlock - 1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) { %>
          <a href="QandABoardList.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        
        for (int i = startPage ; i <= endPage ; i++) {  %>
           <a href="QandABoardList.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%      }
        
        if (endPage < pageCount) {  %>
        <a href="QandABoardList.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%
        }
    }
%>
	</div>
	<div id="btnarea">
		<input type="button" value="글쓰기" onclick="location.href='QandAboardWriteForm.jsp'">
	</div>
	</div>
</body>
</html>
