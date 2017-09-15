<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*,java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <!--設寬度為硬體寬的一倍( initial-scale=1)-->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <!--設最大寬度為一倍,使用者不可用2指拉大(user-scalable=no)-->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


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

th,td{
	text-align:center;
}

input{
	text-align:center;
	border-width:0px;
}

.switch {height:28px; }
</style>

<script >

function showTime(){
		var timeSpan = document.getElementById("time");
		var date  = new Date().toLocaleString();
		timeSpan.innerHTML = date.fontcolor("lightblue");
		window.setTimeout(showTime,1000);
}

function doubleCheck(){
	var passwd = document.getElementById("newPasswd").value;
	var ckpasswd = document.getElementById("cknewPasswd").value;
	var spanNode = document.getElementById("ckId");
	if(passwd == ckpasswd){
		//符合规则
		spanNode.innerHTML = "✔ ok".fontcolor("green");
		return true;
	}else{
		//不符合规则
		spanNode.innerHTML = "請重新確認".fontcolor("red");		
		return false;
	}
}

function checkPass(){
	var inputNode = document.getElementById("newPasswd");
	var spanNode = document.getElementById("passwdId");	
	var content  = inputNode.value;
	var reg =/^[a-z0-9]{1,20}$/i;	
	if(reg.test(content)){
		//符合规则
		spanNode.innerHTML = "✔ ok".fontcolor("green");
		
		return true;
	}else{
		//不符合规则
		spanNode.innerHTML ="請重新輸入".fontcolor("red");		
		return false;
	}	
}

function checkAll(){
	var passwd = checkPass();
	var ck = doubleCheck();
	if(passwd && ck){
		return true;
	}	
		return false;
}

</script>

</head>

<body onLoad="showTime()">
<%
	String user=(String)session.getAttribute("user");
	if(user==null){
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}
	Properties prop = new Properties();
	prop.setProperty("user", "root");
	prop.setProperty("password", "root");
	String sql = "SELECT user,passwd,authority FROM manager WHERE user= '"+user+"'";
	System.out.println(sql);
	try {			
		Class.forName("com.mysql.jdbc.Driver");		
	} catch (Exception e) {
		System.out.println(e);
	}		
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
            安安 ,<span style="color:blue;font-size:13px"> <%=user%>  |  <a id="logout" href="logOut">登出</a></span>
        	</div>
        </div>
        <div class="col-xs-12" style="height:100vh">
        	<div class="list-group col-xs-2">
        		<a href="member.jsp" class="list-group-item ">會員管理</a>              
				<a href="gift.jsp" class="list-group-item ">商品管理</a>
				<a href="manager.jsp" class="list-group-item ">權限管理</a>
				<a href="change.jsp" class="list-group-item ">修改帳密</a><br/><br/>	
            	<div id="gettime" style="text-align:center;">現在時間<br/><span id="time"></span></div>
        	</div>
            <div class="col-xs-10" id="tablecontent" style="overflow-y:scroll; SCROLLBAR-FACE-COLOR: #c2d3fc;">
            <%
            try (
            		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/attractions",prop);
            		PreparedStatement pstmt=conn.prepareStatement(sql);				
            		)
            	{					
            		ResultSet rs = pstmt.executeQuery();
            	%> 
            	<div class="col-xs-12" style="font-size:23px;font-weight:bold;text-align:left;">帳號管理</div><br/>
				    <br/>
				    <%		
					if(rs.next()) {
				    %>
				<form class="col-sm-5 form-horizontal" action="changeData" method='post' onsubmit="return checkAll();"  style="border-radius: 4px;height:450px;border: 2px solid black;background-color: rgba(0,0,0,0.3);">
						<br/><br/><br/>
	<div class="form-group" style="margin-top:2px">
	<label for="user" class="col-sm-3 control-label" style="color:black;font-weight:bold;font-size:15px;">帳號 : </label>
    	<div class="col-sm-6">
      		<input type="text"  class="form-control" value="<%=rs.getString("user") %>" readonly />
    	</div>
    </div>
    <div class="form-group" style="margin-top:2px">
	<label for="user" class="col-sm-3 control-label" style="color:black;font-weight:bold;font-size:15px;">密碼 : </label>
    	<div class="col-sm-6">
      		<input type="text"  class="form-control" value="<%=rs.getString("passwd") %>" readonly />
    	</div>
    </div>
	<div class="form-group" style="margin-top:2px">
	<label for="passwd" class="col-sm-3 control-label" style="color:black;font-weight:bold;font-size:15px;">新密碼 :</label>
    	<div class="col-sm-6">
      		<input type="password" name="passwd" id="newPasswd" class="form-control" placeholder="設置新密碼(英文或數字)" onblur="checkPass()">
    	</div>
    	<span id="passwdId" class="col-sm-3" style="padding-top:7px;"></span>
    </div>
    <div class="form-group" style="margin-top:2px">
	<label for="ckpasswd" class="col-sm-3 control-label" style="color:black;font-weight:bold;font-size:15px;">確認密碼 : </label>
    	<div class="col-sm-6">
      		<input type="password" class="form-control" id="cknewPasswd" placeholder="確認新密碼" onblur="doubleCheck()">
    	</div>
    	<span id="ckId" class="col-sm-3" style="padding-top:7px;"></span>
    </div>
    <div class="form-group" style="margin-top:2px">
	<label for="user" class="col-sm-3 control-label" style="color:black;font-weight:bold;font-size:15px;">權力等級 : </label>
    	<div class="col-sm-6">
      		<input type="text"  class="form-control" value="<%=rs.getString("authority") %>" readonly />
    	</div>
    </div>
    <div class="form-group">
		<div class="col-sm-offset-3 col-sm-6">
			<input type="submit" class="btn btn-default" value="確定更改"/>
		</div>
	</div>
</form>	
					  <% 
				      }
				   }catch (Exception e){
		           		System.out.println(e);
		           }
			           %>
        	</div>
        </div>
	</div>
</div>
</body>
</html>

