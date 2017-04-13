//-----------------------이용약관 Script-----------------------
//전체 체크시에 나머지 체크박스 체크
var check = 0;
var check1 = 0;
var check2 = 0;
$(document).on('click','#check_all',function() {
	if(check==0){
		document.getElementById('check1').checked = "checked";
		document.getElementById('check2').checked = "checked";
		check = 1;
		check1 = 1;
		check2 = 1;
	}else{
		document.getElementById('check1').checked = "";
		document.getElementById('check2').checked = "";
		check = 0;
		check1 = 0;
		check2 = 0;
	}
	
});

$(document).on('click','#check1',function() {
	if(document.getElementById('check1').checked == null){
		check1 = 0;
	}else{
		check1 = 1;
	}
});
$(document).on('click','#check2',function() {
	if(document.getElementById('check2').checked == null){
		check2 = 0;
	}else{
		check2 = 1;
	}
});

//모두동의 하지 않았을 경우 경고창
$(document).on('click','#agree',function() {
	if(check1 == 0 || check2 == 0){
		alert("모두 동의하셔야 회원가입이 가능합니다.");
		location.href='TOSForm.html';
	}
});