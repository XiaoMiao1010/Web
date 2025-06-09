window.onload = function () {

    //展示
    function schoole() {
        var speed = 10;
        var imgbox = document.getElementById("imgbox");
        var span = imgbox.getElementsByTagName("span");
        imgbox.innerHTML += imgbox.innerHTML;
        var timer1 = window.setInterval(marquee, speed)

        imgbox.onmousemove = function () {
            clearInterval(timer1);
        }

        imgbox.onmouseout = function () {
            timer1 = setInterval(marquee, speed);
        }

        function marquee() {
            if (imgbox.scrollLeft > span[0].offsetWidth) {
                imgbox.scrollLeft = 0;
            } else {
                ++imgbox.scrollLeft;
            }
        }
    }

    schoole();


    function tableChange() {
        var current_index = 0;
        var lis = document.getElementById("SwitchNav").getElementsByTagName("li");
        var spans = document.getElementById("SwitchBigPic").getElementsByTagName("span");
        var timer = window.setInterval(autoChange, 3000);
        for (var i = 0; i < lis.length; i++) {
            lis[i].onmouseover = function () {
                if (timer) {
                    clearInterval(timer);
                }
                for (var j = 0; j < lis.length; j++) {
                    if (lis[j] == this) {
                        current_index = j;
                        spans[j].className = "sp";
                    } else {
                        spans[j].className = "";
                    }
                }
            }
            lis[i].onmouseout = function () {
                timer = setInterval(autoChange, 3000);
            }
        }

        function autoChange() {
            ++current_index;
            if (current_index == lis.length) {
                current_index = 0;
            }
            for (var i = 0; i < lis.length; i++) {
                spans[i].className = ""
            }
            spans[current_index].className = "sp";
        }
    }

    tableChange();
}

//下拉菜单
document.querySelector('.dropdown').addEventListener('mouseover', function () {
    document.querySelector('.dropdown-menu').style.display = 'block';
});

document.querySelector('.dropdown').addEventListener('mouseout', function () {
    document.querySelector('.dropdown-menu').style.display = 'none';
});
