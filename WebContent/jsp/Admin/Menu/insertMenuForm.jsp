<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="team2.supplier.SupplierDBBean" %>
<%@ page import="team2.supplier.SupplierDataBean" %>
<% request.setCharacterEncoding("utf-8");%>
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
	
	List<SupplierDataBean> supplierList = null; 
	SupplierDBBean dbPro = SupplierDBBean.getInstance();
	
	count = dbPro.getSupplierCount();
	
	if (count > 0) {
		supplierList = dbPro.getSupplierList(startRow, pageSize);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
  <title>BOBBOX :: 메뉴 등록</title>
  <!-- Bootstrap styles -->
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
	<!-- CSS to style the file input field as button and adjust the Bootstrap progress bars -->
	<link rel="stylesheet" href="../../../css/jquery.fileupload.css">
  <link rel="stylesheet" href="../../../css/insert_menu_style.css" />
</head>
<body>
<div class="box">
<form name="insertMenuForm" method="post" action="insertMenuPro.jsp"
	enctype="multipart/form-data">
	<a href="../AdminMain.jsp"><img id="logo" src="../../../img/BOBBOX_LOGO_Text.png" /></a><br><br>
   	<div id="must_write">
   		<div class="line">
   			<input type="hidden" name="menu_num">
   			<div class="label">이미지</div>
   			<input type="text" id="fileName" name="menu_image"/>
   			<span class="btn btn-success fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>파일찾기</span>
		        <!-- The file input field used as target for the file upload widget -->
		        <input id="fileupload" type="file" name="files[]" multiple onchange="javascript: document.getElementById('fileName').value = this.value.substring(this.value.lastIndexOf('\\')+1);document.getElementById('fileImage').src = '../../../fileSave/' + this.value.substring(this.value.lastIndexOf('\\')+1)">

		    </span>
		    <img id="fileImage" style="width:100px">
   		</div>
   		<div class="line">
   			<div class="label">메뉴명</div><input type="text" name="menu_name"><br>
   		</div>
   		<div class="line">
               <div class="label">대분류</div>
	               <select id="menuselect" name="menu_big_class" onchange="showSub(this)">
	               		<option value="big-null">선택하세요.</option>
	               		<option value="밥/죽">밥/죽</option>
	               		<option value="국/탕/찌개">국/탕/찌개</option>
	               		<option value="반찬">반찬</option>
	               		<option value="후식/기타">후식/기타</option>
	               </select>
               <br>
           </div>
   		<div class="line">
               <div class="label">소분류</div>
	               <select id="menuselect" name="sub1">
	               		<option value="small-null">선택하세요.</option>
	               </select>
	               
	               <select id="menuselect" name="sub2" style="display: none;">		
	               		<option value="밥/죽">밥/죽</option>
	               </select>
	               
	               <select id="menuselect" name="sub3" style="display: none;">
	               		<option value="국/탕/찌개">국/탕/찌개</option>
	               </select>
	               
	               <select id="menuselect" name="sub4" style="display: none;">		
	               		<option value="구이/튀김">구이/튀김</option>
	               		<option value="조림/볶음/부침">조림/볶음/부침</option>
	               		<option value="무침/냉채">무침/냉채</option>
	               		<option value="찜/삶기">찜/삶기</option>
	               </select>
	               
	               <select id="menuselect" name="sub5" style="display: none;">		
	               		<option value="과일/샐러드">과일/샐러드</option>
	               		<option value="씨리얼/과자">씨리얼/과자</option>
	               		<option value="음료/식수">음료/식수</option>
	               </select>
        </div>
   		
   		<div class="line">
   			<div class="label">공급업체</div>
   			<select name="supplier_num">
<% for(int i=0; i<supplierList.size(); i++) {
	SupplierDataBean supplier = supplierList.get(i);%>
   				<option value="<%=supplier.getSupplier_num() %>"><%=supplier.getSupplier_name() %></option>
 				<%
}
   				%>
   			</select>
   		</div>
   		<div class="line">
   			<div class="label">밥풀</div><input type="text" name="menu_charge">
   		</div>
   		<div>
   			<div class="label">공급원가</div><input type="text" name="menu_cost">
   		</div>
   	</div><br>
       
    <div id="sub_write">
		<div class="line">
			<div class="label">열량</div><input type="text" name="menu_kcal">
		</div>
		<div class="line">
			<div class="label">탄수화물(g)</div><input type="text" name="menu_carbor">
		</div>
		<div class="line">
			<div class="label">단백질(g)</div><input type="text" name="menu_protein" ><br>
		</div>
		<div class="line">
			<div class="label">지방(g)</div><input type="text" name="menu_fat" ><br>
		</div>
		<div>
			<div class="label">나트륨(g)</div><input type="text" name="menu_natrium" ><br>
		</div>   
	</div>
	
    <input type="submit" value="메뉴 등록" />
 </form>
</div>
<script type="text/javascript">
function showSub(parentBox) {
    var f = document.forms.insertMenuForm;
    
    var obj = parentBox.options[parentBox.selectedIndex].value;
    
    if (obj == "big-null") {
    	f.sub1.style.display = "";
    	f.sub2.style.display = "none";
    	f.sub3.style.display = "none";
	    f.sub4.style.display = "none";
	    f.sub5.style.display = "none";
    }
    else if(obj == "밥/죽") {
    	f.sub1.style.display = "none";
    	f.sub2.style.display = "";
    	f.sub2.name = "menu_small_class";
	    f.sub3.style.display = "none";
	    f.sub4.style.display = "none";
	    f.sub5.style.display = "none";
	} else if (obj == "국/탕/찌개") {
		f.sub1.style.display = "none";
		f.sub2.style.display = "none";
	    f.sub3.style.display = "";
	    f.sub3.name = "menu_small_class";
	    f.sub4.style.display = "none";
	    f.sub5.style.display = "none";
	} else if (obj == "반찬") {
		f.sub1.style.display = "none";
		f.sub2.style.display = "none";
		f.sub3.style.display = "none";
		f.sub4.style.display = "";
		f.sub4.name = "menu_small_class";
		f.sub5.style.display = "none";
	} else {
		f.sub1.style.display = "none";
		f.sub2.style.display = "none";
		f.sub3.style.display = "none";
		f.sub4.style.display = "none";
		f.sub5.style.display = "";
		f.sub5.name = "menu_small_class";
	}
}
</script>
</body>
</html>