<%@ page contentType="text/html;charset=gbk" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
    <title>丰城市环境自动监控系统</title>
    <link rel="stylesheet" href="style/reset-min.css"/>
    <link rel="stylesheet" href="style/base.css"/>
    <link rel="stylesheet" href="style/index.css"/>
    <script src="jquery-1.8.3.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $(".loginFormTdIpt").focus(function () {
                if ($(this).val() == "" || $(this).val() == "账号" || $(this).val() == "密码") {
                    $(this).next('label').hide();
                }
            });
            $(".loginFormTdIpt").blur(function () {
                if ($(this).val() == "" || $(this).val() == "账号" || $(this).val() == "密码") {
                    $(this).next('label').show();
                }
            });
        })

    </script>
    <style type="text/css">
        body {
            color: #000;
            background: #fff;
            font-size: 12px;
            line-height: 166.6%;
            text-align: center;
        }

        body, input, select, button {
            font-family: verdana
        }

        h1, h2, h3, select, input, button {
            font-size: 100%
        }

        body, h1, h2, h3, ul, li, form, p, img {
            margin: 0;
            padding: 0;
            border: 0
        }

        input, button, select, img {
            margin: 0;
            line-height: normal
        }

        select {
            padding: 1px
        }

        ul {
            list-style: none
        }

        select, input, button, button img, label {
            vertical-align: middle
        }

        header, footer, div, aside, nav, hgroup, figure, figcaption {
            display: block;
            margin: 0;
            padding: 0;
            border: none
        }

        a {
            text-decoration: none;
            color: #848585
        }

        a:hover {
            color: #000
        }

        .fontWeight {
            font-weight: 700;
        }

        /* global */
        .unvisi {
            visibility: hidden
        }

        /* backgroundImage */
        .headerIntro, .loginIcoCurrent, .loginFuncNormal, .loginFuncMobile, .loginIcoNew, .themeText li, .domain, .whatAutologin, .btn, .dialogbox .hd .rc, .dialogbox .hd, .btn-moblogin, .btn-moblogin2, .loginFormIpt-over .loginFormTdIpt, .loginFormIpt-focus .loginFormTdIpt, .ico, .ext, .locationTestTitle, .verSelected, .servSelected, .locationTestTitleClose, #extText li, #extMobLogin li, #mobtips_arr, #mobtips_close {
            background-image: url(login/bg_v5.png)
        }

        .headerLogo, .headerIntro, .headerNav, #headerEff, .footerLogo, .footerNav, .loginIcoCurrent, .loginIcoNew, .loginFormTh, .loginFormTdIpt, .domain, #loginFormSelect, #whatAutologinTip, #mobtips, #mobtips_arr, #mobtips_close {
            position: absolute
        }

        /* ico */
        .ico-arr {
            display: inline-block;
            width: 7px;
            height: 12px;
            vertical-align: baseline;
            background-position: -160px -112px;
        }

        .ico-arr-d {
            background-position: -160px -110px;
        }

        .loginFormConf a:hover .ico-arr-d, .ico-arr-d-focus {
            background-position: -176px -110px;
        }

        * + html .ico-arr-d {
            background-position: -160px -112px;
        }

        * + html .loginFormConf a:hover .ico-arr-d, * + html .loginFormConf a:hover .ico-arr-d, * + html .ico-arr-d-focus {
            background-position: -176px -112px;
        }

        /* header */
        .header {
            width: 450px;
            background: none;
            position: relative;
            margin: 0 0 0 30px;
            z-index: 2;
            overflow: hidden;
            height: 104px;
            left: 0;
            top: 0;
        }

        .headerLogo {
            top: 17px;
            left: 0px
        }

        .headerIntro {
            height: 28px;
            width: 144px;
            display: block;
            background-position: 0 -64px;
            top: 17px;
            left: 144px
        }

        .headerNav {
            top: 21px;
            right: 0px;
            width: 300px;
            text-align: right
        }

        .headerNav a {
            margin-left: 13px
        }

        .header a {
            float: left;
            margin: 15px 0;
        }

        .blacktop {
            position: absolute;
            top: 30px;
            right: 30px;
        }

        /* main */
        .main {
            height: 370px;
            margin: 0 auto;
            background: #fff;
            padding-top: 70px;
        }

        .main-inner {
            width: 900px;
            height: 440px;
            overflow: visible;
            margin: 0 auto;
            position: relative;
            clear: both
        }

        #theme {
            height: 440px;
            width: 900px;
            position: absolute;
            overflow: hidden;
            z-index: 1;
            background-position: top right;
            background-repeat: no-repeat;
            text-align: left;
            top: 0;
            left: 0;
        }

        .themeLink {
            height: 274px;
            width: 430px;
            display: block;
            outline: 0;
        }

        .themeText {
            margin-left: 26px;
        }

        .themeText li {
            line-height: 22px;
            -line-height: 24px;
            height: 24px;
            color: #858686;
            text-indent: 12px;
            background-position: -756px -72px;
            background-repeat: no-repeat
        }

        .themeText li a {
            color: #005590;
            text-decoration: underline;
        }

        .login {
            width: 338px;
            height: 288px;
            margin: auto;
            background: #fff;
            border: 1px solid #b7c2c9;
            _display: inline;
            text-align: left;
            position: relative;
            z-index: 2;
            border-radius: 2px;
        }

        .login, .unishadow {
            box-shadow: 0px 1px 3px 0 rgba(0, 0, 0, 0.2);
            -webkit-box-shadow: 0px 1px 3px 0 rgba(0, 0, 0, 0.2);
            -moz-box-shadow: 0px 1px 3px 0 rgba(0, 0, 0, 0.2);
        }

        .loginFunc {
            width: 338px;
            height: 49px;
            overflow: hidden;
            clear: both;
        }

        .loginFuncNormal, .loginFuncMobile {
            width: 168px;
            height: 49px;
            overflow: hidden;
            position: relative;
            line-height: 46px;
            font-weight: 700;
            background-position: 0 0;
            float: left;
            font-size: 14px;
            text-align: center;
        + line-height : 48 px;
            background-repeat: repeat-x;
            color: #333;
            cursor: pointer;
        }

        .loginFuncMobile {
            background-position: 0px 0px;
            width: 169px;
            border-right: none;
        }

        .loginIcoCurrent {
            width: 24px;
            height: 24px;
            left: 26px;
            top: 9px;
            display: none;
        }

        .loginIcoNew {
            width: 21px;
            height: 10px;
            font-size: 0;
            background-position: -684px 0;
            left: 135px;
            top: 12px;
        }

        .tab-2 .loginFuncMobile .loginIcoCurrent, .tab-1 .loginFuncNormal .loginIcoCurrent, .tab-2 #extMobLogin, .tab-1 #extText, .tab-11 #extVerSelect, .tab-22 #extMobLogin2, .tab-2 #lfBtnReg2, .tab-1 #lfBtnReg1, .tab-2 .loginFormThMob {
            display: block;
        }

        .tab-2 #lfVerSelect, .tab-2 #extVerSelect, .tab-22 #extMobLogin, .tab-11 #extText, .tab-2 #extText, .tab-2 #lfBtnReg, .tab-1 #lfBtnReg2, .tab-22 #lfBtnMoblogin, .tab-2 .loginFormThAcc {
            display: none;
        }

        /* form */
        .loginForm {
            position: relative;
            height: 207px;
            padding-top: 32px;
        }

        .loginFormIpt {
            position: relative;
            height: 33px;
            line-height: 33px;
            margin-top: 0px;
            margin-left: 42px;
            clear: both;
            width: 253px;
            border: 1px solid #bac5d4;
            border-bottom-color: #d5dbe2;
            border-right-color: #d5dbe2;
            border-radius: 2px;
        }

        .loginFormIpt-over {
            border-color: #a6b4c9;
            border-bottom-color: #bac5d4;
            border-right-color: #bac5d4;
        }

        .loginFormIpt-focus .loginFormTdIpt, .loginFormIpt-over .loginFormTdIpt {
            background-position: 0 -160px;
        }

        .loginFormIpt-focus {
            border-color: #60a4e8;
            border-bottom-color: #84b4fc;
            border-right-color: #84b4fc;
        }

        .loginFormIpt-focus .placeholder {
            color: #b4c0d2;
        }

        .loginFormIptWiotTh {
            height: 35px;
            border: none;
            margin-top: 19px;
            width: 255px;
        }

        .loginFormTh {
            width: 36px;
        }

        .loginFormThMob {
            display: none;
        }

        .loginFormTdIpt {
            width: 237px;
            padding: 7px 8px 6px 8px;
            border: 1px solid #838383;
            ime-mode: disabled;
            height: 20px;
            top: 0;
            left: 0;
            line-height: 20px;
            font-size: 16px;
            font-weight: 700;
            background-color: #eef3f8;
            border: none;
            font-family: verdana;
            line-height: 17px;
            color: #92a4bf;
        }

        .loginFormTdIpt:focus {
            outline: 0;
        }

        .loginFormTdIpt-focus {
            color: #333;
            font-weight: 700;
        }

        .showPlaceholder .placeholder {
            visibility: visible;
            cursor: text;
        }

        .placeholder {
            color: #92a4bf;
            font-size: 14px;
            text-indent: 10px;
            position: absolute;
            left: 0;
            top: 0;
            visibility: hidden;
            background: none;
        }

        .domain {
            width: 92px;
            height: 33px;
            background-position: 0 -112px;
            line-height: 999em;
            overflow: hidden;
            display: block;
            right: 0;
            top: 0px;
        }

        .loginFormCheck {
            height: 14px;
            line-height: 14px;
            color: #555;
            margin-left: 42px;
            margin-top: 19px;
            clear: both;
            width: 255px;
            position: relative;
            z-index: 1;
        }

        .loginFormCheckInner {
            height: 14px;
            width: 150px;
            float: left;
        }

        .forgetPwdLine {
            height: 18px;
            line-height: 18px;
            margin-left: 42px;
            clear: both;
            width: 253px;
            text-align: right;
            margin-top: 8px;
        }

        .forgetPwd {
            color: #848585;
        }

        .forgetPwd:hover {
            color: #333;
        }

        #loginFormSelect {
            width: 182px;
            left: 46px;
            top: 6px;
        }

        .loginFormCbx {
            width: 13px;
            height: 13px;
            padding: 0;
            overflow: hidden;
            margin: 0;
        }

        .loginFormSslText {
            font-family: simsun
        }

        .whatAutologin {
            display: inline-block;
            vertical-align: top;
            width: 14px;
            height: 14px;
            background-position: -112px -112px;
            line-height: 999em;
            overflow: hidden
        }

        #whatAutologinTip {
            z-index: 9;
            width: 180px;
            height: 36px;
            background-color: #fffcd1;
            border: 1px #f1d47c solid;
            left: 0px;
            top: 16px;
            text-align: left;
            padding: 5px;
            line-height: 18px;
            color: #de6907;
            display: none;
        }

        .btn {
            float: left;
            height: 35px;
            text-align: center;
            cursor: pointer;
            border: 0;
            padding: 0;
            font-weight: 700;
            font-size: 14px;
            display: inline-block;
            vertical-align: baseline;
            line-height: 35px;
            outline: 0;
        }

        .btn-login {
            width: 102px;
            background-position: 0 -208px;
            color: #fff;
            margin: auto;
        }

        .loginFormIptWiotTh {
            margin: 25px auto 0;
            width: 102px;
        }

        .btn-login-hover {
            background-position: 0 -256px;
        }

        .btn-login-active {
            background-position: 0 -304px
        }

        .btn-reg {
            width: 102px;
            background-position: -112px -208px;
            color: #555;
            float: right;
        }

        .btn-reg:hover {
            color: #555
        }

        .btn-reg-hover {
            background-position: -112px -256px;
            color: #555
        }

        .btn-reg-active {
            background-position: -112px -304px;
            color: #555
        }

        .btn-moblogin2 {
            width: 202px;
            height: 37px;
            text-align: center;
            font-size: 14px;
            background-position: -396px -288px;
            background-color: #fff;
            margin-top: 30px;
            float: none;
            margin-left: 46px;
        }

        .loginFormConf {
            height: 12px;
            line-height: 12px;
            margin-left: 42px;
            margin-top: 35px;
            clear: both;
            width: 255px;
            position: relative;
            color: #848585;
            z-index: 1;
        }

        .loginFormVer {
            float: left;
            width: 160px;
        }

        .loginFormService {
            float: right: width : 80 px;
            text-align: right;
        }

        .loginFormVerList {
            width: 140px;
            position: absolute;
            padding: 1px;
            background: #fff;
            border: 1px solid #b7c2c9;
            top: -5px;
            top: -4px \9;
            left: 33px;
            display: none;
        }

        .loginFormVerList li a {
            height: 22px;
            line-height: 22px;
            width: 140px;
            overflow: hidden;
            color: #848585;
            display: block;
            text-indent: 22px;
        }

        .loginFormVerList li a:hover {
            background-color: #eef3f8;
        }

        .loginFormVerList li a.verSelected {
            background-position: -250px -58px;
            background-repeat: no-repeat;
            color: #333;
        }

        /* ext */
        #extVerSelect, #extText, #extMobLogin, #extMobLogin2 {
            display: none;
        }

        .ext {
            width: 336px;
            border: 1px solid #f1f3f5;
            height: 10px;
            background-position: 0 -448px;
            background-repeat: repeat-x;
            position: absolute;
            bottom: 0;
        }

        #extText {
            margin: 15px 0 0 42px;
            line-height: 12px;
        }

        #extText li {
            background-position: -240px -123px;
            background-repeat: no-repeat;
            padding-left: 7px;
            color: #9bacc6;
            margin-bottom: 9px;
        }

        #extText li a {
            color: #9bacc6;
        }

        #extText li a:hover {
            color: #5d8dc8;
        }

        #extMobLogin {
            padding-left: 42px;
        }

        #extMobLogin li {
            margin-bottom: 9px;
            padding-left: 7px;
            color: #848585;
            height: 12px;
            line-height: 12px;
            background-position: -240px -107px;
            background-repeat: no-repeat
        }

        #extMobLogin h3 {
            color: #555;
            font-size: 12px;
            margin: 16px 0 11px;
            height: 14px;
            line-height: 14px;
        }

        #extVerSelect {
            height: 66px;
            line-height: 66px;
            font-size: 14px;
            text-align: center;
            font-weight: 700;
        }

        #extVerSelect a {
            color: #005590;
            text-decoration: underline;
        }

        .setMobLoginInfo {
            margin-left: 46px;
            color: #848585;
            margin-top: 10px;
        }

        /* tab-2 */
        .tab-2 .loginFormConf {
            margin-top: 22px;
        }

        .tab-2 .ext {
            height: 85px;
        }

        .tab-2 .loginFormIptWiotTh {
            margin-top: 15px;
        }

        .tab-2 .loginFormCheck {
            margin-top: 13px;
        }

        /* noscript */
        .noscriptTitle {
            line-height: 32px;
            font-size: 24px;
            color: #d90000;
            padding-top: 60px;
            font-weight: 700;
            background: #fff;
        }

        .noscriptLink {
            text-decoration: underline;
            color: #005590;
            font-size: 14px;
        }

        /* mobtips */
        #mobtips {
            height: 18px;
            border: 1px solid #c6c6a8;
            top: 29px;
            left: 46px;
            line-height: 18px;
            background: #ffffe1;
            padding-left: 6px;
            padding-right: 20px;
            display: none;
            color: #565656;
            zoom: 1;
        }

        #mobtips_arr {
            width: 9px;
            height: 9px;
            background-position: -684px -72px;
            top: -5px;
            left: 15px;
        }

        #mobtips_close {
            background-position: -715px -68px;
            top: 2px;
            width: 16px;
            height: 14px;
            right: 0px;
        }

        #mobtips em {
            font-style: normal;
            color: #328721;
        }

        #mobtips a {
            text-decoration: underline;
            color: #005590;
        }

        /* mask */
        .mask {
            position: absolute;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background: #000;
            filter: alpha(opacity=30);
            -moz-opacity: 0.3;
            opacity: 0.3;
            z-index: 998
        }

        /* 弹框 */
        .dialogbox {
            position: absolute;
            left: 0;
            top: 0;
            z-index: 999;
            width: 687px;
            left: 50%;
            margin-left: -343px;
            top: 50%;
            margin-top: -152px;
        }

        .dialogbox .hd {
            position: relative;
            padding: 0 10px;
            height: 27px;
            line-height: 27px;
            color: #fff;
            background-repeat: repeat-x;
            background-position: 0 -576px
        }

        .dialogbox .hd .rc {
            position: absolute;
            top: 0;
            width: 2px;
            height: 27px
        }

        .dialogbox .hd .rc-l {
            left: 0;
            background-position: -720px -36px
        }

        .dialogbox .hd .rc-r {
            right: 0;
            background-position: -722px -36px
        }

        .dialogbox .hd .btn-close {
            position: absolute;
            right: 5px;
            top: 5px;
            width: 16px;
            height: 16px;
            background-position: -716px 3px;
            line-height: 9999px;
            overflow: hidden;
            font-size: 0;
            margin-right: 0;
        }

        .dialogbox .bd {
            border: 1px solid #6C92AD;
            border-top: none;
            background: #fff
        }

        .dialogbox iframe {
            display: block
        }

        #phoneRegFrame {
            width: 685px;
            height: 315px
        }

        /* 加密http登录弹窗 */
        .enhttp .topborder, .enhttp .bottomborder, .enhttp .ct, .enhttp .cldenhttp, .enhttp .ct .inner .httplogin {
            background-image: url(http://mimg.127.net/index/lib/img/bg_httplogin.gif);
            background-color: transparent;
            background-repeat: no-repeat;
            text-decoration: none;
        }

        .enhttp {
            width: 420px;
            height: 270px;
            position: absolute;
            z-index: 999;
            overflow: hidden;
            top: 0;
            left: 50%;
            margin-left: -210px;
            top: 50%;
            margin-top: -135px;
        }

        .enhttp .topborder {
            width: 418px;
            height: 2px;
            font-size: 1px;
            overflow: hidden;
            margin: 0 auto;
            background-position: 0 -108px;
        }

        .enhttp .bottomborder {
            width: 418px;
            height: 2px;
            font-size: 1px;
            overflow: hidden;
            margin: 0 auto;
            background-position: 0 -110px;
        }

        .enhttp .ct {
            width: 418px;
            height: 266px;
            background-position: 0 -134px;
            background-color: #fff;
            border-left: 1px solid #82aecd;
            border-right: 1px solid #82aecd;
            position: relative;
            overflow: hidden;
        }

        .enhttp .ct .inner {
            padding-top: 40px;
            margin: 0 auto;
            text-align: left;
        }

        .enhttp .ct .inner p {
            font-size: 14px;
        }

        .enhttp .ct .inner .txt-tips {
            color: #737373;
            line-height: 30px;
            width: 325px;
            margin-left: 46px;
            display: inline;
        }

        .enhttp .ct .inner .txt-normal {
            line-height: 30px;
            width: 325px;
            margin: 10px 0 0 46px;
        }

        .enhttp .ct .inner .httplogin {
            font-size: 14px;
            height: 34px;
            width: 120px;
            display: block;
            background-position: -432px -108px;
            line-height: 34px;
            text-align: center;
            color: #fff;
            font-weight: 700;
            background-color: #3486cc;
        }

        .enhttp .ct .inner .txt-line {
            width: 325px;
            margin-left: 46px;
            background: #b6cad9;
            height: 1px;
            overflow: hidden;
            font-size: 1px;
            margin-top: 24px;
        }

        .enhttp .ct .inner .txt-advice {
            line-height: 60px;
            width: 325px;
            color: #8d8d8d;
            margin-left: 46px;
        }

        .enhttp .ct .inner .txt-advicelink {
            margin-left: 20px;
            font-size: 14px;
        }

        .enhttp .cldenhttp {
            height: 22px;
            width: 22px;
            overflow: hidden;
            position: absolute;
            right: 8px;
            top: 6px;
            background-position: 0 -112px;
            text-indent: -9999px;
        }

        .enhttp .cldenhttp:hover {
            background-position: -22px -112px;
        }

        .enhttp .enhttpbox {
            position: absolute;
            z-index: 2;
            left: 0;
        }

        .enhttp .httploginframe {
            width: 100%;
            height: 200px;
            position: absolute;
            top: 2px;
            z-index: 1;
            left: 0;
        }

        /* 测速 */
        #locationTest {
            position: absolute;
            width: 255px;
            top: -2px;
            left: 0px;
            height: 88px;
            background: #fff;
            border: 1px solid #b7c2c9;
            display:;
            margin-bottom: 200px;
            height: 79px;
            overflow: hidden;
            display: none;
        }

        .locationTestTitle {
            width: 255px;
            height: 26px;
            line-height: 26px;
            position: relative;
            color: #555;
            text-indent: 10px;
            background-position: 0 -10px;
            border-bottom: 1px solid #f1f3f5;
        }

        .locationTestTitle h4 {
            margin: 0;
            font-size: 12px;
        }

        .locationTestTitleClose {
            height: 8px;
            width: 8px;
            overflow: hidden;
            display: block;
            position: absolute;
            right: 6px;
            top: 7px;
            background-position: -224px -112px
        }

        .locationTestTitleClose:hover {
            background-position: -208px -112px
        }

        .locationTestEach {
            display: inline-block;
            width: 5em;
            font-family: verdana;
            color: #848585;
        }

        .locationTestList li {
            padding: 2px;
            float: left;
            display: inline-block;
        }

        .locationTestList .servSelected {
            background-position: -248px -50px;
            background-repeat: no-repeat;
        }

        .locationTestList li a {
            height: 38px;
            width: 80px;
            display: block;
            line-height: 16px;
            padding-top: 10px;
            overflow: hidden;
            text-align: center;
            color: #000;
        }

        .locationTestList li a:hover {
            background-color: #eef3f8;
        }

        #selectLocation {
            text-align: center;
        }

        #locationTestCur {
            width: 3em;
        }

        #selectLocationTipsDone {
            display: none;
        }

        .locationTestBest {
            display: none;
            color: green;
        }

        .locationChoose {
            text-decoration: underline;
            color: #005590;
        }

        #themeArea {
            width: 240px;
            height: 80px;
            position: absolute;
            left: 90px;
            top: 134px;
        }

        /* 首页评分 */
        #scoreIndex {
            position: absolute;
            right: 90px;
            bottom: 0px;
            font-size: 12px;
            color: #9c9c9c;
            padding: 3px 6px 3px 6px;
            border: 1px solid #ced9dd;
            border-bottom: none;
            background: #fff;
            display: block;
            line-height: normal;
            border-radius: 2px 2px 0 0;
            z-index: 9;
            display: none;
        }

        #scoreIndex:hover {
            color: #666
        }

        #scoreIndexPop {
            left: 50%;
            top: 50%;
            margin-left: -231px;
            margin-top: -115px;
            width: 462px;
            position: absolute;
            z-index: 999;
            overflow: hidden;
            display: none;
            height: 229px;
            background: #fff;
        }

        #scoreIndexPopIfm {
            width: 462px;
            height: 229px;
        }

        /* */
        .bg2012btn {
            height: 22px;
            width: 22px;
            overflow: hidden;
            position: absolute;
            left: 10px;
            top: 54px;
            background: #fff;
            z-index: 99;
            border-radius: 8px;
            font-size: 12px;
            text-align: center;
            line-height: 22px;
            filter: alpha(opacity=50);
            -moz-opacity: 0.5;
            opacity: 0.5;
        }

        .bg2012btn-on {
            filter: alpha(opacity=100);
            -moz-opacity: 100;
            opacity: 100;
        }

        .footer {
            margin: 0;
        }

        .placeholder {
            background: url("login/startpage-1231.$5800.png") no-repeat scroll 0 0 transparent;
            display: block;
            float: left;
            height: 30px;
            margin: 0px 0 0 10px;
            background-position: 0 -190px;
            padding-left: 15px;
        }

        #pwdPlaceholder {
            background-position: 0 -291px;
        }

        .content {
            background: url(bg.png) repeat-x;
        }
    </style>
