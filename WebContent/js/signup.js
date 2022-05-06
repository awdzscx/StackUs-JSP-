function signUpCheck(){
		var frm = document.resfrm;
		
		if(frm.MEM_NAME.value.length < 1){
			alert("이름을 입력해주세요");
			return;
		}

		if(frm.MEM_EMAIL.value.length < 1){
			alert("EMAIL을 입력해주세요");
			return;
		}

		if(frm.MEM_ID.value.length < 1){
			alert("ID를 입력해주세요");
			return;
		}

		if(frm.MEM_PW.value.length < 1){
			alert("비밀번호를 입력해주세요");
			return;
		}
	
		if(frm.MEM_PW.value != frm.pwcheck.value){
			alert("비밀번호가 틀립니다");
			return;
		}
		
		if(frm.MEM_BIRTH.value.length < 10){
			alert("생일을 입력해주세요");
			return;
		}
		
		frm.submit();
}
