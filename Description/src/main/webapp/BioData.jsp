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
ArrayList<ObjVO> objlist = new ArrayList<ObjVO>();
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

			<div id="objList" style="text-align : center;">
				<h2 style="text-align : center; margin-top : 8%">개체 목록</h2>					
				<div id="objList_div" style="display : none;">
					<button type="button" class="objList" value="all_obj">전체 개체</button>
					<br>
<%-- 				<%
					for (int i = 0; i < bioObjList.size(); i++) {
					%>
					<button type="button" class="objList" value="<%=bioObjList.get(i).getObject_id()%>"><%=bioObjList.get(i).getObject_id()%>번 개체</button>
					<br>
					<%
					}
					%>  --%>

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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

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

function objclick(){
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
};

</script>

<script>
$('.camList').click(function(event){
	
		console.log('클릭 됨');
 		var camListval = event.target.value;
 		console.log(event.target.value);
 		console.log(camListval);
 		
 		$('#objList_div').children().remove();
 		
 		$.ajax({
 			url : 'con_object',
 			type : 'get',
 			datatype :'json',
 			data : {'camera_id' : camListval},
 			success : function(item){
 				console.log(item);
 				var jsonData = JSON.parse(item);
 				console.log(jsonData); 
 				
 				jsonData.forEach(function (str){
 					var objid = str.object_id
 					console.log(objid + '번 개체');
 					var str = "<button type='button' class='objList' value="+objid+" onclick='objclick()'>"+objid+"번 개체"+"</button><br>"
 				 $('#objList_div').append(str);
 					
 				});

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
 				
 			},
 			error : function(){
 				alert('error');
 			}
 		});

	});
</script>
<!-- JS -->
<script src="./js/Clock.js"></script>
<script src="./js/camClick.js"></script>
<script src="./js/camClickEvent.js"></script>
</html>