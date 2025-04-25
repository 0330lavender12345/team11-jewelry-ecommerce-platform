//點擊購物車按鈕跳出視窗訊息
document.addEventListener("DOMContentLoaded", function() {
    const cardButtons = document.querySelectorAll('.card-button');

    cardButtons.forEach(button => {
        button.addEventListener('click', function(event) {
            event.preventDefault();
            alert("商品已成功加入購物車！");
        });
    });
});
