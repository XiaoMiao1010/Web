$(function () {
    var i = 0; //当前显示的图片索引
    var timer = null; //定时器
    var delay = 3000; //图片自动切换的间隔时间
    var width = 1920; //每张图片的宽度
    var speed = 400; //动画时间
    var isPaused = false; // 添加一个变量isPaused用于判断是否暂停轮播
    //复制列表中的第一个图片，追加到列表最后，设置ui的宽度为图片张数 * 图片宽度
    var firstimg = $('.banner_pic li').first().clone();
    $('.banner_pic').append(firstimg).width($('.banner_pic li').length * width);
    //1.设置周期计时器，实现图片自动切换
    timer = setInterval(imgChange, delay);
    //2.鼠标移入，暂停自动播放，移出，开始自动播放

    $('.banner').hover(function () {
        isPaused = true; // 当鼠标放上去时，将isPaused设置为true，表示暂停轮播
    }, function () {
        isPaused = false; // 当鼠标移出时，将isPaused设置为false，表示继续轮播
    });

    //3.鼠标划入圆点
    $('.dot li').mouseover(function () {
        i = $(this).index();
        $('.banner_pic').stop().animate({left: -i * width}, speed);
        dotChange();
    });
    //4.设置左右箭头的切换和隐藏
    $('.banner').hover(function () {
        $('.arrow').show();
    }, function () {
        $('.arrow').hide();
    });
    //5.向右箭头
    $('.next').click(function () {
        imgChange();
    });
    //6.向左箭头
    $('.prev').click(function () {
        --i;
        if (i == -1) {
            i = $('.banner_pic li').length - 2;
            $('.banner_pic').css({left: -($('.banner_pic li').length - 1) * width});
        }
        $('.banner_pic').stop().animate({left: -i * width}, speed);
        dotChange();
    });

    //自动切换图片
    function imgChange() {
        if (isPaused) {
            return;
        }
        ++i;
        isCrack();
        dotChange();
    }

    //无缝轮播
    function isCrack() {
        if (i == $('.banner_pic li').length) {
            i = 1;
            $('.banner_pic').css({left: 0});
        }
        $('.banner_pic').stop().animate({left: -i * width}, speed);
    }

    //自动切换对应的圆点
    function dotChange() {
        if (i == $('.banner_pic li').length - 1) {
            $('.dot li').eq(0).addClass('on').siblings().removeClass('on');
        } else {
            $('.dot li').eq(i).addClass('on').siblings().removeClass('on');
        }
    }
});