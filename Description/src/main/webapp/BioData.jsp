<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="Model.BioDAO"%>
<%@page import="Model.ObjDAO"%>
<%@page import="Model.BioVO"%>
<%@page import="Model.ObjVO"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IntFlow - BioDataService</title>
</head>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<style>

* {
	font-size : 16px;
	margin: 0;
	padding: 0;
}

#wrap {
	width: 100%;
}

#logo{ 
	width : 150px;
	height : 100px;
	text-align : center;
	margin : 0px auto;
	}

#frame{
	background-color : #f1f3f4;
}

#nav {
 	width: 100%;
	height: 100px;
	background: #202124;
}

#stream {
	float: left;
	width: 60%;
	height: 700px;
	margin-bottom:1.5%;
/* 	border-radius : 7px 7px 0 0;
	border : 1px solid #9aa0a6;; */
}

#camList>ul>li {
	list-style: none;
}

#camList {
	float: left;
	width: 17%;
	height: 700px;
	margin-left: 2%;
	font-size : 1.6rem;
	margin-bottom:1.5%;
	margin-top : 1%;
/* 	border-radius : 7px 7px 0 0;
	border : 1px solid #9aa0a6; */

}

#objList {
	float: right;
	width: 17%;
	height: 700px;
	font-size : 1.6rem;
	margin-bottom:1.5%;
	margin-right : 2%;
	margin-top : 1%;
/* 	border-radius : 7px 7px 0 0;
	border : 1px solid #9aa0a6; */	
}

#graph {
	clear: both;
	width: 100%;
	height: 200px;
	margin-top:2%;
	border-radius : 7px 7px 0 0;
	border : 1px solid #9aa0a6;
}

#framecss{
	width : 39%;
	height : 39%;
	border-radius : 7px 7px 0 0;
	border : 1px solid #9aa0a6;
	display : inline-block;
	margin : 3% 4%;
	padding : 1%;
}
#camList_div {
	text-align: center;
}

#objList_div {
	text-align: center;
}

#camList_div>button {
	border: none;
	background: none;
	margin: 10% 0;
	font-size: 1.6rem;
}
.clicked{
	color : gold;
	border : 1px;
}

#objList_div>button {
	border: none;
	background: none;
	margin: 10% 0;
	font-size: 1.6rem;
}
/* 화면 너비 0 ~ 1200px */
@media ( max-width : 1220px) {
	#stream {
		width: 100%;
		margin-bottom: 4%;
	}
	#camList {
		width: 43%;
	}
	#objList {
		width: 43%;
	}
	#graph {
		width: 100%;
	}
	#objList_div>button {
	border: none;
	background: none;
	margin: 10% 0;
	font-size: 1rem;
	}
	#camList_div>button {
	border: none;
	background: none;
	margin: 10% 0;
	font-size: 1rem;
	}
}
/* 화면 너비 0 ~ 768px */
@media ( max-width : 768px) {
	#nav{
		width : 100%;
		height : auto;
		position : relative;
	}
	#stream {
		width: 100%;
		height: 300px;
   		margin-bottom: 4%;
	}
	#camList {
		width: 45%;
		height: 200px;
	}
	#objList {
		width: 45%;
		height: 200px;
	}
	#objList_div>button {
	border: none;
	background: none;
	margin: 3% 0;
	font-size: 1rem;
	}
	#camList_div>button {
	border: none;
	background: none;
	margin: 5% 0;
	font-size: 1rem;
	}
}
</style>
<body>
<%
request.setCharacterEncoding("utf-8");

ObjVO ovo = new ObjVO();
BioVO vo = new BioVO();
BioDAO dao = new BioDAO();
ObjDAO odao = new ObjDAO();
ObjVO o_vo = odao.Obj_selectONE("Object_id");
String object_id = request.getParameter("object_id");

ArrayList<BioVO> bioCamList = dao.bioCamList();
ArrayList<ObjVO> bioObjList = odao.bioObjList();

%>
	<div id="wrap">
		<div id="nav">
		<div id="logo">
		<img src="./images/logo.png" width="100%" height="auto" style="margin-top:15%;">
		</div>
		</div>

		<section id="frame">
		
			<div id="time">
			<h1 id="time" style="font-color: #f1f3f4; text-align: center; background: #f1f3f4; border:1px solid #bdc1c6; font-size:2rem; padding:1.5%;">00:00</h1>
			</div>
			
			<div id="stream">
			<div id="framecss"><iframe id="stream_id" src="https://www.youtube.com/embed/EUZ8YUxhMNM" title="streaming" width="100%" height="100%" style=" float : left;"></iframe></div>	
			<div id="framecss"><iframe id="stream_id" src="https://www.youtube.com/embed/W9Ot_I3pb20" title="streaming" width="100%" height="100%" style="float : left;"></iframe></div>	
			<div id="framecss"><iframe id="stream_id" src="https://www.youtube.com/embed/N9oz7MOS5tI" title="streaming" width="100%" height="100%" style="float : right;"></iframe></div>	
			<div id="framecss" style="display:inline-block; float:right; border:none;"><img src="./images/logo.png" width="100%" height="40%" style="margin-top:15%;"></div>
			</div>

			<div id="camList">
				<h2>카메라 목록</h2>
				<div id="camList_div">
					<button type="button" class="camList">전체 카메라</button>
					<br>
					<%
					for (int i = 0; i < bioCamList.size(); i++) {
					%>
					<button type="button" class="camList"><%=bioCamList.get(i).getCamera_id()%>번 카메라</button>
					<br>
					<%
					}
					%>
				</div>
			</div>

			<div id="objList">
				<h2>개체 목록</h2>
				<div id="objList_div">
					<button type="button" class="objList">전체 개체</button>
					<br>
					<%
					for (int i = 0; i < bioObjList.size(); i++) {
					%>
					<button type="button" class="objList"><%=bioObjList.get(i).getObject_id()%>번 개체</button>
					<br>
					<%} %>
				</div>
			</div>

			<div id="graph">
			<div><p style="font-size: 18px; padding: 10px; font-weight: 600; font-weight: 500; ">
      </p></div>
      <div>
         <canvas id="curve_chart">
      </canvas>
      </div>
      </div>

		</section>
	</div>
