package com.cost.bean;

import java.math.BigDecimal;

public class HomeCost {
    
    private int id;//id
    private String name;//消费名称
    private BigDecimal money;//消费金额
    public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public HomeCost(int id, String name, BigDecimal money, String date, BigDecimal sum, String note, String username) {
		super();
		this.id = id;
		this.name = name;
		this.money = money;
		this.date = date;
		this.sum = sum;
		this.note = note;
		this.username = username;
	}
	private String date;//消费日期
    private BigDecimal sum;//累计消费
    private String note;
    private String username;
    public HomeCost(int id, String name, BigDecimal money, String date, BigDecimal sum, String note) {
		super();
		this.id = id;
		this.name = name;
		this.money = money;
		this.date = date;
		this.sum = sum;
		this.note = note;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public BigDecimal getMoney() {
        return money;
    }
    public void setMoney(BigDecimal money) {
        this.money = money;
    }
    public String getDate() {
        return date;
    }
    public void setDate(String date) {
        this.date = date;
    }
    public BigDecimal getSum() {
        return sum;
    }
    public void setSum(BigDecimal sum) {
        this.sum = sum;
    }
    
    
       
    @Override
	public String toString() {
		return "HomeCost [id=" + id + ", name=" + name + ", money=" + money + ", date=" + date + ", sum=" + sum
				+ ", note=" + note + ", username=" + username + "]";
	}
    
    public HomeCost() {}
    
    public HomeCost(String name, BigDecimal money,String note) {
        super();
        this.name = name;
        this.money = money;
    this.note=note;
    }
    
    
    public HomeCost(int id,String name,BigDecimal money, String date,String note) {
        super();
        this.id=id;
        this.name = name;
        this.money=money;
        this.date=date;
        this.note=note;
    }
    public HomeCost(int id,String name,BigDecimal money, String date) {
        super();
        this.id=id;
        this.name = name;
        this.money=money;
        this.date=date;
    }
    public HomeCost(int id, String name, BigDecimal money, String date, BigDecimal sum) {
        super();
        this.id = id;
        this.name = name;
        this.money = money;
        this.date = date;
        this.sum = sum;
    }
    
}

