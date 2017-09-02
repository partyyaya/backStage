<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--設寬度為硬體寬的一倍( initial-scale=1)-->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <!--設最大寬度為一倍,使用者不可用2指拉大(user-scalable=no)-->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"></script>
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
	body {
		background-image: url("img/bg.gif");
	}
</style>
<link rel="shortcut icon" href="img/logo2.png">
<title>樂活之旅</title>
</head>
<body>
<img src="img/logo.png" height="52" width="136" style="opacity:0.8">
<div class="container">
	<div class="row">
        <div class="col-sm-4"></div>
        <form class="col-sm-4 form-horizontal" action="loginMember"  method='post' style="margin-top:17%;border-radius: 4px;border: 2px solid rgba(95,95,107,0.5);background-color: rgba(52,52,59,0.7);">
            <div class="form-group">
            <label for="userName" class="col-sm-3 control-label" style="margin-top:2px;font-size:22px;color:black;">登入</label>    	  
            </div>
            <div class="form-group" style="margin-top:2px">
            <label for="user" class="col-sm-3 control-label" style="color:black;font-size:15px;">帳號:</label>
                <div class="col-sm-6">
                    <input type="text"  name="user" class="form-control"  placeholder="請輸入帳號">
                </div>
            </div>
            <div class="form-group" style="margin-top:2px">
            <label for="passwd" class="col-sm-3 control-label" style="color:black;font-size:15px;">密碼:</label>
                <div class="col-sm-6">
                    <input type="password" name="passwd"  class="form-control" placeholder="請輸入密碼" >
                </div>
                <span id="passwdId" class="col-sm-3" style="padding-top:7px;"></span>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-3 col-sm-7">
                    <input type="submit" class="btn btn-default" style="color:black;font-weight: 900;" value="登入"/>
                </div>
            </div>
        </form>	
	</div>
</div>

</body>
</html>