/*
Duosi Principles of Computer Composition Virtual Experiment System ,DS-VLAB v1.0
Copyright(C)2013 ZHANG Wen-fen, Email: yydzhwf@163.com  Address: Xiangnan University, Chenzhou Hunan, China
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.

多思计算机组成原理网络虚拟实验系统, DS-VLAB v1.0 
版权所有(C) 张雯雰, 电子邮箱: yydzhwf@163.com
本程序为自由软件；您可依据自由软件基金会所发表的GNU GENERAL PUBLIC LICENSE，对本程序再次发布和/或修改。

作者：湘南学院软件与通信工程学院张雯雰老师
*/



function Compo74LS273() {
    this.id;    //此器件div的id与此id相同
    this.type = "i";  //source:数据源器件   intermediate:中间器件   destination:目的器件
    this.name = "74LS273";
    this.width = 160;
    this.height = 55;
    this.image = "";
    this.paddingLR = 5;    //paddingLR：芯片左右边距   
    this.pinName = new Array("-MR", "D7", "D6", "D5", "D4", "D3", "D2", "D1", "D0", "GND", "CP", "Q0", "Q1", "Q2", "Q3", "Q4", "Q5", "Q6", "Q7", "VCC");
    this.pinWidth = (this.width - this.paddingLR * 2) / 10;    //引脚宽度不应小于16
    this.pinHeight = 19;
    this.showName = true; //是否在芯片上显示芯片名称
    this.showBorder = true;//是否显示外框


    //i:引脚间距    [x,y]：除掉边距之外，以芯片左上角为[0,0]、右下角为[1,1]的相对坐标
    var i = 1 / 10;
    this.pinPosition = new Array([i * 0, 1], [i * 1, 1], [i * 2, 1], [i * 3, 1], [i * 4, 1], [i * 5, 1], [i * 6, 1], [i * 7, 1], [i * 8, 1], [i * 9, 1],
                       [i * 9, 0], [i * 8, 0], [i * 7, 0], [i * 6, 0], [i * 5, 0],
                       [i * 4, 0], [i * 3, 0], [i * 2, 0], [i * 1, 0], [i * 0, 0]);

    //引脚类型  0：输入  10:必要输入  1：输出  2：地  3：电源  
    this.pinFunction = new Array(10, 0, 0, 0, 0, 0, 0, 0, 0, 2, 10, 1, 1, 1, 1, 1, 1, 1, 1, 3);

    this.pinValue = new Array(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2);

    //引脚与其它引脚的连接线对象
    this.connection = new Array([], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], []);
};

//判断目前芯片是否已达到运算条件(是否所有的必要输入都已经有输入值)
Compo74LS273.prototype.beReady = function () {
    for (var i = 0; i < this.pinFunction.length; i++) {
        if (this.pinFunction[i] == 10 && this.pinValue[i] == 2) {
            return false;
        }
    };
    return true;
};

//设置输入引脚的值，并且判断目前芯片是否已达到运算条件
Compo74LS273.prototype.input = function (pinNo, value) {
    if (value == this.pinValue[pinNo]) return false; //如果输入的值没有变化，则无需重新计算
    var oldv = this.pinValue[pinNo];
    this.pinValue[pinNo] = value;
    if (pinNo == 0 && value==0) return true;        
    if (pinNo == 10 && oldv == 0 && value == 1 && this.pinValue[0] == 1) {
        return this.beReady();
    } else {
        return false;
    };
};

Compo74LS273.prototype.work = function () {
    var i;
    if (this.pinValue[0] == 0) {
        for (i = 1; i <= 8; i++) this.pinValue[19-i] =0;
    } else {
        for (i = 1; i <= 8; i++) this.pinValue[19 - i] = this.pinValue[i];
    }
};

Compo74LS273.prototype.reset = function () {
    this.pinValue = [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2];
};