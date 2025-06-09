// 滑动的状态
let flag = true
const mySwitch = () => {
    if (flag) {
        // 获取到滑动盒子的dom元素并修改它移动的位置
        $(".pre-box").css("transform", "translateX(100%)")
        // 获取到滑动盒子的dom元素并修改它的背景颜色
        $(".pre-box").css("background-color", "#c9e0ed")
        //修改图片的路径
        $("img").attr("src", "images/wuwu.jpeg")

    } else {
        $(".pre-box").css("transform", "translateX(0%)")
        $(".pre-box").css("background-color", "#edd4dc")
        $("img").attr("src", "images/waoku.jpg")
    }
    flag = !flag
}

//气泡特效
const bubleCreate = () => {
    const body = document.body
    const buble = document.createElement('span')
    let r = Math.random() * 5 + 25 //25~30
    buble.style.width = r + 'px'
    buble.style.height = r + 'px'
    buble.style.left = Math.random() * innerWidth + 'px'
    body.append(buble)
    setTimeout(() => {
        buble.remove()
    }, 4000)
}
setInterval(() => {
    bubleCreate()
}, 200);


//登录按钮的点击事件，点击时发送Ajax请求去后台，并等待后台反馈的登录结果
$(function () {
    $('.loginBtn').click(function () {
        var userName = $('.username').val();
        var passWord = $('.password').val();
        //判空操作
        if (userName.trim().length == 0 || passWord.trim().length == 0) {
            alert('用户名和密码不能为空！请检查后输入！');
            return;
        }
//
//         $.ajax({
//             type:'post',
//             url:'php/loginFile.php',
//             dataType:'json',
//             data:{
//                 uname:userName,
//                 upass:passWord,
//             },
//             success:function (res){
//                 switch(res.infoCode){
//                     case 0:{
//                     //需要做的是变更页面结构
//                     alert('登陆成功');
//                     setTimeout(function() {
//                     window.location.href = './homepage.php';
//                         }, 100); // 设置一个短暂的延迟，确保页面结构变更完成后再跳转
//                     break;
//                     }
//                     case 1:{
//                         alert('登录失败！用户名或密码错误！');
//                     }
//                     break;
//                     case 2:{
//                         alert('登录失败！网络连接错误！');
//                     }
//                     break;
//                     case 3:{
//                         alert('登录失败！该用户名不存在！');
//                     }
//                     break;
//                     default:{
//                         alert('未知错误！');
//                     }
//                 }
//             }
//         });
//         $('.username').val('');
//         $('.password').val('');
    });
});

//注册按钮的点击事件，点击时发送Ajax请求去后台，并等待后台反馈的登录结果
$(function () {
    $('.regBtn').click(function () {
        var reguserName = $('.regusername').val();
        var regpassWord = $('.regpassword').val();
        var regpWd = $('.regpwd').val();
        // 判空操作
        if (reguserName.trim().length == 0 || regpassWord.trim().length == 0) {
            alert('用户名和密码不能为空！请检查后输入！');
            return;
        }
        if (regpassWord !== regpWd) {
            alert('两次输入的密码不一致！');
            return;
        }
        // 发送 AJAX 请求到后台的 registerFile.php 文件，传递用户名和密码
        // $.ajax({
        //     type:'post',
        //     url:'php/postReg.php',
        //     dataType:'json',
        //     data:{
        //         uname: reguserName,
        //         upass: regpassWord,
        //     },
        //     success:function (res){
        //         switch(res.infoCode){
        //             case 0:{
        //                 alert('注册成功，请返回到登录界面！');
        //                 break;
        //             }
        //             case 1:{
        //                 alert('注册失败！用户名已存在！');
        //                 break;
        //             }
        //             case 2:{
        //                 alert('注册失败！数据库插入错误！');
        //                 break;
        //             }
        //             default:{
        //                 alert('未知错误！');
        //             }
        //         }
        //     }
        //     });
        //     $('.regusername').val('');
        //     $('.regpassword').val('');
        //     $('.regpwd').val('');
    });
});

