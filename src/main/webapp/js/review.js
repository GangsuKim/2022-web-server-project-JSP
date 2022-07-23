const write_review_window = document.getElementById('write_review_window');
const writeReviewBtn = document.getElementById('writeReview');
let starClicked = -1;
let writing = false;

writeReviewBtn.addEventListener('click', function() {
    if(writing) {
        write_review_window.hidden = true;
        writing = false;
        this.innerHTML = '<i class="bi bi-pencil-square"></i> 리뷰 쓰기';
        this.style.backgroundColor = '#674836';
        starClicked = -1;
        document.getElementById('r_name').value = '';
        document.getElementById('r_review').value = '';
        starUnHover(4, stars);
    } else {
        write_review_window.hidden = false;
        write_review_window.style.top = window.pageYOffset + writeReviewBtn.getBoundingClientRect().top - 360 + 'px';
        write_review_window.style.left = writeReviewBtn.getBoundingClientRect().right - 450 + 'px';
        writing = true;
        this.innerHTML = '<i class="bi bi-x-lg"></i> 작성 취소'
        this.style.backgroundColor = '#eb334a';
    }
})

const stars = write_review_window.getElementsByTagName('i');

for (var i = 0; i < stars.length; i++) {
    stars[i].addEventListener('mouseover', function() {
        starHover(this.id, stars);
    })

    stars[i].addEventListener('mouseleave', function() {
        starUnHover(this.id, stars);
    })

    stars[i].addEventListener('click', function() {
        starClick(this.id, stars);
        starClicked = this.id;
        document.getElementById('r_star').value = parseInt(this.id) + 1;
    })
}

function starHover (index, stars) {
    if(index != 0) {
        stars[index].style.color = '#674836';
        starHover(index - 1, stars);
    } else {
        stars[index].style.color = '#674836';
    }
}

function starUnHover(index, stars) {
    if(starClicked == -1) {
        if(index != 0) {
            stars[index].style.color = '#cecece';
            starUnHover(index - 1, stars);
        } else {
            stars[index].style.color = '#cecece';
        }
    } else if(starClicked < index) {
        for(var i = starClicked; i < 4; i++) {
            stars[parseInt(i)+1].style.color = '#cecece'; 
        }
    }
}

function starClick(index, stars) {
    if(starClicked == -1) {
        if(index != 0) {
            stars[index].style.color = '#674836';
            starClick(index - 1, stars);
        } else {
            stars[index].style.color = '#674836';
        }
    } else if (starClicked > index) {
        for(var i = index; i < 4; i++) {
            stars[parseInt(i)+1].style.color = '#cecece'; 
        }
    }
}