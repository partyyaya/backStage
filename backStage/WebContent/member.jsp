<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <!--設寬度為硬體寬的一倍( initial-scale=1)-->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <!--設最大寬度為一倍,使用者不可用2指拉大(user-scalable=no)-->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"></script>
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="shortcut icon" href="img/logo2.png">
<title>樂活之旅</title>
<style>
.list-group-item{
    background-color:#000;
	border:none;
}
.list-group{	
	padding:0px;
	height:100%;
	text-align:center;
	 background-color:#000;
	 margin-bottom:0px;
	 border: 1px solid rgba(0, 0, 0,0.7);
}

#gettime{
	color:#ccc;
}

.list-group a{	
	color:#CCC;
}

#tablecontent{
	border: 1px solid rgba(0, 0, 0,0.4);
	border-right-width:0px;
	height:100%;
	text-align:center;
}

#logout{
	color:#000;
}

#logout:hover{
		color:#800000;
}
</style>
<script>
function showTime(){
		var timeSpan = document.getElementById("time");
		var date  = new Date().toLocaleString();
		timeSpan.innerHTML = date.fontcolor("lightblue");
		window.setTimeout(showTime,1000);
}
</script>
</head>
<body onLoad="showTime()">
<%
	String user=(String)session.getAttribute("user");
	
%>
<div class="container-filed">
	<div class="row">
        <div class="col-xs-12">
        	<div class="col-xs-4">
        		<img src="img/logo2.png" height="50" width="120">
        	</div>
            <div class="col-xs-5">
        	</div>
            <div class="col-xs-3" style="text-align:center; padding-top:15px;">
            <span>安安,<%=user%> | <a id="logout" href="logOut">登出</a></span>
        	</div>
        </div>
        <div class="col-xs-12" style="height:700px">
        	<div class="list-group col-xs-2">
        		<a href="#" class="list-group-item ">會員管理</a>
                <a href="#" class="list-group-item ">權限管理</a>
				<a href="#" class="list-group-item ">商品管理</a>
				<a href="#" class="list-group-item ">修改帳密</a><br/><br/>	
            	<div id="gettime" style="text-align:center;">現在時間<br/><span id="time"></span></div>
        	</div>
            <div class="col-xs-10" id="tablecontent">
        	
        	</div>
        </div>
	</div>
</div>
</body>
</html>