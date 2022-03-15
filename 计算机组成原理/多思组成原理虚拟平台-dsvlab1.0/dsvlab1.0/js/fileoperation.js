/*
Duosi Principles of Computer Composition Virtual Experiment System ,DS-VLAB v1.0
Copyright(C)2013 ZHANG Wen-fen, Email: yydzhwf@163.com  Address: Xiangnan University, Chenzhou Hunan, China
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.

多思计算机组成原理网络虚拟实验系统, DS-VLAB v1.0 
版权所有(C) 张雯雰, 电子邮箱: yydzhwf@163.com
本程序为自由软件；您可依据自由软件基金会所发表的GNU GENERAL PUBLIC LICENSE，对本程序再次发布和/或修改。

作者：湘南学院软件与通信工程学院张雯雰老师
*/



;
$(function () {
    $("#opener").click(function () {
        mycircuit.deletecircuit();
        readFile();
    });
    $("#saver").click(function () {
        writeFile();
    });
    $("#newfile").click(function () {
        // window.location.reload();
        mycircuit.deletecircuit();
    });
});

var filename = "circuit.txt";
var filecontent = "";

//读文件
function readFile( ) {
    try {
        window.open("readcircuit.html", "test", "toolbar=no,location=no,top=100,left=100,directories=no,status=yes,menubar=no,scrollbars=yes,location=no,resizable=yes,width=500,height=200");
    } catch (e) {
        alert('read error!');
    };
};

//写文件 
function writeFile() {
    try {
       // var blobObject = new Blob(filecontent);
        // window.navigator.msSaveOrOpenBlob(blobObject, filename);
        filecontent = circuitdata(mycircuit);
        window.open("savecircuit.html", "test", "toolbar=no,location=no,top=100,left=100,directories=no,status=yes,menubar=no,scrollbars=yes,location=no,resizable=yes,width=500,height=200");
    } catch (e) {
        alert('write error!');
    };
};

//把电路数据保存到一个字符串中
function circuitdata(circuit) {
    var cAll = circuit.componentAll;
    var comp= "",line="";
    var c,d,x,y,i,j,k,lId,p,sCId;
    for (i = 0; i < cAll.length; i++) {
        c = cAll[i];
        d = document.getElementById(c.id);
        x = String(d.style.left);
        y = String(d.style.top);
        comp = comp + c.name + "," + x + "," + y + "," + c.id + "$";
        for (j = 0; j < c.connection.length; j++) {
            if (c.pinFunction[j] == 1 || c.pinFunction[j] == 11) {
                for (k = 0; k < c.connection[j].length; k++) {
                    lId = c.connection[j][k][0].id;
                    p = lId.indexOf("Pin");
                    sCId = lId.substring(0, p);//获取起点器件的ID
                    if (sCId == c.id) {//如果是输出连线
                        line = line + lId + ",";
                    };
                };
            };
        };
    };
    return comp + "&" + line + "@" + String(circuit.count);
};

//按照字符串恢复电路图
function recovercircuit(parentId,circuit,s) {
    var comp, strline, count, p1,p2, n,x,y,id,lid,line,sPid,ePid,sPin,ePin;
    p1 = s.indexOf("&");
    comp = s.substring(0, p1);
    p2 = s.indexOf("@");
    strline = s.substring(p1 + 1, p2);
    count = Number(s.substring(p2 + 1));
    while (!(comp.length == 0)) { //绘制器件
        p1 = comp.indexOf(",");
        n = comp.substring(0, p1);
        comp = comp.substring(p1 + 1);

        p1 = comp.indexOf(",");
        x = comp.substring(0, p1);
        comp = comp.substring(p1 + 1);

        p1 = comp.indexOf(",");
        y = comp.substring(0, p1);
        comp = comp.substring(p1 + 1);

        p1 = comp.indexOf("$");
        id = comp.substring(0, p1);
        comp = comp.substring(p1 + 1);
        p1 = x.indexOf("px");
        x=x.substring(0,p1);
        p1 = y.indexOf("px");
        y = y.substring(0, p1);
        circuit.addComponent(parentId, "Compo" + n, x, y,id);
    };

    while (!(strline.length == 0)) {//绘制连接线
        p1 = strline.indexOf(",");
        lid = strline.substring(0, p1);
        strline = strline.substring(p1 + 1);
        p1 = lid.indexOf("To");
        sPid = lid.substring(0, p1);
        ePid = lid.substring(p1 + 2);       
        sPin = document.getElementById(sPid);
        ePin = document.getElementById(ePid);
        line = circuit.lineCreate(parentId, 0, 0, 10, 10);
        sPin.focus();
        ePin.focus();
        circuit.lineAdjust(line, sPin, ePin);
        circuit.addLineToComponent(line, sPin, ePin);
    };

    circuit.count = count;//设置电路的count值

};

