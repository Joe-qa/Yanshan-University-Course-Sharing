/*
Duosi Principles of Computer Composition Virtual Experiment System ,DS-VLAB v1.0
Copyright(C)2013 ZHANG Wen-fen, Email: yydzhwf@163.com  Address: Xiangnan University, Chenzhou Hunan, China
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.

多思计算机组成原理网络虚拟实验系统, DS-VLAB v1.0 
版权所有(C) 张雯雰, 电子邮箱: yydzhwf@163.com
本程序为自由软件；您可依据自由软件基金会所发表的GNU GENERAL PUBLIC LICENSE，对本程序再次发布和/或修改。

作者：湘南学院软件与通信工程学院张雯雰老师
*/




function CompoLed() {
    this.id;    //此器件div的id与此id相同
    this.type = "d"; //source:数据源器件   intermediate:中间器件   destination:目的器件
    this.name = "Led";
    this.width = 17;
    this.height =26;
    this.image = "./img/ledoff.gif";
    this.paddingLR = 0;    //paddingLR：芯片左右边距   
    this.pinName = new Array("");
    this.pinWidth = (this.width - this.paddingLR * 2);    //引脚宽度不应小于16
    this.pinHeight = 10;
    this.showName = false; //是否在芯片上显示芯片名称
    this.showBorder =false;//是否显示外框

    //i:引脚间距    [x,y]：除掉边距之外，以芯片左上角为[0,0]、右下角为[1,1]的相对坐标
    var i = 1;
    this.pinPosition = new Array([i * 0, 1]);

    //引脚类型  0：输入  10:必要输入  1：输出  2：地  3：电源  4:其它
    this.pinFunction = new Array([10]);

    this.pinValue = new Array([2]);

    //引脚与其它引脚的连接线对象
    this.connection = new Array([]);
};

//判断目前芯片是否已达到运算条件
CompoLed.prototype.beReady = function () {
//    if (this.pinValue[0] == 2) {
//        return false;
//    }
    return true;
};

//设置输入引脚的值，并且判断目前芯片是否已达到运算条件
CompoLed.prototype.input = function (pinNo, value) {
    if (value == this.pinValue[pinNo]) return false; //如果输入的值没有变化，则无需重新计算
    this.pinValue[pinNo] = value;
    return this.beReady();
};

CompoLed.prototype.work = function () {
    var l=document.getElementById(this.id); 
    if (this.pinValue[0] == 1)
        l.style.backgroundImage = "url(./img/ledon.gif)";
    else
        l.style.backgroundImage = "url(./img/ledoff.gif)";
};

CompoLed.prototype.reset = function () {
    this.pinValue = [2];
    var l = document.getElementById(this.id);
    l.style.backgroundImage = "url(./img/ledoff.gif)";
};