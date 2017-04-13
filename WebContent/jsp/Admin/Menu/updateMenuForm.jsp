<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%@ page import="team2.menu.MenuDBBean" %>
<%@ page import="team2.menu.MenuDataBean" %>
<%@ page import="team2.supplier.SupplierDBBean" %>
<%@ page import="team2.supplier.SupplierDataBean" %>
<%@ page import="java.util.List" %>
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
	SupplierDBBean sDBPro = SupplierDBBean.getInstance();
	
	count = sDBPro.getSupplierCount();
	
	if (count > 0) {
		supplierList = sDBPro.getSupplierList(startRow, pageSize);
	}
	int i = Integer.parseInt(request.getParameter("menuNumber"));
	try {
		MenuDBBean mDBPro = MenuDBBean.getInstance();
		MenuDataBean menu =  mDBPro.getMenu(i);
%>
    
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
<form name="updateMenuForm" method="post" action="updateMenuPro.jsp"
	enctype="multipart/form-data">
	<img id="logo" src="../../../img/BOBBOX_LOGO_Text.png" /><br><br>
   	<div id="must_write">
   		<div class="line">
   			<input type="hidden" name="menu_num" value="<%=menu.getMenu_num() %>">
   			<div class="label">이미지</div>
   			<input type="text" id="fileName" name="menu_image" value="<%=menu.getMenu_image()%>"/>
   			<span class="btn btn-success fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>파일찾기</span>
		        <!-- The file input field used as target for the file upload widget -->
		        <input id="fileupload" type="file" name="files[]" multiple onchange="javascript: document.getElementById('fileName').value = this.value.substring(this.value.lastIndexOf('\\')+1);document.getElementById('fileImage').src = '../../../fileSave/' + this.value.substring(this.value.lastIndexOf('\\')+1)">

		    </span>
		    <img id="fileImage" style="width:100px" src="../../../fileSave/<%=menu.getMenu_image()%>">
   		</div>
   		<div class="line">
               <div class="label">대분류</div>
	               <select name="menu_big_class" onchange="showSub(this)">
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
               <input type="hidden" name="menu_small_class" value="<%=menu.getMenu_small_class() %>">
	               <select name="sub1">
	               		<option value="small-null">선택하세요.</option>
	               </select>
	               
	               <select name="sub2" style="display: none;">		
	               		<option value="밥/죽">밥/죽</option>
	               </select>
	               
	               <select name="sub3" style="display: none;">
	               		<option value="국/탕/찌개">국/탕/찌개</option>
	               </select>
	               
	               <select name="sub4" style="display: none;">		
	               		<option value="구이/튀김">구이/튀김</option>
	               		<option value="조림/볶음/부침">조림/볶음/부침</option>
	               		<option value="무침/냉채">무침/냉채</option>
	               		<option value="찜/삶기">찜/삶기</option>
	               </select>
	               
	               <select name="sub5" style="display: none;">		
	               		<option value="과일/샐러드">과일/샐러드</option>
	               		<option value="씨리얼/과자">씨리얼/과자</option>
	               		<option value="음료/식수">음료/식수</option>
	               </select>
        </div>
   		<div class="line">
   			<div class="label">메뉴명</div><input type="text" name="menu_name" value="<%=menu.getMenu_name() %>"><br>
   		</div>
   		<div class="line">
   			<div class="label">공급업체</div>
   			<select name="supplier_num">
<% 
for(int j=0; j<supplierList.size(); j++) {
	SupplierDataBean supplier = supplierList.get(j);
%>
   				<option value="<%=supplier.getSupplier_num() %>"><%=supplier.getSupplier_name() %></option>
 				<%
}
   				%>
   			</select>
   		</div>
   		<div>
   			<div class="label">밥풀</div><input type="text" name="menu_charge" value="<%=menu.getMenu_charge() %>"><br>
   		</div>
   		<div>
   			<div class="label">공급원가</div><input type="text" name="menu_cost" value="<%=menu.getMenu_cost() %>" >
   		</div>
   	</div><br>
       
    <div id="sub_write">
		<div class="line">
			<div class="label">열량</div><input type="text" name="menu_kcal" value="<%=menu.getMenu_kcal() %>">
		</div>
		<div class="line">
			<div class="label">탄수화물(g)</div><input type="text" name="menu_carbor" value="<%=menu.getMenu_carbor() %>">
		</div>
		<div class="line">
			<div class="label">단백질(g)</div><input type="text" name="menu_protein" value="<%=menu.getMenu_protein() %>"><br>
		</div>
		<div class="line">
			<div class="label">지방(g)</div><input type="text" name="menu_fat" value="<%=menu.getMenu_fat() %>"><br>
		</div>
		<div class="line">
			<div class="label">나트륨(g)</div><input type="text" name="menu_natrium" value="<%=menu.getMenu_natrium() %>"><br>
		</div>   
	</div>
	
    <input type="submit" value="메뉴 수정" />
 </form>
 <script type="text/javascript">
	var f = document.updateMenuForm;
	var ch1 = f.menu_big_class;
	for (var i=0; i<ch1.length; i++){
		if(ch1[i].value == '<%=menu.getMenu_big_class() %>'){
			ch1[i].selected = true;
		}
	}
	
	var smallClass = '<%=menu.getMenu_small_class() %>';
	var ch2 = f.sub2;
	var ch3 = f.sub3;
	var ch4 = f.sub4;
	var ch5 = f.sub5;
	for (var i=0; i<ch2.length; i++){
		if(ch2[i].value == smallClass){
			ch2[i].selected = true;
			f.sub1.style.display = "none";
			f.sub2.style.display = "";
		}
	}
	for (var i=0; i<ch3.length; i++){
		if(ch3[i].value == smallClass){
			ch3[i].selected = true;
			f.sub1.style.display = "none";
			f.sub3.style.display = "";
		}
	}
	for (var i=0; i<ch4.length; i++){
		if(ch4[i].value == smallClass){
			ch4[i].selected = true;
			f.sub1.style.display = "none";
			f.sub4.style.display = "";
		}
	}
	for (var i=0; i<ch5.length; i++){
		if(ch5[i].value == smallClass){
			ch5[i].selected = true;
			f.sub1.style.display = "none";
			f.sub5.style.display = "";
		}
	}
	
	function showSub(parentBox) {	    
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
 <%
	 }catch(Exception e){}%>

</div>
</body>
</html>