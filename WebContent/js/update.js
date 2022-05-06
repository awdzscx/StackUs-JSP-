function signUpCheck(){
		var frm = document.editfrm;
		
		if(frm.MEM_NAME.value < 1){
			alert("이름을 입력해주세요");
			return;
		}

		if(frm.MEM_EMAIL.value < 1){
			alert("EMAIL을 입력해주세요");
			return;
		}

		if(frm.MEM_BIRTH.value < 1){
			alert("생일을 입력해주세요");
			return;
		}

		if(frm.MEM_PW.value < 1){
			alert("비밀번호를 입력해주세요");
			return;
		}

		
		if(frm.MEM_CONTENT.value < 1){
			alert("자기소개를 입력해주세요");
			return;
		}
		
		frm.submit();
}

function imgCheck(){
		var frm = document.imgfrm;
		
		if(frm.profimg.value.length < 1){
			alert("변경할 이미지가 선택되지 않았습니다");
			return;
		}

		
		frm.submit();
}

function deleteCheck(){
		var frm = document.delfrm;
		
		if(frm.mem_pw.value.length < 1){
			alert("비밀번호를 입력해주세요");
			return;
		}

		
		frm.submit();
}

function resCheck(){
		var frm = document.resfrm;
		
		if(frm.ex_name.value.length < 1){
			alert("시험명을 선택해주세요");
			return;
		}
		
		if(frm.res_date.value.length < 1){
			alert("날짜를 선택해주세요");
			return;
		}

		
		frm.submit();
}
