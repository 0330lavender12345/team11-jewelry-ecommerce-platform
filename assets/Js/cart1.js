document.addEventListener('DOMContentLoaded', () => {
    const list = document.querySelector('.list');
    const quantitySpan = document.querySelector('.quantity');
    let cartItems = JSON.parse(localStorage.getItem('cart')) || [];

    function updateCartQuantity() {
        quantitySpan.textContent = cartItems.length;
    }

    function renderCartItems() {
        list.innerHTML = '';

        cartItems.forEach(item => {
            const productItem = document.createElement('div');
            productItem.className = 'item';
            productItem.innerHTML = `
                <img src="${item.img}" alt="${item.name}">
                <div class="item-details">
                    <h2>${item.name}</h2>
                    <p>尺寸: ${item.size}</p>
                    <p>數量: ${item.quantity}</p>
                    <p>價格: NT$${item.price}</p>
                </div>
            `;
            list.appendChild(productItem);
        });

        const total = cartItems.reduce((sum, item) => sum + (item.price * item.quantity), 0);
        document.querySelector('.total').textContent = `總價: NT$${total}`;
    }

    updateCartQuantity();
    renderCartItems();
});
document.addEventListener('DOMContentLoaded', function() {
    const checkoutbtn = document.querySelector('.checkout');

    checkoutbtn.addEventListener('click', function(event) {
        event.preventDefault(); // 防止表單提交
        window.location.href = '../pages/checkpage.html';
    });
});