//隱藏,顯示選單
window.onload = function(){
    const navBar = document.querySelector("nav"),
        menuBtns = document.querySelectorAll(".menu-icon"),
        overlay = document.querySelector(".overlay");
    menuBtns.forEach(menuBtn => {
        menuBtn.addEventListener("click", () =>{
            navBar.classList.toggle("open");
        });
    });
    overlay.addEventListener("click", () =>{
        navBar.classList.remove("open");
    });
    
    // 隱藏,顯示分類
    const categoriesButton = document.getElementsByClassName("categories-button")[0];        
    const categoriesItems = document.getElementsByClassName("show")[0]
    
    categoriesButton.addEventListener("click", () =>{
        if (categoriesItems.classList.contains("show")){
            categoriesItems.classList.remove("show");
        } else {
            categoriesItems.classList.add("show");
        }
    });

    // 分類的箭頭旋轉
    var subimg = document.getElementsByClassName("sub-icon")[0];

    categoriesButton.addEventListener("click", ()=>{
        if (subimg.classList.contains("rotate")){
            subimg.classList.remove("rotate");
        } else {
            subimg.classList.add("rotate");
        }
    });
};