   $(".camList").on('click', function(){
	  $("#objList_div").show();
      var camNum = $(this).text();
      console.log(camNum);
      if(camNum=='1번 카메라'){
         var str="<div id='stream'><iframe src='https://www.youtube.com/embed/EUZ8YUxhMNM?autoplay=1&mute=1' title='streaming' width='90%' height='600px' style='position: relative; margin: 5%;'></iframe></div>"
         $("#stream").replaceWith(str);
      }else if(camNum=='2번 카메라'){
         var str="<div id='stream'><iframe src='https://www.youtube.com/embed/W9Ot_I3pb20?autoplay=1&mute=1' title='streaming' width='90%' height='600px' style='position: relative; margin: 5%;'></iframe></div>"
         $("#stream").replaceWith(str);
      }else if(camNum=='3번 카메라'){
         var str="<div id='stream'><iframe src='https://www.youtube.com/embed/N9oz7MOS5tI?autoplay=1&mute=1' title='streaming' width='90%' height='600px' style='position: relative; margin: 5%;'></iframe></div>"
         $("#stream").replaceWith(str);
      }else if(camNum=='전체 카메라'){
         var str="<div id='stream'><div id='framecss'><iframe src='https://www.youtube.com/embed/EUZ8YUxhMNM' title='streaming' width='100%' height='100%' style=' float : left;'></iframe></div>"+
            "<div id='framecss'><iframe src='https://www.youtube.com/embed/W9Ot_I3pb20' title='streaming' width='100%' height='100%' style=' float : left;'></iframe></div>"+
            "<div id='framecss'><iframe src='https://www.youtube.com/embed/N9oz7MOS5tI' title='streaming' width='100%' height='100%' style=' float : right;'></iframe></div>"+
            "<div id='framecss' style='display:inline-block; float:right; border:none;''><img src='./images/logo.png' width='100%' height='40%' style='margin-top:15%;'></div></div>"
            $("#stream").replaceWith(str);
      }
      
   });