/*
Duosi Principles of Computer Composition Virtual Experiment System ,DS-VLAB v1.0
Copyright(C)2013 ZHANG Wen-fen, Email: yydzhwf@163.com  Address: Xiangnan University, Chenzhou Hunan, China
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.

多思计算机组成原理网络虚拟实验系统, DS-VLAB v1.0 
版权所有(C) 张雯雰, 电子邮箱: yydzhwf@163.com
本程序为自由软件；您可依据自由软件基金会所发表的GNU GENERAL PUBLIC LICENSE，对本程序再次发布和/或修改。

作者：湘南学院软件与通信工程学院张雯雰老师
*/



function toolbarInit() {
    $("#toolbox").css("visibility", "visible");
    $("#tools").bind("click", function () {
        var $content = $("#toolbox");
        var visiAttr = $content.css("visibility");
        if (visiAttr == "visible") {
            $content.css("visibility", "hidden");
        } else {
            $content.css("visibility", "visible");
        }
    });

    $("#power").bind("click", function () {
        var imgSrc = $(this).attr("src");
        if (imgSrc == "./img/poweroff.png") {
            $(this).attr("src", "./img/poweron.png");
            cDispatch.powerOn();
        };
        if (imgSrc == "./img/poweron.png") {
            $(this).attr("src", "./img/poweroff.png");
            cDispatch.powerOff();
        };
    });

    $("#reset").bind("mousedown", function () {
        if ($("#power").attr("src") == "./img/poweron.png") {
            $(this).attr("src", "./img/resetdown.png");
        }
    });
    $("#reset").bind("mouseup", function () {
        if ($("#power").attr("src") == "./img/poweron.png") {
            $(this).attr("src", "./img/reset.png");
            cDispatch.powerOff();
            cDispatch.powerOn();
        }
    });

    $("#new").bind("click", function () {
        //window.location.reload();
        mycircuit.deletecircuit();
    });


    //当鼠标移动到按钮上时，按钮外框变绿色，移开时变白色。
    $("#tools").mouseenter(function () {
        $(this).css("border-color", "green");
    });
    $("#tools").mouseleave(function () {
        $(this).css("border-color", "white");
    });

    $("#reset").mouseenter(function () {
        $(this).css("border-color", "green");
    });
    $("#reset").mouseleave(function () {
        $(this).css("border-color", "white");
    });

    $("#power").mouseenter(function () {
        $(this).css("border-color", "green");
    });
    $("#power").mouseleave(function () {
        $(this).css("border-color", "white");
    });

    $("#new").mouseenter(function () {
        $(this).css("border-color", "green");
    });
    $("#new").mouseleave(function () {
        $(this).css("border-color", "white");
    });
};


