/*
Duosi Principles of Computer Composition Virtual Experiment System ,DS-VLAB v1.0
Copyright(C)2013 ZHANG Wen-fen, Email: yydzhwf@163.com  Address: Xiangnan University, Chenzhou Hunan, China
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.

多思计算机组成原理网络虚拟实验系统, DS-VLAB v1.0 
版权所有(C) 张雯雰, 电子邮箱: yydzhwf@163.com
本程序为自由软件；您可依据自由软件基金会所发表的GNU GENERAL PUBLIC LICENSE，对本程序再次发布和/或修改。

作者：湘南学院软件与通信工程学院张雯雰老师
*/



function menuInit () {
    navHover = function () {
        var lis = document.getElementById("navmenu").getElementsByTagName("LI");
        for (var i = 0; i < lis.length; i++) {
            lis[i].onmouseover = function () {
                this.className += " iehover";
            }
            lis[i].onmouseout = function () {
                this.className = this.className.replace(new RegExp(" iehover\\b"), "");
            }
        }
    }
    if (window.attachEvent) window.attachEvent("onload", navHover);
};


;
$(function () {
    $("#poweron").click(function () {
        if ($("#power").attr("src") == "./img/poweroff.png") {
            $("#power").attr("src", "./img/poweron.png");
            cDispatch.powerOn();
        };
    });
    $("#poweroff").click(function () {
        if ($("#power").attr("src") == "./img/poweron.png") {
            $("#power").attr("src", "./img/poweroff.png");
            cDispatch.powerOff();
        };
    });
    $("#powerreset").click(function () {
        if ($("#power").attr("src") == "./img/poweron.png") {
            cDispatch.powerOff();
            cDispatch.powerOn();
        };
    });

    $("#clockcycle").click(function () {
        $("#clockdlg").dialog({
            modal: true,
            height: 220,
            width: 300,
            buttons: [
                {
                    text: "OK",
                    click: function () {
                        cDispatch.pulseWidth = $("#clocksld").slider("value");
                        $(this).dialog("close");
                    }
                }
            ]
        });

        var c = cDispatch.pulseWidth;
        $("#clocksld").slider({
            range: "min",
            value: c,
            min: 100,
            max: 800,
            slide: function (event, ui) {
                $("#amount").val("$" + ui.value);
            }
        });

    });

    $("#aboutdlg").dialog({
         autoOpen: false,
         modal: true,
         height: 340,
         width: 460,
    });

    $("#about").click(function () {
         $( "#aboutdlg" ).dialog( "open" );
    });


});


