const searchButton = document.querySelector(".search-button");
const cancelButton = document.querySelector(".cancel-button");
const searchBox = document.querySelector(".search-box");
const searchInput = document.querySelector("input");

searchButton.onclick = () => {
    searchBox.classList.add("search-active");
    searchInput.classList.add("search-active");
    searchButton.classList.add("search-active");
    cancelButton.classList.add("search-active");
    }

cancelButton.onclick = () => {
        searchBox.classList.remove("search-active");
        searchInput.classList.remove("search-active");
        searchButton.classList.remove("search-active");
        cancelButton.classList.remove("search-active");
        }