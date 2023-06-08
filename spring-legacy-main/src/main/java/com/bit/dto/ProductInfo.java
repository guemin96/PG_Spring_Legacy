package com.bit.dto;

import java.sql.Timestamp;
import java.util.Date;

public class ProductInfo {
    private Integer no;
    private String userid;

    private String pdname;
    private String pdcompany;
    private String pdprice;
    private String pdcountry;
    private String pdcategory;
    private Timestamp  pdreg;
    private String imgname;

    public ProductInfo(Integer no, String userid, String pdname, String pdcompany, String pdprice, String pdcountry, String pdcategory, Timestamp pdreg, String imgname) {
        this.no = no;
        this.userid = userid;
        this.pdname = pdname;
        this.pdcompany = pdcompany;
        this.pdprice = pdprice;
        this.pdcountry = pdcountry;
        this.pdcategory = pdcategory;
        this.pdreg = pdreg;
        this.imgname = imgname;
    }

    public Integer getNo() {
        return no;
    }

    public void setNo(Integer no) {
        this.no = no;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getPdname() {
        return pdname;
    }

    public void setPdname(String pdname) {
        this.pdname = pdname;
    }

    public String getPdcompany() {
        return pdcompany;
    }

    public void setPdcompany(String pdcompany) {
        this.pdcompany = pdcompany;
    }

    public String getPdprice() {
        return pdprice;
    }

    public void setPdprice(String pdprice) {
        this.pdprice = pdprice;
    }

    public String getPdcountry() {
        return pdcountry;
    }

    public void setPdcountry(String pdcountry) {
        this.pdcountry = pdcountry;
    }

    public String getPdcategory() {
        return pdcategory;
    }

    public void setPdcategory(String pdcategory) {
        this.pdcategory = pdcategory;
    }

    public Timestamp getPdreg() {
        return pdreg;
    }

    public void setPdreg(Timestamp pdreg) {
        this.pdreg = pdreg;
    }

    public String getImgname() {
        return imgname;
    }

    public void setImgname(String imgname) {
        this.imgname = imgname;
    }
}
