// let counterContainer = document.querySelector(".website-counter");
// let visitCount = localStorage.getItem('page_view');

let counterContainer = document.getElementById(".website-counter");

const api = 'https://tnz7fm9m42.execute-api.us-east-2.amazonaws.com/prod/dynamo_lambda';

// function invoke(){
fetch(api)
.then((response) => response.json())
.then((data) => console.log(data));

// }

// function getCount(){

// }
// return data;

  // counterContainer.innerHTML = visitCount
  // Need to point the result to an html element