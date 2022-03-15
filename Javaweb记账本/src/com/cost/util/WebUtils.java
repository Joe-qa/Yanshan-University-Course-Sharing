package com.cost.util;

import java.math.BigDecimal;

public class WebUtils {
    
    //该类为工具类，封装常用的函数，catch类型转换异常，保障程序健壮性
    
    
    /**
     * String转BigDecimal发生异常返回默认值
     * @param str  字符串
     * @param defaultValue 默认值
     * @return BigDecimal值
     */
    public static BigDecimal bigdecimal(String str,BigDecimal defaultValue) {
        try {
            return new BigDecimal(str);
        } catch (Exception e) {
            //e.printStackTrace();
        }
        return defaultValue;
    }
    
    /**
     * 字符串转int
     * @param string 被转换的字符串
     * @param defaultValue 默认值
     * @return int
     */
    public static int parseInt(String string,int defaultValue){
        try {
            return Integer.parseInt(string);
        } catch (NumberFormatException e) {
            //e.printStackTrace();
        }
        return defaultValue;
    }
    

}

