document.querySelectorAll('.flip-card').forEach(function(card) {
    card.addEventListener('click', function() {
        this.classList.toggle('flip');
    });
});