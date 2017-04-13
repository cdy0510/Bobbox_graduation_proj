<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<link rel="stylesheet" href="../../css/mypage_left_nav_style.css" />
<script src="../../js/jquery-2.1.0.min.js"></script>
<script>
	function popCharge(){
		window.open('charge.jsp', 'newwindow', 'top=30, left=100, width=415, height=540');
	}
</script>
<div id="leftBar">
		<ul>
			<li id="left-img"><a href="myOrderList.jsp"><img src="../../img/orderlisticon.png"/></a></li>
			<a href="myOrderList.jsp"><li id="left-sub">- 전체주문내역</li></a>
			<li id="left-img"><img src="../../img/activityicon.png" /></li>
			<a href="myBobbox.jsp"><li id="left-sub">- 나만의 도시락</li></a>
			<a href="myReviewBoardList.jsp"><li id="left-sub">- 내가 쓴 게시물</li></a>
			<a href="../Board/QandAboardWriteForm.jsp"><li id="left-sub">- 1:1 문의하기</li></a>
			<a href="myBoardList.jsp"><li id="left-sub">- 1:1 문의확인</li></a>
			<li id="left-img"><img src="../../img/bobful.png" /></li>
			<a href="javascript:popCharge()"><li id="left-sub">- 충전하기</li></a>
			<a href="bobfulUsedList.jsp"><li id="left-sub">- 사용내역</li></a>
			<li id="left-img"><img src="../../img/infoicon.png" /></li>
			<a href="updateMemberForm.jsp"><li id="left-sub">- 회원정보수정</li></a>
			<a href="myGrade.jsp"><li id="left-sub">- 회원등급</li></a>
		</ul>
</div>