package com.bit.dto;


public class CompanyInfo {
    private String no_company;
    private String name_company;

    @Override
    public String toString() {
        return "CompanyInfo{" +
                "no_company='" + no_company + '\'' +
                ", name_company='" + name_company + '\'' +
                '}';
    }

    public CompanyInfo(String no_company, String name_company) {
        this.no_company = no_company;
        this.name_company = name_company;
    }

    public String getNo_company() {
        return no_company;
    }

    public void setNo_company(String no_company) {
        this.no_company = no_company;
    }

    public String getName_company() {
        return name_company;
    }

    public void setName_company(String name_company) {
        this.name_company = name_company;
    }
}
