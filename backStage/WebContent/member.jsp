<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*,java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <!--設寬度為硬體寬的一倍( initial-scale=1)-->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

.loading{ 
 background:#FC0606; /*設置進度條的顏色*/ 
 height:2px; /*設置進度條的高度*/ 
 position:fixed; /*設定進度條跟隨屏幕滾動*/ 
 top:0; /*將進度條固定在頁面頂部*/ 
 z-index:99999; /*提高進度條的優先層級，避免被其他層遮擋*/ 
} 
</style>
<script>
function showTime(){
		var timeSpan = document.getElementById("time");
		var date  = new Date().toLocaleString();
		timeSpan.innerHTML = date.fontcolor("lightblue");
		window.setTimeout(showTime,1000);
}

function chpasswd(e,i){
	$.ajaxSetup({
		async: false
	});
	var passwd = e.value;
	//var oldpasswd=e.defaultValue;
	$.get("changeByAjax?passwd="+passwd+"&user="+i,function(data,status){					
	});
}
function chtel(e,i){
	$.ajaxSetup({
		async: false
	});
	var tel = e.value;
	//var oldtel=e.defaultValue;
	$.get("changeByAjax?tel="+tel+"&user="+i,function(data,status){					
	});
}
function chemail(e,i){
	$.ajaxSetup({
		async: false
	});
	var email = e.value;
	//var oldemail=e.defaultValue;
	$.get("changeByAjax?email="+email+"&user="+i,function(data,status){					
	});
}

function del(btn,i){	
	$.get("delByAjax?user="+i,function(data,status){					
	});
	var row = btn.parentNode.parentNode;
	row.parentNode.removeChild(row);
}

function inquire(e){
	var name = e.value;
	window.location.replace("member.jsp?name="+name);
}
</script>
</head>
<body onLoad="showTime()">
<div class="loading"></div>
<%
	String user=(String)session.getAttribute("user");
	String authority=(String)session.getAttribute("authority");
	int author=Integer.parseInt(authority);
	
	String name=(String)request.getParameter("name");
	if(user==null){
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}
	String where = name ==null?"":("WHERE user like '%"+name+"%'");
	Properties prop = new Properties();
	prop.setProperty("user", "root");
	prop.setProperty("password", "root");
	int i=1;
	String sql = "SELECT user,passwd,tel,email FROM member "+where;
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
            歡迎 ,<span style="color:blue;font-size:13px"> <%=user%>&nbsp;&nbsp;&nbsp;<button style="margin-bottom:3px;" type="button" class="btn btn-danger" onclick="javascript:location.href='logOut'" >登出</button></span>
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
        	
        	<script type="text/javascript"> 
			 $('.loading').animate({'width':'40%'},100); 
			 //第一個進度節點 
			</script> 
			
            <div class="col-xs-10" id="tablecontent" style="overflow-y:scroll; SCROLLBAR-FACE-COLOR: #c2d3fc;">
            <%
            try (
            		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/attractions",prop);
            		PreparedStatement pstmt=conn.prepareStatement(sql);				
            		)
            	{					
            		ResultSet rs = pstmt.executeQuery();
            	%> 
            	<div class="col-xs-12" style="font-size:23px;font-weight:bold;text-align:left;">會員管理</div><br/><br/>			
				<div class="col-xs-12" style="font-size:15px;font-weight:bold;text-align:left;">查詢會員名稱:<input type="text" placeholder="請輸入查詢帳號" onchange="inquire(this)"/></div>   		
				
				<script type="text/javascript"> 
				 $('.loading').animate({'width':'60%'},100); 
				</script> 
				
				<table class="table table-bordered table-hover">					            					
				    <thead >
				      <tr>
				      	 <th>編號</th>
				         <th>帳號</th>
				         <th>密碼</th>
				         <th>電話</th>
				         <th>信箱</th>
				         <%if(author==2){%><th>刪除</th><%} %>
				      </tr>
				    </thead>
				    <tbody>
				    <%
					while(rs.next()) { 					
				    %>
				      <tr>
				      
				         <td><%=i%></td>
				         <td><%=rs.getString("user") %></td>
				         <td><input type="text"  value="<%=rs.getString("passwd") %>" <%if(author<1){%>readonly<%} %> onchange="chpasswd(this,'<%=rs.getString("user")%>')"/></td>
				         <td><input type="text"  value="<%=rs.getString("tel") %>" <%if(author<1){%>readonly<%} %> onchange="chtel(this,'<%=rs.getString("user")%>')"/></td>
				         <td><input type="text"  value="<%=rs.getString("email")%>" <%if(author<1){%>readonly<%} %> onchange="chemail(this,'<%=rs.getString("user")%>')"/></td>
				         <%if(author==2){%><td><button type="button" class="btn btn-danger" id="delete" onClick="del(this,'<%=rs.getString("user")%>')">刪除</button></td><%} %>
				      </tr>
					  <% 
					  i++;
				      }
				   }catch (Exception e){
		           		System.out.println(e);
		           }
			           %>
		           </tbody>
				</table>
				
				<script type="text/javascript"> 
				 $('.loading').animate({'width':'80%'},100); 
				//第二個進度節點 
				</script> 
				
				<div style="font-size:10px;font-weight:bold;text-align:center;">總共符合:<%=i-1%>筆資料</div>
        	</div>
        </div>
	</div>
</div>
</body>
	<script type="text/javascript"> 
					 $('.loading').animate({'width':'100%'},100); 
					 $(document).ready(function(){ 
						 $('.loading').fadeOut();  
						});
	</script> 
	
</html>

