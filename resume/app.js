let counterContainer = document.querySelector(".website-counter");
let visitCount = localStorage.getItem('page_view');

visitCount = 1;

// Check if page_view entry is present
if (visitCount) {
    visitCount = Number(visitCount) + 1;
    localStorage.setItem("page_view", visitCount);
  } else {
    visitCount = 1;
    localStorage.setItem("page_view", 1);
  }
  counterContainer.innerHTML = visitCount;