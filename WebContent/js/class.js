function classOk(){
	var frm = document.clafrm;
	
	if(frm.CLA_NAME.value.length < 1){
		alert("클래스 이름을 입력하세요.");
		return;
	}
	if(frm.CLA_INTRO.value.length < 1){
		alert("클래스 설명을 입력하세요.");
		return;
	}
	
	frm.submit();
}