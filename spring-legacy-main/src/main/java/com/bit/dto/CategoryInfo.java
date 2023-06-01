package com.bit.dto;

public class CategoryInfo {
    private String no_category;
    private String name_category;

    @Override
    public String toString() {
        return "CategoryInfo{" +
                "no_category='" + no_category + '\'' +
                ", name_category='" + name_category + '\'' +
                '}';
    }

    public CategoryInfo(String no_category, String name_category) {
        this.no_category = no_category;
        this.name_category = name_category;
    }

    public String getNo_category() {
        return no_category;
    }

    public void setNo_category(String no_category) {
        this.no_category = no_category;
    }

    public String getName_category() {
        return name_category;
    }

    public void setName_category(String name_category) {
        this.name_category = name_category;
    }
}
