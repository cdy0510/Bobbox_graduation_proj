<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="team2.container.ContainerDBBean" %>
<%@ page import="team2.container.ContainerDataBean" %>

<%
	int pageSize = 10;

	String pageNum = null;
	
	if (pageNum == null) {
	    pageNum = "1";
	}

	int currentPage = Integer.parseInt(pageNum);
	int count = 0;
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	List<ContainerDataBean> containerList = null; 
	ContainerDBBean dbPro = ContainerDBBean.getInstance();

	count = dbPro.getContainerCount();
	
	if (count > 0) {
		containerList = dbPro.getContainerList(startRow, pageSize);
    }
	 
	
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>관리자</title>
<link rel="stylesheet" type="text/css" href="../admincss/header_style.css"></link>
<link rel="stylesheet" type="text/css" href="../../../css/menu_style.css"></link>
<link rel="stylesheet" type="text/css" href="../../../css/footer_style.css"></link>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
</head>
<body>
	<div id="header">
		<div id="logo">
            <img height="80px" src="../../../img/BOBBOX_LOGO_Text.png" />
		</div>
		<div id="admin-hello">
            관리자님, 안녕하세요.
            <a href="../../Login/Logout.jsp">로그아웃</a>
        </div>
	</div>
    <div id="content-header">
        <span id="rootBar"><a href="../AdminMain.jsp">Home</a>&nbsp;&nbsp;>&nbsp;&nbsp;<span id="now_page">용기관리</span></span>
       	<span class="floatRight" id="btnBox">
	        <span id="menu-btn" onclick="location.href='insertContainerForm.jsp'">등록</span>
	        <span id="menu-btn" onclick="deleteGo();">삭제</span>
        </span>
    </div>
	<div id="contents">
        <form name="containerForm" id="containerForm" action="" method="POST">
	        <table>
	            <tr>
	                <th id="chk"><input type="checkbox" onclick="allCk(this.checked);"></th>
	                <th id="num">번호</th>
	                <th id="containername">용기명</th>
	                <th id="price">가격</th>
	                <th id="cannum">칸수</th>
	                <th id="btn">-</th>
	            </tr>
<% for (int i = 0 ; i < containerList.size() ; i++) {
	ContainerDataBean container = containerList.get(i);
%>
	            <tr>
	                <td><input type="checkbox" value="<%=container.getContainer_num()%>" name="container_chk" /></td>
	                <td><%=container.getContainer_num() %></td>
	                <td><%=container.getContainer_name() %></td>
	                <td><%=container.getContainer_price() %></td>
	                <td><%=container.getRoom_count() %></td>
	                <td><input type="button" id="update-btn" value="수정" onclick="updateGo(<%=container.getContainer_num() %>)"></td>
	            </tr>
<%} %>
	        </table>
        </form>
	</div>
	
	<jsp:include page="../footer.jsp" flush="false"/>
</body>
<script type="text/javascript">
function allCk(objCheck){ 
	var checks = document.getElementsByName('container_chk');
	for(var i=0; i<checks.length; i++ ){
	 checks[i].checked = objCheck; 
	}
}

function deleteGo(){
	if (confirm('정말로 삭제하시겠습니까?')){
		var containerForm = document.getElementById("containerForm");
		containerForm.action = "deleteContainerPro.jsp";
		containerForm.submit();
	}
	return false;
}

function updateGo(i){
	var menuForm = document.getElementById("containerForm");
	menuForm.action = "updateContainerForm.jsp?containerNumber="+i;
	menuForm.submit();
	
	return false;
}
</script>
</html>