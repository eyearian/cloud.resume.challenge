document.addEventListener('DOMContentLoaded', () => {
  const counterElement = document.getElementById('count');
  const api = 'https://tnz7fm9m42.execute-api.us-east-2.amazonaws.com/prod/dynamo_lambda';
  updateVisit();

  function updateVisit(){
    fetch(api)
      .then((response) => response.json())
      .then((response) => { counterElement.innerHTML = response;});
  }
});
