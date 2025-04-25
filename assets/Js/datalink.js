//新增會員中心導覽列連結
document.querySelectorAll('.radio-inputs .name').forEach(item => {
    item.addEventListener('click', () => {
        window.location.href = item.getAttribute('data-link');
    });
});