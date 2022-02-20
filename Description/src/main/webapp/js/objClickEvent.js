
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