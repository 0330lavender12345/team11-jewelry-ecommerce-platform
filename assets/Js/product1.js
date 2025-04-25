document.addEventListener("DOMContentLoaded", function() {
    const showReviewsButton = document.querySelector(".show-reviews");
    const reviewsSection = document.getElementById("reviews-section");
    const reviewForm = document.getElementById("review-form");
    const individualReviews = document.getElementById("individual-reviews");
    const overallRatingElement = document.querySelector(".rating .stars");
    const overallScoreElement = document.querySelector(".rating .reviews");

    let totalRating = 10; // 初始的总评分分数, 2个评价5星
    let reviewCount = 2;  // 初始的评论数量

    showReviewsButton.addEventListener("click", function() {
        if (reviewsSection.style.display === "none" || reviewsSection.style.display === "") {
            reviewsSection.style.display = "block";
            showReviewsButton.textContent = "隱藏評論";
        } else {
            reviewsSection.style.display = "none";
            showReviewsButton.textContent = "查看評論";
        }
    });

    reviewForm.addEventListener("submit", function(event) {
        event.preventDefault();

        const rating = parseInt(reviewForm.rating.value);
        const comment = reviewForm.comment.value;

        const reviewDiv = document.createElement("div");
        reviewDiv.className = "review";
        
        const ratingStars = "★".repeat(rating) + "☆".repeat(5 - rating);

        reviewDiv.innerHTML = `
            <span>新評論者</span>
            <span>${new Date().toLocaleDateString()}</span>
            <span class="stars">${ratingStars}</span>
            <p>${comment}</p>
        `;

        individualReviews.appendChild(reviewDiv);

        // 更新总评分和评论数量
        totalRating += rating;
        reviewCount++;

        const newAverageRating = (totalRating / reviewCount).toFixed(1);
        overallRatingElement.innerHTML = "★".repeat(Math.round(newAverageRating)) + "☆".repeat(5 - Math.round(newAverageRating));
        overallScoreElement.innerHTML = `${newAverageRating} 分 | ${reviewCount} 個評價`;

        reviewForm.reset();
    });
});
document.addEventListener('DOMContentLoaded', function() {
    const addToCartForm = document.getElementById('add-to-cart-form');
    const buyNowForm = document.getElementById('buy-now-form');

    const sizeSelector = document.getElementById('size');
    const quantitySelector = document.getElementById('quantity');

    addToCartForm.addEventListener('submit', function(event) {
        document.getElementById('cart-size').value = sizeSelector.value;
        document.getElementById('cart-quantity').value = quantitySelector.value;
    });

    buyNowForm.addEventListener('submit', function(event) {
        document.getElementById('buy-size').value = sizeSelector.value;
        document.getElementById('buy-quantity').value = quantitySelector.value;
    });
});