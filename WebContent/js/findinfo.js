function id_search(){
		var frm = document.idfind;
		
		if(frm.MEM_NAME.value.length < 1){
			alert("이름을 입력해주세요");
			return;
		}
		
		if(frm.MEM_EMAIL.value.length < 1){
			alert("E-mail을 입력해주세요");
			return;
		}
		
		frm.method = "post";
		frm.action = "mem_findIdResult.jsp"; //넘어간 화면
		frm.submit();
}


function pw_search(){
		var frm = document.pwfind;
		
		if(frm.MEM_ID.value.length < 1){
			alert("아이디를 입력해주세요");
			return;
		}
		
		if(frm.MEM_EMAIL.value.length < 1){
			alert("E-mail을 입력해주세요");
			return;
		}
		
		frm.method = "post";
		frm.action = "mem_findPwResult.jsp"; //넘어간 화면
		frm.submit();
}

function tid_search(){
		var frm = document.tidfind;
		
		if(frm.TEA_NAME.value.length < 1){
			alert("이름을 입력해주세요");
			return;
		}
		
		if(frm.TEA_EMAIL.value.length < 1){
			alert("E-mail을 입력해주세요");
			return;
		}
		
		
		frm.submit();
}

function tpw_search(){
		var frm = document.tpwfind;
		
		if(frm.TEA_ID.value.length < 1){
			alert("아이디를 입력해주세요");
			return;
		}
		
		if(frm.TEA_EMAIL.value.length < 1){
			alert("E-mail을 입력해주세요");
			return;
		}
		
		
		frm.submit();
}