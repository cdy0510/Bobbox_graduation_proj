//전화번호 유효성 체크
function fnCheckTel(){
	var tel = document.supplierForm.supplier_tel.value;
	if(/^[0-9]+$/.test(tel) == false){
		alert("전화번호는 숫자만 입력가능합니다.");
	}
}

function fnCheckTel_up(){
	var tel = document.updateSupplierForm.supplier_tel.value;
	if(/^[0-9]+$/.test(tel) == false){
		alert("전화번호는 숫자만 입력가능합니다.");
	}
}


//마지막 체크함수
function lastCheck(){
	//입력되지 않은값을 체크하기 위한 변수
	var name = document.supplierForm.supplier_name.value;
	var tel = document.supplierForm.supplier_tel.value;
	var address = document.supplierForm.supplier_address.value;
	var mail = document.supplierForm.supplier_mail.value;
	var bank = document.supplierForm.supplier_bank.value;
	var account = document.supplierForm.supplier_account_data.value;
	
	//잘못된 값을 체크하기 위한 변수
	if(name == "" || mail == "" || tel == "" || address == "" || bank == "" || account == ""){
		alert("입력되지 않은 값이 있습니다.");
	}else{
		alert("공급업체 등록 완료.");
		document.supplierForm.submit();
	}
	
}