function allCk(objCheck){ 
	var checks = document.getElementsByName('menu_chk');
	for(var i=0; i<checks.length; i++ ){
	 checks[i].checked = objCheck; 
	}
}

function orderGo(){
	var check = document.getElementsByName('menu_chk');
	var j=0;
	for (var i=0; i<check.length; i++){
		if (check[i].checked == true){
			j++;
		}
	}
	if (j>0) {
		var menuForm = document.getElementById("menuForm");
		menuForm.action = "../MenuOrderSheet/insertMenuOrderSheet.jsp";
		menuForm.submit();	
	} else {
		alert('1개 이상의 메뉴를 체크해주세요.');
	}
}

function deleteGo(){
	if (confirm('정말로 삭제하시겠습니까?')){
		var menuForm = document.getElementById("menuForm");
		menuForm.action = "deleteMenuPro.jsp";
		menuForm.submit();
	}
	return false;
}

function updateGo(i){
	var menuForm = document.getElementById("menuForm");
	menuForm.action = "updateMenuForm2.jsp?menuNumber="+i;
	menuForm.submit();
	return false;
}

function showMenu(str){
	document.getElementById("show").value = str;
}