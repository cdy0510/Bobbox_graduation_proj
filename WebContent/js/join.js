//성별 클릭시 버튼 색깔 ON/OFF
var m_img = new Array("../../img/man.png", "../../img/man_check.png");
var w_img = new Array("../../img/woman.png", "../../img/woman_check.png");
//남자
$(document).on('click','#genderM',function() {
	document.getElementById('man').src = m_img[1];
	document.getElementById('woman').src = w_img[0];
	document.getElementById('gender_value').value = "남자";
});

//여자
$(document).on('click','#genderW',function() {
	document.getElementById('woman').src = w_img[1];
	document.getElementById('man').src = m_img[0];
	document.getElementById('gender_value').value = "여자";
});

//아이디 체크
var xmlReq; // 전역변수로 지정.
// Ajax 객체 생성 과정
function createAjax() {
	xmlReq = new XMLHttpRequest();
}

// Ajax 객체를 이용한 데이터 전송 과정
function ajaxSend() {
	createAjax();
	var uid = document.getElementById("uid").value;
	xmlReq.onreadystatechange = callBack;
	xmlReq.open("GET", "overlapCheck.jsp?uid=" + uid, true);
	xmlReq.send(null);
	// send가 끝나고나면 비동기식이기 때문에 프로그램이 계속 진행된다.
}

// 콜백 함수 과정
function callBack() {
	if (xmlReq.readyState == 4) {
		if (xmlReq.status == 200) {
			printData();
		}
	}
}

// 결과 출력 과정
function printData() {
	var result = xmlReq.responseXML;
	var rootNode = result.documentElement;
	// <root>true</root> , <root>false</root>
	var rootValue = rootNode.firstChild.nodeValue;
	var rootTag = document.getElementById("id_msg");

	if (rootValue == "true") {
		rootTag.style.color = "#A5C440";
		rootTag.style.display = "inline";
		rootTag.innerHTML = "사용 가능한 아이디입니다.";
	} else {
		rootTag.style.color = "red";
		rootTag.style.display = "inline";
		rootTag.innerHTML = "중복된 아이디입니다.";
	}
}

//비밀번호 체크
function checkvalue() {
	var passwd = document.getElementById('pw').value;
	var repasswd = document.getElementById('pw_check').value;
	var pw_msg = document.getElementById('pw_msg');
	if(passwd.length == 0) {
		pw_msg.style.display = "inline";
		pw_msg.style.color = "red";
		pw_msg.innerHTML = "비밀번호가 입력되지 않았습니다.";
	}else if(repasswd.length == 0) {
		pw_msg.style.display = "inline";
		pw_msg.style.color = "red";
		pw_msg.innerHTML = "비밀번호를 다시한번 입력해 주세요.";
	}else if(passwd != repasswd) {
		pw_msg.style.display = "inline";
		pw_msg.style.color = "red";
		pw_msg.innerHTML = "비밀번호가 일치하지 않습니다.";
	}else if(passwd == repasswd){
		pw_msg.style.display = "inline";
		pw_msg.style.color = "#A5C440";
		pw_msg.innerHTML = "비밀번호가 일치합니다.";
	}
}

//비밀번호 유효성 체크
function fnCheckPassword()
{
	var upw = document.joinForm.member_passwd.value;
	var pw_msg = document.getElementById('pw_msg');
	var chk_num = upw.search(/[0-9]/g); 
    var chk_eng = upw.search(/[a-z]/ig);
	
    if(!/^[a-zA-Z0-9]{6,20}$/.test(upw)) { 
    	pw_msg.style.display = "inline";
    	pw_msg.style.color = "red";
        pw_msg.innerHTML = "비밀번호는 숫자와 영문자 조합으로 6~20자리를 사용해야 합니다."; 
    }else if(chk_num < 0 || chk_eng < 0) { 
    	pw_msg.style.display = "inline";
    	pw_msg.style.color = "red";
    	pw_msg.innerHTML = "비밀번호는 숫자와 영문자를 혼용하여야 합니다."; 
    }else {
    	pw_msg.style.display = "inline";
    	pw_msg.style.color = "#A5C440";
    	pw_msg.innerHTML = "안전한 비밀번호입니다.";
    }
}

//전화번호 유효성 체크
function fnCheckTel(){
	var tel = document.joinForm.member_tel.value;
	if(/^[0-9]+$/.test(tel) == false){
		alert("전화번호는 숫자만 입력가능합니다.");
	}
}

//생년월일 구하기
function birthJoin(){
	var year = document.getElementById('year').value;
	var month = document.getElementById('month').value;
	var day = document.getElementById('day').value;
	var birth = year + month + day;
	document.getElementById('birth_value').value = birth;
}

//월 CSS
function monthCss(){
	var month = document.getElementById('month');
	if(month.value == 0){
		month.style.color = "#9d9d9d";
	}else {
		month.style.color = "black";
	}
}

//마지막 체크함수
function lastCheck(){
	//입력되지 않은값을 체크하기 위한 변수
	var id = document.joinForm.member_id.value;
	var passwd = document.joinForm.member_passwd.value;
	var name = document.joinForm.member_name.value;
	var gender = document.joinForm.member_gender.value;
	var tel = document.joinForm.member_tel.value;
	var address = document.joinForm.member_address.value;
	var birth = document.joinForm.member_birth.value;
	
	//잘못된 값을 체크하기 위한 변수
	if(id == "" || passwd == "" || name == "" || gender == "" || tel == "" || address == "" || birth == ""){
		alert("입력되지 않은 값이 있습니다.");
	}else if(document.getElementById('id_msg').style.color == "red") {
		alert("아이디를 다시 확인해주세요.");
	}else if(document.getElementById('pw_msg').style.color == "red") {
		alert("비밀번호를 다시 확인해주세요.");
	}else{
		alert("BOBBOX의 회원이 되신것을 축하드립니다.");
		document.joinForm.submit();
	}
	
}