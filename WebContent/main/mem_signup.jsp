<%@page import="nl.captcha.Captcha"%>
<%@page import="member.MemberBean"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
String ctx = request.getContextPath();	//콘텍스트명 얻어오기.

response.setHeader("Pragma-directive", "no-cache");
response.setHeader("Cache-directive", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache");
response.setDateHeader("Expires",0); 
%>
<jsp:useBean id="member" class="member.MemberBean" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="member"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Stack Us</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="../img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="../lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="../lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="../css/style.css" rel="stylesheet">
    <!-- chapcha -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Cache-Control" content="no-cache" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Imagetoolbar" content="no" />
	<script type="text/javascript"src="//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <script type="text/javascript">
    
    /* 생일 입력시 자동으로 yyyy-mm-dd 형식으로  입력*/
    function inputYMDNumber(obj) {													
		if(event.keyCode != 8) {
            if(obj.value.replace(/[0-9 \-]/g, "").length == 0) {
                let number = obj.value.replace(/[^0-9]/g,"");
                let ymd = "";
                if(number.length < 4) {
                    return number;
                } else if(number.length < 6){
                    ymd += number.substr(0, 4);
                    ymd += "-";
                    ymd += number.substr(4);
                } else {
                    ymd += number.substr(0, 4);
                    ymd += "-";
                    ymd += number.substr(4, 2);
                    ymd += "-";
                    ymd += number.substr(6);
                }
                obj.value = ymd;
            } else {
                alert("숫자 이외의 값은 입력하실 수 없습니다.");
                obj.value = obj.value.replace(/[^0-9 ^\-]/g,"");
                return false;
            }
        } else {
            return false;
        }
    }
    /* 캡챠 */
	var rand;

	//캡차 오디오 요청
	function audioCaptcha() {
		$.ajax({
			url: '../captcha/CaptChaAudio.jsp',
			type: 'POST',
			dataType: 'text',
			data: 'rand=' + rand + '&ans=y',
			async: false,		
			success: function(resp) {
				var uAgent = navigator.userAgent;
				var soundUrl = 'captcha/CaptChaAudio.jsp?rand=' + resp + '&ans=' + resp;
				//console.log(soundUrl);
				if (uAgent.indexOf('Trident') > -1 || uAgent.indexOf('MSIE') > -1) {
					winPlayer(soundUrl+'&agent=msie');
				} else if (!!document.createElement('audio').canPlayType) {
					try { new Audio(soundUrl).play(); } catch(e) { winPlayer(soundUrl); }
				} else window.open(soundUrl, '', 'width=1,height=1');
			}
		});
	}
	function winPlayer(objUrl) {
		$('#audiocatpch').html(' <bgsound src="' + objUrl + '">');
	}

	//캡차 이미지 요청 (캐쉬문제로 인해 이미지가 변경되지 않을수있으므로 요청시마다 랜덤숫자를 생성하여 요청)
	function changeCaptcha() {
		rand = Math.random();
		$('#catpcha').html('<img src="<%=ctx%>/captcha/CaptChaImg.jsp?rand=' + rand + '"/>');
	}

	$(document).ready(function() {
		
		changeCaptcha(); //캡차 이미지 요청
		
		$('#reLoad').click(function(){ changeCaptcha(); }); //새로고침버튼에 클릭이벤트 등록
		$('#soundOn').click(function(){ audioCaptcha(); });	//음성듣기버튼에 클릭이벤트 등록
		$('#capok').hide();
		//확인 버튼 클릭시
		$('#frmSubmit').click(function(){
			if ( !$('#answer').val() ) {
				alert('이미지에 보이는 숫자 또는 스피커를 통해 들리는 숫자를 입력해 주세요.');
			} else {
				$.ajax({
					url: '../captcha/captchaSubmit.jsp',
					type: 'POST',
					dataType: 'text',
					data: 'answer=' + $('#answer').val(),
					async: false,		
					success: function(resp) {
						alert(resp);
						$('#reLoad').click();
						$('#answer').val('');
						if (resp == "입력값이 일치합니다.") {
							var r = true;
							$('#capok').show();
							$('#reLoad').hide();
							$('#answer').hide();
							$('#frmSubmit').hide();
							$('#soundOn').hide();
							$('#reLoad').hide();
							$('#catpcha').hide();
						}
					}
				});
			}
		});
	});
    </script>
</head>

<body>
    <div class="container-xxl position-relative bg-white d-flex p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->

        <!-- Sign Up Start -->
        <div class="container-fluid">
            <div class="row h-100 align-items-center justify-content-center" style="min-height: 100vh;">
                <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
                    <div class="bg-light rounded p-4 p-sm-5 my-4 mx-3">
                    	<form action="../main/mem_resiOK.jsp" name="resfrm" method="post">
                        <div class="d-flex align-items-center justify-content-between mb-3">
                            <a href="../main/main.jsp" class="">
                                <h3 class="text-primary"><i class="fa fa-hashtag me-2"></i>STACK US</h3>
                            </a>
                            <p>Sign Up</p>
                        </div>
                        <div class="bg-light rounded h-100" style="margin-bottom: 15px">
                            <div class="btn-group" role="group">
                                <input type="radio" class="btn-check" value="3" name="MEM_TYPE" id="btnradio1" autocomplete="off"
                                    checked>
                                <label class="btn btn-outline-primary" for="btnradio1">Student</label>
                                <input type="radio" class="btn-check" value="2" name="MEM_TYPE" id="btnradio2" autocomplete="off">
                                <label class="btn btn-outline-primary" for="btnradio2">Teacher</label>
                            </div>
                        </div>    
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" name="MEM_NAME" id="floatingText" placeholder="jhondoe" maxlength="30" onkeyup="enterkey()">
                            <label for="">Username</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="email" class="form-control" name="MEM_EMAIL" id="floatingInput" placeholder="name@example.com" maxlength="45" onkeyup="enterkey()">
                            <label for="floatingInput">Email address</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" name="MEM_ID" id="floatingText" placeholder="jhondoe" maxlength="10" onkeyup="enterkey()">
                            <label for="">ID</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="password" class="form-control" name="MEM_PW" id="floatingPassword" placeholder="Password" maxlength="10" onkeyup="enterkey()">
                            <label for="floatingPassword">Password</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="password" class="form-control" name="pwcheck" id="floatingPassword" placeholder="Password" maxlength="10" onkeyup="enterkey()">
                            <label for="floatingPassword">PasswordCheck</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" name="MEM_BIRTH" id="floatingInput" placeholder="1999-01-01" oninput="inputYMDNumber(this)" maxlength="10" onkeyup="enterkey()">
                            <label for="floatingInput">Birth day</label>
                        </div>
                        <div class="form-floating mb-3" id="capdiv">
	                 	    <div id="catpcha"></div>
							<div id="audiocatpch" style="display: none;"></div>
	
							<input id="reLoad" class="btn btn-outline-primary" type="button" value="새로고침" />
							<input id="soundOn" class="btn btn-outline-primary m-2" type="button" value="음성듣기" />
                   			<i class="bi bi-check2 fs-4 m-2" style="color:#389dff; margin-left: 10%;" id="capok"></i>
							<br />
							<input type="text" id="answer" class="form-control-sm" name="answer" value="" onkeyup="enterkey2()"/>
							<input type="button" class="btn btn-outline-primary m-2" id="frmSubmit" value="확인" />
						</div>
                        <button type="button" onclick="signUpCheck()" id="btn" class="btn btn-primary py-3 w-100 mb-4">Sign Up</button>
                        <p class="text-center mb-0">Already have an Account? <a href="../main/mem_signin.jsp">Sign In</a></p>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- Sign Up End -->
    </div>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../lib/chart/chart.min.js"></script>
    <script src="../lib/easing/easing.min.js"></script>
    <script src="../lib/waypoints/waypoints.min.js"></script>
    <script src="../lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="../lib/tempusdominus/js/moment.min.js"></script>
    <script src="../lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="../lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script src="../js/main.js"></script>
    <script src="../js/signup.js"></script>
    <script>
	function enterkey() {
		if (window.event.keyCode == 13) {
			$('#btn').click();
	    }
	};
	
	function enterkey2() {
		if (window.event.keyCode == 13) {
			$('#frmSubmit').click();
	    }
	}
	</script>
</body>

</html>