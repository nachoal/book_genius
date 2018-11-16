import $ from 'jquery';
window.$ = $;
import "bootstrap";

const showMoreFromReview = (event) => {
  event.preventDefault();
  const element = event.currentTarget
  element.parentElement.querySelector('.review-shortened').classList.remove('review-shortened');
  element.remove();
}

function addReviewsShowMore() {
  document.querySelectorAll('.review-shortened').forEach(review => {
    if (review.scrollHeight !== review.clientHeight) {
      review.parentElement.insertAdjacentHTML('beforeEnd', "<a class='review-show-more' href='#'>Show more...</a>")
    }

    document.querySelectorAll('.review-show-more').forEach(showMore => {
      showMore.addEventListener('click', showMoreFromReview)
    })
  })
}

$(document).ready(_ => {
  addReviewsShowMore();
})
