<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
  <title>메뉴 등록</title>
  <!-- Bootstrap styles -->
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
	<!-- CSS to style the file input field as button and adjust the Bootstrap progress bars -->
	<link rel="stylesheet" href="../../../css/jquery.fileupload.css">
  <link rel="stylesheet" href="../../../css/insert_menu_style.css" />
</head>
<body>
<div class="box">
<form name="insertContainerForm" method="post" action="insertContainerPro.jsp"
	enctype="multipart/form-data">
    <a href="../AdminMain.jsp"><img id="logo" src="../../../img/BOBBOX_LOGO_Text.png" /></a><br><br>
   
   	<div id="must_write">
   		<div class="line">
   			<input type="hidden" name="container_num">
   			<div class="label">이미지</div>
   			<input type="text" id="fileName" name="container_image" />
   			<span class="btn btn-success fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>파일찾기</span>
		        <!-- The file input field used as target for the file upload widget -->
		        <input id="fileupload" type="file" name="files[]" multiple onchange="javascript: document.getElementById('fileName').value = this.value.substring(this.value.lastIndexOf('\\')+1);
		        document.getElementById('fileName_detail').value = document.getElementById('fileName').value.substring(0,document.getElementById('fileName').value.lastIndexOf('.jpg')) + '_detail.jpg';
		        document.getElementById('fileImage').src = '../../../fileSave/' + this.value.substring(this.value.lastIndexOf('\\')+1);
		        document.getElementById('fileImage_detail').src = '../../../fileSave/' + document.getElementById('fileName').value.substring(0,document.getElementById('fileName').value.lastIndexOf('.jpg')) + '_detail.jpg'">

		    </span>
		    <img id="fileImage" style="width:100px" >
		    <img id="fileImage_detail" style="width:100px" >
		    <input type="hidden" id="fileName_detail" name="container_detail_image"/>
   		</div>
   		<div class="line">
   			<div class="label">용기명</div><input type="text" name="container_name"><br>
   		</div>
   		<div class="line">
   			<div class="label">가격</div><input type="text" name="container_price">
   		</div>
   		<div>
   			<div class="label">칸수</div><input type="text" name="room_count">
   		</div>
   	</div>
    <input type="submit" value="용기 등록" />
 </form>
</div>
</body>
</html>