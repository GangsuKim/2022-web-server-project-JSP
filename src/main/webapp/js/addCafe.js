$("#cafeNameInput").on("propertychange change keyup paste input", function(){
    if ($(this).val().length <= 0) {
        $('#AddCafeTitle').text('카페명');
    } else {
        $('#AddCafeTitle').text($(this).val());
    }
});

$("#cafeAddrInput").on("propertychange change keyup paste input", function(){
    if ($(this).val().length <= 0) {
        $('#AddCafeAddr').text('카페주소');
    } else {
        $('#AddCafeAddr').text($(this).val());
    }
});

$("#cafeTagInput").on("propertychange change keyup paste input", function(){
    if ($(this).val().length <= 0) {
        $('#AddCafeTags').html('<div class="tags">태그</div>');
    } else {
        $('#AddCafeTags').empty();
        var appendStr = '';
        $.each($(this).val().split(','), function(i, value) {
            appendStr += '<div class="tags">' + value + '</div>&nbsp;';
        })
        $('#AddCafeTags').html(appendStr);
    }
});


$('#clickToAddImage').on('click', function() {
    document.getElementById('addCafeImage').click();
})

function addCafeImage(input) {
    // console.log(input.files[0]);
    document.getElementById('addImageShow').src = URL.createObjectURL(input.files[0]);
    document.getElementById('addImageShow').hidden = false;
    document.getElementById('clickToAddImage').hidden = true;

}

const addCafe = document.getElementById('addCafe');
const addCafeBtn = document.getElementById('addCafeBtn');

addCafeBtn.addEventListener('click', function() {
    addCafeBtn.innerHTML = (!addCafe.hidden) ? '카페 추가하기' : '취소하기';
    addCafe.hidden = !addCafe.hidden;
});

$('#addCafeDone').on('click', function() {
    if ($('#cafeNameInput').val().length == 0) {
        alert('카페명을 입력해 주세요.');
        $('#cafeNameInput').focus();
        return;
    } else if ($('#cafeAddrInput').val().length == 0) {
        alert('카페주소를 입력해 주세요.');
        $('#cafeAddrInput').focus();
        return;
    } else if ($('#cafeTagInput').val().length == 0) {
        alert('태그를 입력해 주세요.');
        $('#cafeTagInput').focus();
        return;
    }

    $('#addCafeToDB').click();
});

const article = document.getElementsByTagName('article')[0];
const article_top = article.getBoundingClientRect().top; //타겟 절대위치

window.scroll({top : article_top, behavior: 'smooth'}); //스크롤 이동