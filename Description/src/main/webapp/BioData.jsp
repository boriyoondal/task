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
<link rel="stylesheet" href="css/css.css">
</head>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<style>

/* 화면 너비 0 ~ 768px */
@media ( max-width : 768px) {
	#nav {
		width: 100%;
		height: auto;
		position: relative;
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
ArrayList<ObjVO> o_vo = odao.Obj_selectONE("camera_id");
String object_id = request.getParameter("object_id");
String camera_id = request.getParameter("camera_id");

ArrayList<BioVO> bioCamList = dao.bioCamList();
ArrayList<ObjVO> bioObjList = odao.bioObjList();

%>
	<div id="wrap">

		<!--로고 상부-->
		<div id="nav">
			<div id="logo">
				<a href="BioData.jsp"><img src="./images/logo.png" width="100%" height="auto" style="margin-top: 15%;"></a>
			</div>
		</div>
		<!--로고 상부 끝 -->

		<section id="frame">
			<!-- 시계 -->
			<div id="time">
				<h1 id="time"
					style="font-color: #f1f3f4; text-align: center; background: #f1f3f4; border: 1px solid #bdc1c6; font-size: 2rem; padding: 1.5%;">00:00</h1>
			</div>
			<!-- 시계 끝 -->

			<!-- 동영상 송출 부분 -->
			<div id="stream">
				<div id="framecss">
					<iframe id="stream_id"
						src="https://www.youtube.com/embed/EUZ8YUxhMNM" title="streaming"
						width="100%" height="100%" style="float: left;"></iframe>
				</div>
				<div id="framecss">
					<iframe id="stream_id"
						src="https://www.youtube.com/embed/W9Ot_I3pb20" title="streaming"
						width="100%" height="100%" style="float: left;"></iframe>
				</div>
				<div id="framecss">
					<iframe id="stream_id"
						src="https://www.youtube.com/embed/N9oz7MOS5tI" title="streaming"
						width="100%" height="100%" style="float: right;"></iframe>
				</div>
				<div id="framecss"
					style="display: inline-block; float: right; border: none;">
					<img src="./images/logo.png" width="100%" height="40%"
						style="margin-top: 15%; position:relative;">
				</div>
			</div>
			<!-- 동영상 송출 부분 끝 -->

			<div id="camList">
				<h2 style="text-align : center; margin-top:8%">카메라 목록</h2>
				<div id="camList_div">
					<button type="button" class="camList" value="all_cam">전체 카메라</button>
					<br>
					
					<%
					for (int i = 0; i < bioCamList.size(); i++) {
					%>
					<button type="button" class="camList" value="<%=bioCamList.get(i).getCamera_id()%>"><%=bioCamList.get(i).getCamera_id()%>번 카메라</button>
					<br>
					<%
					}
					%>

				</div>
			</div>

			<div id="objList">
				<h2 style="text-align : center; margin-top : 8%">개체 목록</h2>
				<div id="objList_div" style="display : none;">
					<button type="button" class="objList" value="all_obj">전체 개체</button>
					<br>
					<%
					for (int i = 0; i < bioObjList.size(); i++) {
					%>
					<button type="button" class="objList" value="<%=bioObjList.get(i).getObject_id()%>"><%=bioObjList.get(i).getObject_id()%>번 개체</button>
					<br>
					<%
					}
					%>

				</div>
			</div>
			<!-- 그래프 -->
			<div id="graph">
				<div>
					<canvas id="curve_chart" style="position: relative; width: 100%; height: 100%;"></canvas>
				</div>
			</div>
			<!-- 그래프 끝 -->
		</section>
	</div>
</body>


<script>
$('.camList').click(function(event){
	
		console.log('클릭 됨');
 		var camListval = event.target.value;
 		console.log(event.target.value);
 		console.log(camListval);
/* 	
 		if(camListval == 1){
 			
 		}else if(camListval == 2){
 			
 		}else if(camListval == 3){
 			
 		} */

	});
</script>
<!-- 시계열 데이터 ajax -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
   $.ajax({
        url : 'AjaxChart',
        type : 'get',
        dataType : 'json',
        success : function(res){
      	let labels = res.map(item => item.current_dt);
        let activity = res.map(item => item.activity);
        let feed = res.map(item => item.feed);
        let drinking = res.map(item => item.drinking);
      	console.log(drinking);

         const data = {
               labels: labels,
                 datasets: [{
                     data: activity,
                     label:"활동량",
                     fill: false,
                     borderColor: 'blue',
                     borderWidth: 2,
                     tension: 0.5,
                 },{ 
                     data: feed,
                     label:"취식량",
                     fill: false,
                     borderColor: 'red',
                     borderWidth: 2,
                     tension: 0.5,
                },{ 
                     data: drinking,
                     label:"음수량",
                     fill: false,
                     borderColor: 'green',
                     borderWidth: 2,
                     tension: 0.5,
                  }]
         };

      const config = {
         type: 'line',
         data: data,
         options: {responsive:false}
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
</script>

<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script>
$('.objList').click(function(event){
	
	var objListval = event.target.value;
	console.log(event.target.value);
	console.log(objListval);

	$('#curve_chart').remove();
	$('#graph').append('<canvas id="curve_chart"style="position: relative; width: 100%; height: 100%;"><canvas>');
	
	if(objListval == 'all_obj'){
		 $.ajax({
		        url : 'AjaxChart',
		        type : 'get',
		        dataType : 'json',
		        success : function(res){
		      	let labels = res.map(item => item.current_dt);
		        let activity = res.map(item => item.activity);
		        let feed = res.map(item => item.feed);
		        let drinking = res.map(item => item.drinking);
		      	console.log(drinking);

		         const data = {
		               labels: labels,
		                 datasets: [{
		                     data: activity,
		                     label:"활동량",
		                     fill: false,
		                     borderColor: 'blue',
		                     borderWidth: 2,
		                     tension: 0.5,
		                 },{ 
		                     data: feed,
		                     label:"취식량",
		                     fill: false,
		                     borderColor: 'red',
		                     borderWidth: 2,
		                     tension: 0.5,
		                },{ 
		                     data: drinking,
		                     label:"음수량",
		                     fill: false,
		                     borderColor: 'green',
		                     borderWidth: 2,
		                     tension: 0.5,
		                  }]
		         };

		      const config = {
		         type: 'line',
		         data: data,
		         options: {responsive:false}
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
	}else{
	   $.ajax({
	        url : 'AjaxChart_selectONE',
	        type : 'get',
	        data : {'object_id' : objListval },
	        dataType : 'json',
	        success : function(res){
	      	let labels = res.map(item => item.current_dt);
	        let activity = res.map(item => item.activity);
	        let feed = res.map(item => item.feed);
	        let drinking = res.map(item => item.drinking);
	      	console.log(drinking);

	         const data = {
	               labels: labels,
	                 datasets: [{
	                     data: activity,
	                     label:"활동량",
	                     fill: false,
	                     borderColor: 'blue',
	                     borderWidth: 2,
	                     tension: 0.5,
	                 },{ 
	                     data: feed,
	                     label:"취식량",
	                     fill: false,
	                     borderColor: 'red',
	                     borderWidth: 2,
	                     tension: 0.5,
	                },{ 
	                     data: drinking,
	                     label:"음수량",
	                     fill: false,
	                     borderColor: 'green',
	                     borderWidth: 2,
	                     tension: 0.5,
	                  }]
	         };

	      const config = {
	         type: 'line',
	         data: data,
	         options: {responsive:false}
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
	};
});
</script>
<!-- 클릭 시 카메라 번호 변경 JS -->
<script src="./js/Clock.js"></script>
<script src="./js/camClick.js"></script>
<script src="./js/camClickEvent.js"></script>
<script src="./js/objClickEvent.js"></script>
</html>