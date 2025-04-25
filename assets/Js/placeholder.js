//登入註冊輸入提示字 (add & remove placeholder)
document.getElementById('email').addEventListener('focus', function() {
    this.setAttribute('placeholder', '請輸入您的電子郵件地址');
});
document.getElementById('email').addEventListener('blur', function() {
    this.removeAttribute('placeholder');
});


document.getElementById('pass').addEventListener('focus', function() {
    this.setAttribute('placeholder', '請輸入您的密碼');
});
document.getElementById('pass').addEventListener('blur', function() {
    this.removeAttribute('placeholder');
});


document.getElementById('name').addEventListener('focus', function() {
    this.setAttribute('placeholder', '請輸入您的使用者名稱');
});
document.getElementById('name').addEventListener('blur', function() {
    this.removeAttribute('placeholder');
});


document.getElementById('phone').addEventListener('focus', function() {
    this.setAttribute('placeholder', '請輸入您的電話號碼');
});
document.getElementById('phone').addEventListener('blur', function() {
    this.removeAttribute('placeholder');
});

document.getElementById('pass').addEventListener('focus', function() {
    this.setAttribute('placeholder', '請輸入您的密碼');
});
document.getElementById('pass').addEventListener('blur', function() {
    this.removeAttribute('placeholder');
});


document.getElementById('pass-confirm').addEventListener('focus', function() {
    this.setAttribute('placeholder', '再次確認您的密碼');
});
document.getElementById('pass-confirm').addEventListener('blur', function() {
    this.removeAttribute('placeholder');
});