</body>
<script>
   $(".camList").on('click', function(){
      var camNum = $(this).text();
      console.log(camNum);
      if(camNum=='1번 카메라'){
         var str="<div id='stream'><iframe src='https://www.youtube.com/embed/EUZ8YUxhMNM' title='streaming' width='90%' height='600px' style='position: relative; margin: 5%;'></iframe></div>"
         $("#stream").replaceWith(str);
      }else if(camNum=='2번 카메라'){
         var str="<div id='stream'><iframe src='https://www.youtube.com/embed/W9Ot_I3pb20' title='streaming' width='90%' height='600px' style='position: relative; margin: 5%;'></iframe></div>"
         $("#stream").replaceWith(str);
      }else if(camNum=='3번 카메라'){
         var str="<div id='stream'><iframe src='https://www.youtube.com/embed/N9oz7MOS5tI' title='streaming' width='90%' height='600px' style='position: relative; margin: 5%;'></iframe></div>"
         $("#stream").replaceWith(str);
      }else if(camNum=='전체 카메라'){
         var str="<div id='stream'><div id='framecss'><iframe src='https://www.youtube.com/embed/EUZ8YUxhMNM' title='streaming' width='100%' height='100%' style=' float : left;'></iframe></div>"+
            "<div id='framecss'><iframe src='https://www.youtube.com/embed/W9Ot_I3pb20' title='streaming' width='100%' height='100%' style=' float : left;'></iframe></div>"+
            "<div id='framecss'><iframe src='https://www.youtube.com/embed/N9oz7MOS5tI' title='streaming' width='100%' height='100%' style=' float : right;'></iframe></div>"+
            "<div id='framecss' style='display:inline-block;'></div></div>"
            $("#stream").replaceWith(str);
      }
   });
</script>
<!-- <script>
	$(".objList").on('click', function(){
		var objNum = $(this).text();
		console.log(objNum);
 		if(objNum=='1번 개체'){
			
		} 
	});
</script> -->

<script>
var camList = document.getElementsByClassName("camList");

function handleClick(event){
	console.log(event.target);
	console.log(event.target.classList);
	
	if(event.target.classList[1] === "clicked"){
		event.target.classList.remove("clicked");
	}else{
		for( var i = 0; i < camList.length; i++){
			camList[i].classList.remove("clicked");
		}
		event.target.classList.add("clicked");
	}
}
function init(){
	for (var i = 0; i<camList.length; i++){
		camList[i].addEventListener("click",handleClick);
	}
}
init();
</script>
<script>
var objList = document.getElementsByClassName("objList");

function handleClick(event){
	console.log(event.target);
	console.log(event.target.classList);
	
	if(event.target.classList[1] === "clicked"){
		event.target.classList.remove("clicked");
	}else{
		for( var i = 0; i < objList.length; i++){
			objList[i].classList.remove("clicked");
		}
		event.target.classList.add("clicked");
	}
}
function init(){
	for (var i = 0; i<objList.length; i++){
		objList[i].addEventListener("click",handleClick);
	}
}
init();
</script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
$(function(){
	
	$(".objList").on("click",getData);
});

	function getData(){
	
$.ajax({         
    url : 'AjaxChart',
    type : 'get',
    data : {'object_id' : '<%=ovo.getObject_id()%>'},
    dataType : 'json',
    success : function(res){
    let labels = res.reverse().map(item => item.current_dt);  	
    let values = res.map(item => item.drinking);
/*     let tvalues = values.reverse().map(item => item.drinking); */
    console.log(labels);
    const data = {
         labels: labels,
         datasets: [{ 
           data: values,
          label:"음수량",
           fill: false,
          borderColor: 'red',
          borderWidth: 2,
          tension: 0.1,            
         }]
    };
    const config = {
         type: 'line',
         data: data
    };
    
    const myChart = new Chart(
        document.getElementById('curve_chart'),
        config
      );
    },
    error : function(){
       alert('차트 로딩 실패');
    }
    
 });
}
</script>
<script src="./js/Clock.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
   
   function chart(dataArray) {
      google.charts.load('current', {
         'packages' : [ 'corechart' ]
      });
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
         var data = google.visualization.arrayToDataTable(dataArray);
         var options = {
            title : '음수량 변화 그래프',
            curveType : 'function',
            legend : {
            position : 'bottom'
            }
         };
         var chart = new google.visualization.LineChart(document
               .getElementById('curve_chart'));
         chart.draw(data, options);
         }
      }
   </script>
</html>