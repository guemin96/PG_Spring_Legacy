package com.bit.dto;

public class CategoryCount {
    private String category;
    private int count;

    // Getter와 Setter 메서드 생략

    @Override
    public String toString() {
        return "CategoryCount{" +
                "category='" + category + '\'' +
                ", count=" + count +
                '}';
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}