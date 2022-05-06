function licenseOk(){
	var examArray = ["가스기사","정보처리기사"];

	for(var i=0; i<examArray.length;i++){
		if(licenseForm.license_name.value == examArray[i]){
			alert("올바른 입력입니다.");
			i = i+1;
			location.href="licenseOk.jsp?license_name="+licenseForm.license_name.value+"&mem_id="+licenseForm.mem_id.value+"&license_code="+i;
			return;
		}
	}
		alert("잘못된 과목이름입니다.");
		return;
		
}