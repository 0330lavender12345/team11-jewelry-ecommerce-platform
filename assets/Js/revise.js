// 切換編輯模式
function toggleEdit() {
    const inputs = document.querySelectorAll('input');
    const emailInput = document.getElementById('email');
    const editButton = document.getElementById('editButton');
    const cancelButton = document.getElementById('cancelButton');
    const saveButton = document.getElementById('saveButton');

    inputs.forEach(input => {
        if (input !== emailInput) {
            input.readOnly = !input.readOnly;
        }
    });

    editButton.style.display = 'none';
    cancelButton.style.display = 'inline-block';
    saveButton.style.display = 'inline-block';
}

// 取消編輯
function cancelEdit() {
    const inputs = document.querySelectorAll('input');
    const editButton = document.getElementById('editButton');
    const cancelButton = document.getElementById('cancelButton');
    const saveButton = document.getElementById('saveButton');

    inputs.forEach(input => {
        input.readOnly = true;
        input.value = input.defaultValue; // 重置為預設值
    });

    editButton.style.display = 'inline-block';
    cancelButton.style.display = 'none';
    saveButton.style.display = 'none';
}

// 表單提交
document.getElementById('profileForm').addEventListener('submit', function(event) {
    const inputs = document.querySelectorAll('input');
    
    inputs.forEach(input => {
        input.readOnly = true;
        input.defaultValue = input.value; // 保存當前值為預設值
    });
    
    alert('個人資訊更新成功！');
});
