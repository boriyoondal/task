const clockContainer = document.querySelector("#time"),
  clockTitle = clockContainer.querySelector("h1");

function getTime() {
  const date = new Date();
  const minutes = date.getMinutes();
  const hours = date.getHours();
  const seconds = date.getSeconds();

  const month = date.getMonth();
  const dateDay = date.getDate();
  const day = date.getDay();
  const week = ['일','월','화','수','목','금','토'];

  clockTitle.innerText = `${month + 1}월 ${dateDay}일 ${week[day]}요일`+` `+
`${hours < 10 ? `0${hours}` : hours}:${
    minutes < 10 ? `0${minutes}` : minutes
  }:${seconds < 10 ? `0${seconds}` : seconds}`;
}

  getTime(); 
  setInterval(getTime, 1000); 
