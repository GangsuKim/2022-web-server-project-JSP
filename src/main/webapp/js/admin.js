function verify(target) {
    const mainBox = document.getElementsByTagName('main')[0];
    const mainBox_right = mainBox.getBoundingClientRect().right; //타겟 절대위치
    
    const verifyBox = document.getElementById('verifyBox');
    verifyBox.style.left = mainBox_right + 20 + 'px';
    verifyBox.style.top = target.getBoundingClientRect().top - 90 + 'px';
    verifyBox.hidden = false;

    // alert(target.getElementById('cafeTitle'));

    // console.log(target.parentNode);

    const aTags = target.parentNode.getElementsByTagName('a');
    const inputs = verifyBox.getElementsByTagName('input');

    for (var i = 0; i < 4; i++) {
        inputs[i].value = aTags[i].innerText;
    }

    const cafeID = verifyBox.querySelector('#cafeID');
    cafeID.value = target.parentNode.querySelector('#cafeID').innerHTML;

}