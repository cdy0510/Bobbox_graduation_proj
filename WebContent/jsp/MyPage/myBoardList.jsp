<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team2.QandA_board.QandA_BoardDBBean"%>
<%@ page import="team2.QandA_board.QandA_BoardDataBean"%>
<%@ page import="team2.admin_comment.Admin_CommentDBBean"%>
<%@ page import="team2.admin_comment.Admin_CommentDataBean"%>
<%@ page import="team2.member.MemberDataBean"%>
<%@ page import="team2.member.MemberDBBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>    
<% request.setCharacterEncoding("utf-8");%>
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
    
    String member_id = "";
	member_id = (String) session.getAttribute("member_id");

	MemberDBBean memberdb = MemberDBBean.getInstance();
	int member_num = memberdb.getMember_num(member_id);
	
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
		<div id="con-tit"><b>1:1문의 확인</b></div>		
		<table>
			<tr>
				<th>작성일</th>
				<th>제목</th>
				<th>작성자</th>
				<th>문의상태</th>
			</tr>
			<%
				for (int i = 0; i <QandA_boardList.size(); i++) {
				       QandA_BoardDataBean QandA_board = QandA_boardList.get(i);
					   int QandA_board_num = QandA_board.getQandA_board_num();
					   
					   if(member_num == QandA_board.getMember_num()) {
				       
				       Admin_CommentDBBean boarddb = Admin_CommentDBBean.getInstance();
				       x = boarddb.getAdmin_CommentCount2(QandA_board_num);		   
			%>
			<tr>
				<td><%=sdf.format(QandA_board.getQandA_board_date())%></td>
				<td><a href="../Board/QandAboardForm.jsp?QandA_board_num=<%=QandA_board.getQandA_board_num()%>&pageNum=<%=currentPage%>">
						<%=QandA_board.getQandA_board_title()%>[<%=x%>]</a></td>
				<td><%=QandA_board.getMember_id()%></td>
				<td><span id="order-sit">접수완료</span></td>
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
		
		if(currentPage % 10 != 0)
           startPage = (int)(currentPage/10)*10 + 1;
		else
           startPage = ((int)(currentPage/10)-1)*10 + 1;

		int pageBlock = 10;
        int endPage = startPage + pageBlock - 1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) { %>
          <a href="myBoardList.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        
        for (int i = startPage ; i <= endPage ; i++) {  %>
           <a href="myBoardList.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%      }
        
        if (endPage < pageCount) {  %>
        <a href="myBoardList.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%
        }
    }
%>
	</div>
	
	<jsp:include page="footer.jsp" flush="false" />
</body>
</html>