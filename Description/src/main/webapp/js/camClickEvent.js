

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
