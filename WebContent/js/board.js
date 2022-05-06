function check_ok(){
	
	if(reg_frm.bo_title.value.length == 0){
		alert("제목을 써주세요.");
		reg_frm.b_title.focus();
		return;
	}
	
	if(reg_frm.bo_content.value.length == 0){
		alert("내용을 써주세요.");
		reg_frm.b_content.focus();
		return;
	}
	
	
	document.reg_frm.submit();
}

function delete_ok(){
	
	if(reg_frm.mem_pw.value.length == 0){
		alert("비밀번호를 입력해주세요.");
		reg_frm.b_title.focus();
		return;
	}
	
	document.reg_frm.submit();
}