/*
Duosi Principles of Computer Composition Virtual Experiment System ,DS-VLAB v1.0
Copyright(C)2013 ZHANG Wen-fen, Email: yydzhwf@163.com  Address: Xiangnan University, Chenzhou Hunan, China
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.

多思计算机组成原理网络虚拟实验系统, DS-VLAB v1.0 
版权所有(C) 张雯雰, 电子邮箱: yydzhwf@163.com
本程序为自由软件；您可依据自由软件基金会所发表的GNU GENERAL PUBLIC LICENSE，对本程序再次发布和/或修改。

作者：湘南学院软件与通信工程学院张雯雰老师
*/



function Circuit() {
    this.componentAll = [];  //已画出的实验器件列表(不包括已删除的）
    this.count = 0;   //器件计数，包括已删除的器件，用于生成器件id
    this.linecolor = "yellow";
    var targetPin = null;  //拉连接线时的目标引脚
    var _this = this;
    

    //在给定div（parentId）的指定位置（offsetX, offsetY）处画出实验器件（componentName）
    this.addComponent = function (parentId, componentName, offsetX, offsetY, componentId) {
        var component = new window[componentName]();
        if (componentId == null) {
            component.id = "CP" + String(this.count);
        } else {
            component.id = componentId;
        };
        this.count = this.count + 1;
        _this.componentAll.push(component);
        var compDiv = document.createElement("div");
        compDiv.id = component.id;
        compDiv.style.position = "absolute";
        compDiv.style.left = offsetX + "px";           
        compDiv.style.top = offsetY+ "px";
        compDiv.style.width = component.width + "px";
        compDiv.style.height = component.height + "px";
        compDiv.style.zIndex = 3000 + this.count;
        $("#" + parentId).append(compDiv);

        if (component.image != "") {
            compDiv.style.backgroundImage = "url(" + component.image + ")";
        };
        if (component.showBorder == true && component.showName == false) {
            compDiv.className = "window2";
        };
        if (component.showBorder == true && component.showName == true) {
            var underDiv = document.createElement("div");
            underDiv.id = component.id + "UnderLayer";
            underDiv.className = "window";
            underDiv.style.left = "0px";
            underDiv.style.top = "0px";
            underDiv.style.width = component.width + "px";
            underDiv.style.height = component.height + "px";
            underDiv.style.lineHeight = component.height + "px";
            underDiv.innerHTML = "<strong>" + component.name + "</strong>";
            $("#" + compDiv.id).append(underDiv);
        };

        //画出所有引脚
        var pinDiv, pn, pinFun;
        for (var i = 0; i < component.pinName.length; i++) {
            pinDiv = document.createElement("div");
            pinDiv.id = compDiv.id + "Pin" + i;
            pinDiv.className = "pin";
            pn=component.pinName[i];
            if (pn=="") {
                pinDiv.style.width = component.pinWidth + "px";
            } else {
                pinDiv.style.width = component.pinWidth + 2 + "px"; //让引脚间部分重叠，字好看些
            };
            pinDiv.style.height = component.pinHeight + "px";
            pinDiv.style.left = component.paddingLR + (component.width - component.paddingLR * 2) * component.pinPosition[i][0] + "px";
            if (component.pinPosition[i][1] == 1) {
                if (component.showBorder == true) {
                    pinDiv.style.top = component.height - component.pinHeight + "px";
                } else {
                    pinDiv.style.top = component.height - component.pinHeight-1 + "px";
                };
                if (pn != "" && component.showPinNo != false) pinDiv.innerHTML = pn + "<br>" + i;
                if (pn != "" && component.showPinNo == false) pinDiv.innerHTML = pn ;
            };
            if (component.pinPosition[i][1] == 0) {
                pinDiv.style.top = 0 + "px";
                if (pn != "" && component.showPinNo != false) pinDiv.innerHTML = i + "<br>" + pn;
                if (pn != "" && component.showPinNo == false) pinDiv.innerHTML = pn;
            };
            pinFun = component.pinFunction[i];
            if (pinFun == 10 || pinFun == 0) {   //如果是输入引脚
                pinDiv.style.color = "#003C9D";
                $(pinDiv).bind("mousedown", doNone);
                $(pinDiv).bind("mouseenter", function () { targetPin = this;});
                $(pinDiv).bind("mouseleave", function () { targetPin = null;});
            };
            if (pinFun == 1) {   //如果是输出引脚
                pinDiv.style.color = "green";
                $(pinDiv).bind("mousedown", lineDrag);
            };
            if (pinFun == 11) {   //如果是输入/输出引脚
                pinDiv.style.color = "#b200ff";
                $(pinDiv).bind("mouseenter", function () { targetPin = this; });
                $(pinDiv).bind("mouseleave", function () { targetPin = null; });
                $(pinDiv).bind("mousedown", lineDrag);
            };
            if (pinFun >= 2) {   //如果是其它引脚
                $(pinDiv).bind("mousedown", doNone);
            };

            pinDiv.onselectstart = function () { return false; };//不让div中的文字被选中

            $("#" + compDiv.id).append(pinDiv);
        };

        dragEnabled(compDiv.id);
        $(compDiv).bind("mousedown", deleteC);
        if(component.name=="Switch")
            $(compDiv).bind("mousedown", switchClick);
        if (component.name == "SinglePulse")
            $(compDiv).bind("mousedown", singlePulseClick);

        if (pn != "" && component.showPinNo != false)
            $(compDiv).bind("dblclick", showPinValue);
    };     





    //生成一条连接线
    this.lineCreate=function (paintDiv, fromX, fromY, toX, toY) {
        var newLine = document.createElement("v:shape");
        var path = "m " + fromX + "," + fromY + " l " + toX + "," + toY + " e";
        newLine.setAttribute("class","line");
        newLine.setAttribute("filled", "f");
        newLine.setAttribute("coordsize", "100,100");
        newLine.setAttribute("strokecolor",_this.linecolor);
        newLine.setAttribute("path", path);
        newLine.innerHTML = "<v:Stroke endarrow=\"classic\"/>";
        $("#" + paintDiv).append(newLine);
        $(newLine).bind("mousedown", deleteL);
        newLine.onmouseover = lineOver;
        newLine.onmouseout = lineOut;
        return newLine;
    };

    //生成连接线时，从起始点往目标点拖动的过程中，线的变化
    function lineChange(line, fromX, fromY, toX, toY) {
        var p1X, p1Y, p2X, p2Y;
        if (Math.abs(fromX - toX) > Math.abs(fromY - toY)) {
            p1X = fromX + Math.round((toX - fromX) / 2);
            p1Y = fromY;
            p2X = fromX + Math.round((toX - fromX) / 2);
            p2Y = toY;
            if (fromX > toX) { toX = toX + 7 }
            else { toX = toX - 7 };
        } else {
            p1X = fromX;
            p1Y = fromY + Math.round((toY - fromY) / 2);
            p2X = toX;
            p2Y = fromY + Math.round((toY - fromY) / 2);
            if (fromY > toY) { toY = toY + 7 }
            else { toY = toY - 7 };
        };
        line.path = "m " + fromX + "," + fromY + " l " + p1X + "," + p1Y + "," + p2X + "," + p2Y + "," + toX + "," + toY + " e";
    };

    //生成连接线时，鼠标到达目标引脚后，调整、定位连接线；拖动器件时，调整连接线
    this.lineAdjust = function (line, startPin, endPin) {
        var sX, sY, eX, eY;
        var st = startPin.offsetTop;
        var et = endPin.offsetTop;
        sX = startPin.parentNode.offsetLeft + startPin.offsetLeft + Math.round(startPin.offsetWidth / 2)-1;
        if (st < 2) sY = startPin.parentNode.offsetTop;
        else sY = startPin.parentNode.offsetTop + startPin.parentNode.offsetHeight;
        eX = endPin.parentNode.offsetLeft + endPin.offsetLeft + Math.round(endPin.offsetWidth / 2)-1;
        if (et < 2) eY = endPin.parentNode.offsetTop;
        else eY = endPin.parentNode.offsetTop + endPin.parentNode.offsetHeight;

        if (eY - sY > 10 && st > 1 && et < 2) {
            var p1X = sX;
            var p1Y = sY + Math.round((eY - sY) / 2);
            var p2X = eX;
            var p2Y = sY + Math.round((eY - sY) / 2);
            line.path = "m " + sX + "," + sY + " l " + p1X + "," + p1Y + "," + p2X + "," + p2Y + "," + eX + "," + eY + " e";
        };
        if (eY - sY < 10 && st > 1 && et < 2) {
            var p1X = sX;
            var p1Y = sY + 30;
            var p2X = sX + Math.round((eX - sX) / 2);
            var p2Y = sY + 30;
            var p3X = p2X;
            var p3Y = eY - 30;
            var p4X = eX;
            var p4Y = eY - 30;
            line.path = "m " + sX + "," + sY + " l " + p1X + "," + p1Y + "," + p2X + "," + p2Y + "," + p3X + "," + p3Y + "," + p4X + "," + p4Y + "," + eX + "," + eY + " e";
        };
        if (st > 1 && et >1) {
            var p1X = sX;
            if (eY > sY) {
                var p1Y = eY + 30;
                var p2Y = eY + 30;
            } else {
                var p1Y = sY + 30;
                var p2Y = sY + 30;
            };
            var p2X = eX;
            line.path = "m " + sX + "," + sY + " l " + p1X + "," + p1Y + "," + p2X + "," + p2Y + "," + eX + "," + eY + " e";
        };
        if (st <2 && et <2) {
            var p1X = sX;
            if (eY > sY) {
                var p1Y = sY - 30;
                var p2Y = sY - 30;
            } else {
                var p1Y = eY - 30;
                var p2Y = eY - 30;
            };
            var p2X = eX;
            line.path = "m " + sX + "," + sY + " l " + p1X + "," + p1Y + "," + p2X + "," + p2Y + "," + eX + "," + eY + " e";
        };
        if (sY - eY > 10 && st <2 && et>1) {
            var p1X = sX;
            var p1Y = sY - Math.round((sY -eY ) / 2);
            var p2X = eX;
            var p2Y = sY - Math.round((sY - eY) / 2);
            line.path = "m " + sX + "," + sY + " l " + p1X + "," + p1Y + "," + p2X + "," + p2Y + "," + eX + "," + eY + " e";
        };
        if (sY - eY < 10 && st<2 && et >1) {
            var p1X = sX;
            var p1Y = sY - 30;
            var p2X = sX + Math.round((eX - sX) / 2);
            var p2Y = sY - 30;
            var p3X = p2X;
            var p3Y = eY + 30;
            var p4X = eX;
            var p4Y = eY + 30;
            line.path = "m " + sX + "," + sY + " l " + p1X + "," + p1Y + "," + p2X + "," + p2Y + "," + p3X + "," + p3Y + "," + p4X + "," + p4Y + "," + eX + "," + eY + " e";
        };
    };



    //输出引脚的鼠标事件
    function lineDrag(a) {
        window.event.cancelBubble = true;  //禁止事件冒泡到下一层
        if (!a) a = window.event;
        var d = document;
        var sTop = Math.max(d.body.scrollTop, d.documentElement.scrollTop);
        var sLeft = Math.max(d.body.scrollLeft, d.documentElement.scrollLeft);
        var ox = a.clientX + sLeft, oy = a.clientY + sTop;
        var line = _this.lineCreate("demo", ox, oy, ox, oy);
        targetPin = null;
        var originPin = this;

        d.onmousemove = function (a) {
            if (!a) a = window.event;
            var sTop = Math.max(d.body.scrollTop, d.documentElement.scrollTop);
            var sLeft = Math.max(d.body.scrollLeft, d.documentElement.scrollLeft);
            if (targetPin == null) {  //鼠标还没到达目标点时
                lineChange(line, ox, oy, a.clientX + sLeft, a.clientY + sTop);
            } else { //鼠标已进入目标引脚时
                _this.lineAdjust(line, originPin, targetPin);
            }
        }

        d.onmouseup = function () {
            if (targetPin == null) {//如果没有进入任何目标引脚                   待修改：还应该检查目标引脚是否已经被连接了
                line.removeNode(true);
            } else {
                _this.lineAdjust(line, originPin, targetPin);
                _this.addLineToComponent(line, originPin, targetPin);
            };
            d.onmousemove = null;
            d.onmouseup = null;

        }
    };


    //输入引脚和其它引脚的mousedown事件
    function doNone(a) {
        window.event.cancelBubble = true;  //禁止事件冒泡到下一层
    };

    //根据id从componentAll中找到匹配的器件
    this.findById=function(Id) {
        for (var i = 0 ; i < _this.componentAll.length; i++) {
            if (_this.componentAll[i].id == Id)
                return _this.componentAll[i];
        };
        return 0;
    };

    //根据id从componentAll中找到匹配的器件并删除
    function deleteById(Id) {
        for (var i = 0 ; i < _this.componentAll.length; i++) {   
            if (_this.componentAll[i].id == Id) {
                _this.componentAll[i]=null;
                _this.componentAll.splice(i, 1);
                return 1;
            };    
        };
        return 0;
    };


    //把连接线信息保存到器件对象中,设置line.id
    this.addLineToComponent = function (line, startPin, endPin) {
        var sPId, ePId, sCId, sPNo, eCId, ePNo, p;
        sPId = startPin.id;     
        p= sPId.indexOf("Pin");
        sCId = sPId.substring(0, p);//获取起始引脚的器件ID
        sPNo = sPId.substring(p + 3);//获取起始引脚的编号
        ePId = endPin.id;
        p = ePId.indexOf("Pin");
        eCId = ePId.substring(0, p);
        ePNo = ePId.substring(p + 3);
        var sc = _this.findById(sCId);
        sc.connection[sPNo].push([line, startPin, endPin]);
        var ec = _this.findById(eCId);
        ec.connection[ePNo].push([line, startPin, endPin]);
        line.id = sPId + "To" + ePId;
    };

    //拖动器件c时，更新其所有连接线
    this.lineReplace=function(c) {
        var comp = _this.findById(c.id);
        var i, j, l, s, e;
        for (i = 0; i < comp.connection.length; i++) {
            for (j = 0; j < comp.connection[i].length; j++) {
                l = comp.connection[i][j][0];
                s = comp.connection[i][j][1];
                e = comp.connection[i][j][2];
                _this.lineAdjust(l, s, e);
            };
        };     
    };


    //删除连接线
    function lineDelete(line) {
        var lId, sPId, ePId, sCId, sPNo, eCId, ePNo, p,i;
        lId = line.id;
        p = lId.indexOf("To");
        sPId = lId.substring(0, p);
        ePId = lId.substring(p+2);
        p = sPId.indexOf("Pin");
        sCId = sPId.substring(0, p);//获取起始引脚的器件ID
        sPNo = sPId.substring(p + 3);//获取起始引脚的编号
        p = ePId.indexOf("Pin");
        eCId = ePId.substring(0, p);
        ePNo = ePId.substring(p + 3);
        var sc = _this.findById(sCId);
        for (i = 0; i < sc.connection[sPNo].length; i++) {
            if (sc.connection[sPNo][i][0] == line) {
                sc.connection[sPNo].splice(i, 1);
                break;
            };
        };
        var ec = _this.findById(eCId);
        for (i = 0; i < ec.connection[ePNo].length; i++) {
            if (ec.connection[ePNo][i][0] == line) {
                ec.connection[ePNo].splice(i, 1);
                break;
            };
        };
        line.removeNode(true);
    };

    //右击删除连接线的鼠标事件
    function deleteL(a) {
        if (!a) a = window.event;
        if (a.button == 2) {
            var r = confirm("是否要删除连接线？");
            if (r == true) {
                lineDelete(this);
            };
        };
    };

    /*鼠标掠过连接线的事件*/
    function lineOver() {
        this.strokecolor = "red";
        this.strokeweight = 3;
    };
    function lineOut() {
        this.strokecolor = _this.linecolor;
        this.strokeweight = 1;
    };

    //删除器件以及与器件相连的所有连接线
    function componentDelete(c) {
        var i, j;
        var comp = _this.findById(c.id);
        for (i = 0; i < comp.connection.length; i++) {
            for (j = 0; j < comp.connection[i].length; ) {
                lineDelete(comp.connection[i][j][0]);
            };
        };
        deleteById(c.id);
        c.removeNode(true);

    };

    //右击删除器件及其连接线的鼠标事件
    function deleteC(a) {
        if (!a) a = window.event;
        if (a.button == 2) {
            var r = confirm("是否要删除元器件及其连接线？");
            if (r == true) {
                componentDelete(this);
            };
        };
    };


    //双击器件显示所有引脚的值
    function showPinValue() {
        var s = "";
        var comp = _this.findById(this.id);
        var len = comp.pinValue.length;
        var w = 220;
        var i;
        if (len > 20) w = len*10;
        for (i = len - 1; i >= len / 2; i--) {
            s = s + comp.pinValue[i] + "&nbsp;&nbsp;&nbsp;";
        };
        s = s + "<br/>";
        for (i = len - 1; i >= len / 2; i--) {
            if (i < 10) {
                s = s + i + "&nbsp;&nbsp;&nbsp;";
            } else {
                s = s + i + " ";
            };
        };
        s = s + "<br/>";
        for (i = 0; i < len / 2; i++) {
            if (i < 10) {
                s = s + i + "&nbsp;&nbsp;&nbsp;";
            } else {
                s = s + i + " ";
            };
        };
        s = s + "<br/>";
        for (i = 0; i < len / 2; i++) {
            s = s + comp.pinValue[i] + "&nbsp;&nbsp;&nbsp;";
        };        
      
        s = "<p>" + s + "</p>";
        dialog.innerHTML =s;
        $("#dialog").dialog({
            modal: true,
            height: 220,
            width: w,
            buttons: [
                {
                    text: "OK",
                    click: function () {
                        $(this).dialog("close");
                    }
                }
            ]
        });

    };


    /*开关的鼠标单击事件*/
    function switchClick(a) {
        var moveFlag = false;
        var d = document;
        var me = this;

        $(this).bind("mousemove",mm);
        $(this).bind("mouseup", mup);
         
        function mm() {
            moveFlag = true;
        };

        function mup() {
            if (!moveFlag) {
                var imgSrc = me.style.backgroundImage;            
                var c = _this.findById(me.id);
                if (imgSrc == "url(\"./img/switchL.gif\")" || imgSrc=="url(./img/switchL.gif)") {
                    me.style.backgroundImage = "url(./img/switchH.gif)";
                };
                if (imgSrc == "url(\"./img/switchH.gif\")" || imgSrc=="url(./img/switchH.gif)") {
                    me.style.backgroundImage = "url(./img/switchL.gif)";                
                };
                if (cDispatch.runState == 1) {
                    cDispatch.sourceTrigger(c);
                } else {
                    c.input();
                };
            };

            $(me).unbind("mousemove", mm);
            $(me).unbind("mouseup", mup);
        };
    };
 
    /*单脉冲器件的鼠标单击事件*/
    function singlePulseClick(a) {
        var moveFlag = false;
        var d = document;
        var me = this;

        $(this).bind("mousemove", mm);
        $(this).bind("mouseup", mup);

        function mm() {
            moveFlag = true;
        };

        function mup() {
            if (!moveFlag) {
                var c = _this.findById(me.id);
                if (cDispatch.runState == 1 && c.timer==null) {
                    cDispatch.sourceTrigger(c);
                };
            };

            $(me).unbind("mousemove", mm);
            $(me).unbind("mouseup", mup);
        };
    };

    this.linecolorchange = function (c) {
        var x = document.getElementsByClassName("line");
        for (var i = 0; i < x.length; i++) {
            x[i].strokecolor =c;
        };
    };

    this.deletecircuit = function () {
        var c;
        if ($("#power").attr("src") == "./img/poweron.png") {
            $("#power").attr("src", "./img/poweroff.png");
            cDispatch.powerOff();
        };

        for (var i = 0; _this.componentAll.length>0 ; i) {
            c = document.getElementById(_this.componentAll[i].id); 
            componentDelete(c);
        };
        
        this.count = 0;   //器件计数，包括已删除的器件，用于生成器件id
        var targetPin = null;  //拉连接线时的目标引脚
    };

   
};


