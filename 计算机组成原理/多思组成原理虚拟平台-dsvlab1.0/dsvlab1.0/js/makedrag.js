/*
Duosi Principles of Computer Composition Virtual Experiment System ,DS-VLAB v1.0
Copyright(C)2013 ZHANG Wen-fen, Email: yydzhwf@163.com  Address: Xiangnan University, Chenzhou Hunan, China
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.

多思计算机组成原理网络虚拟实验系统, DS-VLAB v1.0 
版权所有(C) 张雯雰, 电子邮箱: yydzhwf@163.com
本程序为自由软件；您可依据自由软件基金会所发表的GNU GENERAL PUBLIC LICENSE，对本程序再次发布和/或修改。

作者：湘南学院软件与通信工程学院张雯雰老师
*/




//此函数使对象能够被拖动  o:对象ID  s:是否随屏幕滚动而移动
function dragEnabled(o, s) {
    if (typeof o == "string") o = document.getElementById(o);
    o.orig_x = parseInt(o.style.left) - document.documentElement.scrollLeft;
    o.orig_y = parseInt(o.style.top) - document.documentElement.scrollTop;
    o.orig_index = o.style.zIndex;


    o.onmousedown = function (a) {
        //       this.style.cursor = "move";
        if (!a) a = window.event;
        if ($.browser.msie && $.browser.version == "8.0" && a.button == 1 || $.browser.msie && $.browser.version != "8.0" && a.button == 0) {    //如果单击的左键
            this.style.zIndex = 10000;
            var d = document;
            var x = a.clientX + d.documentElement.scrollLeft - o.offsetLeft;
            var y = a.clientY + d.documentElement.scrollTop - o.offsetTop;

            /*d.ondragstart = "return false;"
            d.onselectstart = "return false;"
            d.onselect = "document.selection.empty();"*/

            if (o.setCapture)
                o.setCapture();
            else if (window.captureEvents)
                window.captureEvents(Event.MOUSEMOVE | Event.MOUSEUP);

            d.onmousemove = function (a) {
                if (!a) a = window.event;
                o.style.left = a.clientX + d.documentElement.scrollLeft - x + "px";
                o.style.top = a.clientY + d.documentElement.scrollTop - y + "px";
                o.orig_x = parseInt(o.style.left) - document.documentElement.scrollLeft;
                o.orig_y = parseInt(o.style.top) - document.documentElement.scrollTop;
                mycircuit.lineReplace(o);
            }

            d.onmouseup = function () {
                if (o.releaseCapture)
                    o.releaseCapture();
                else if (window.captureEvents)
                    window.captureEvents(Event.MOUSEMOVE | Event.MOUSEUP);
                d.onmousemove = null;
                d.onmouseup = null;
                /*d.ondragstart = null;
                d.onselectstart = null;
                d.onselect = null;
                o.style.cursor = "normal";*/
                o.style.zIndex = o.orig_index;
                mycircuit.lineReplace(o);
            }
        };
    };

    if (s) {
        var orig_scroll = window.onscroll ? window.onscroll : function () { };
        window.onscroll = function () {
            orig_scroll();
            o.style.left = o.orig_x + document.documentElement.scrollLeft;
            o.style.top = o.orig_y + document.documentElement.scrollTop;
        }
    };
};