</head>
<body style="padding-top: 0px; ">
<div class="content">
    <div class="header"><a href="login.jsp"><img src="login/LOGO.png"/></a> <a href="#" class="blacktop"
                                                                               style="display:none;">返回首页</a></div>
    <div class="main" id="mainBg"
         style="background-image: url(login/a.jpg); background-position: 0% 0%; background-repeat: no-repeat no-repeat; ">
        <div class="main-inner" id="mainCnt">
            <div id="theme" style="">
                <div id="themeArea"
                     style="cursor: default; width: 900px; height: 440px; right: 0px; left: auto; top: 0px; z-index: 1; ; "></div>
                <a href="javascript:void(0)"
                   style="height: 28px; display: block; position: absolute; z-index: 2; width: 46px; left: 222px; top: 83px; "></a><a
                    href="javascript:void(0)"
                    style="height: 28px; display: block; position: absolute; z-index: 2; width: 56px; left: 52px; top: 129px; "></a><a
                    href="javascript:void(0)"
                    style="height: 28px; display: block; position: absolute; z-index: 2; width: 60px; left: 27px; top: 238px; "></a><a
                    href="javascript:void(0)"
                    style="height: 28px; display: block; position: absolute; z-index: 2; width: 60px; left: 114px; top: 385px; "></a>
            </div>
            <div id="loginBlock" class="login tab-1">
                <div class="loginFunc">
                    <div id="lbNormal" class="loginFuncNormal">管理账号登陆</div>
                    <div id="lbMob" class="loginFuncMobile"></div>
                </div>
                <div class="loginForm">
                    <form id="login163" name="login163" method="post" action="login_action.jsp">
                        <input type="hidden" id="savelogin" name="savelogin" value="0">
                        <input type="hidden" id="url2" name="url2" value="http://mail.163.com/errorpage/err_163.htm">

                        <div id="Div1"
                             class="loginFormIpt showPlaceholder showPlaceholder showPlaceholder showPlaceholder showPlaceholder">
                            <input class="loginFormTdIpt" tabindex="2" title="请输入账号" id="Password1" name="user_name"
                                   type="text"/>
                            <label for="pwdInput" class="placeholder" id="Label1">账号</label>
                        </div>
                        <div class="forgetPwdLine"></div>
                        <div id="pwdInputLine"
                             class="loginFormIpt showPlaceholder showPlaceholder showPlaceholder showPlaceholder showPlaceholder">
                            <input class="loginFormTdIpt" tabindex="2" title="请输入密码" id="pwdInput" name="user_pwd"
                                   type="password"/>
                            <label for="pwdInput" class="placeholder" id="pwdPlaceholder">密码</label>
                        </div>
                        <div class="loginFormIpt loginFormIptWiotTh">
                            <button id="loginBtn" class="btn btn-login" tabindex="6" type="submit">登&nbsp;录</button>
                        </div>
                    </form>
                    <div class="ext" id="loginExt">
                        <div id="extVerSelect"><a href="http://ipad.mail.163.com/index.htm?dv=ipad">适配iPad版本</a>&nbsp;|&nbsp;<a
                                href="http://smart.mail.163.com/index.htm?dv=smart">手机智能版</a>&nbsp;|&nbsp;电脑版
                        </div>
                        <div id="extMobLogin">
                            <h3>为什么要用手机号登录？</h3>
                            <ul>
                                <li>好友可直接发邮件到<span class="ne-txt-song">“</span>你的手机号@163.com<span
                                        class="ne-txt-song">”</span></li>
                                <li>设置后，即可发送2G超大附件</li>
                            </ul>
                        </div>
                        <div id="extMobLogin2">
                            <button class="btn btn-moblogin2" id="extBtnMoblogin" type="button">还没设置手机号登录？</button>
                            <div class="setMobLoginInfo">设置后，可用手机号直接登录邮箱（完全免费）</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div style="position:absolute;top:25px; right:20px;"><img src="login/LOGO2.png"></div>
</div>
<p style="margin-top:20px; color:#999;">技术支持：江西怡杉环保有限公司</p>
</body>
</html>
