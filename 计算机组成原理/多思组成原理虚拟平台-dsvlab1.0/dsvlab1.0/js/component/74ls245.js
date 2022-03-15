/*
Duosi Principles of Computer Composition Virtual Experiment System ,DS-VLAB v1.0
Copyright(C)2013 ZHANG Wen-fen, Email: yydzhwf@163.com  Address: Xiangnan University, Chenzhou Hunan, China
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.

多思计算机组成原理网络虚拟实验系统, DS-VLAB v1.0 
版权所有(C) 张雯雰, 电子邮箱: yydzhwf@163.com
本程序为自由软件；您可依据自由软件基金会所发表的GNU GENERAL PUBLIC LICENSE，对本程序再次发布和/或修改。

作者：湘南学院软件与通信工程学院张雯雰老师
*/



function Compo74LS245() {
    this.id;    //此器件div的id与此id相同
    this.type = "i";  //source:数据源器件   intermediate:中间器件   destination:目的器件
    this.name = "74LS245";
    this.width = 160;
    this.height = 55;
    this.image = "";
    this.paddingLR = 5;    //paddingLR：芯片左右边距   
    this.pinName = new Array("DIR","A7", "A6", "A5", "A4", "A3", "A2", "A1", "A0",  "GND",  "B0", "B1", "B2", "B3", "B4", "B5", "B6","B7", "-E", "VCC");
    this.pinWidth = (this.width - this.paddingLR * 2) / 10;    //引脚宽度不应小于16
    this.pinHeight = 19;
    this.showName = true; //是否在芯片上显示芯片名称
    this.showBorder = true;//是否显示外框

    //i:引脚间距    [x,y]：除掉边距之外，以芯片左上角为[0,0]、右下角为[1,1]的相对坐标
    var i = 1 / 10;
    this.pinPosition = new Array([i * 0, 1], [i * 1, 1], [i * 2, 1], [i * 3, 1], [i * 4, 1], [i * 5, 1], [i * 6, 1], [i * 7, 1], [i * 8, 1], [i * 9, 1],
                       [i * 9, 0], [i * 8, 0], [i * 7, 0], [i * 6, 0], [i * 5, 0],
                       [i * 4, 0], [i * 3, 0], [i * 2, 0], [i * 1, 0], [i * 0, 0]);

    //引脚类型  0：输入  10:必要输入  1：输出  2：地  3：电源  4:其它
    this.pinFunction = new Array(4, 10, 10, 10, 10, 10, 10, 10, 10, 2, 1, 1, 1, 1, 1, 1, 1, 1, 10, 3);

    this.pinValue = new Array(1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2);

    //引脚与其它引脚的连接线对象
    this.connection = new Array([], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], []);
};

//判断目前芯片是否已达到运算条件(是否所有的必要输入都已经有输入值)
Compo74LS245.prototype.beReady = function () {
    for (var i = 0; i < this.pinFunction.length; i++) {
        if (this.pinFunction[i] == 10 && this.pinValue[i] == 2) {
            return false;
        }
    };
    if (this.pinValue[18] == 0) {
        return true;
    } else {
        return false;
    }
};

//设置输入引脚的值，并且判断目前芯片是否已达到运算条件
Compo74LS245.prototype.input = function (pinNo, value) {
    if (value == this.pinValue[pinNo]) return false; //如果输入的值没有变化，则无需重新计算
    this.pinValue[pinNo] = value;

    //-E为1时，各输出引脚变为高阻态
    if (pinNo == 18 && value == 1) {
        for (i = 10; i <= 17; i++) {
            this.pinValue[i] = 2;
        }
        return true;
    };

    return this.beReady();
};

Compo74LS245.prototype.work = function () {
    if(this.pinValue[18]==1) return;

    this.pinValue[17] = this.pinValue[1];
    this.pinValue[16] = this.pinValue[2];
    this.pinValue[15] = this.pinValue[3];
    this.pinValue[14] = this.pinValue[4];
    this.pinValue[13] = this.pinValue[5];
    this.pinValue[12] = this.pinValue[6];
    this.pinValue[11] = this.pinValue[7];
    this.pinValue[10] = this.pinValue[8];
};

Compo74LS245.prototype.reset = function () {
    this.pinValue = [1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2];
};