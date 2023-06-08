package com.bit.controller;

import javax.servlet.http.HttpServletRequest;

public class pagingComponent {

    public void pagingWork(HttpServletRequest request,int Count,String PageNum){

        int pageNum = Integer.parseInt(PageNum);
        int perPage = 10;
        int totalPage = ((Count-1)/perPage+1);
        int startPage = 0;
        int endPage = 0;

        if (pageNum>5){
            startPage = pageNum -5;
        }
        else {
            startPage =1;
        }

        if (totalPage<=10){
            endPage = totalPage;
        }
        else{
            endPage = startPage+9;
            if (endPage>totalPage) {
                endPage= totalPage;
                startPage = endPage-9;
            }
        }

        request.setAttribute("startPage",startPage);
        request.setAttribute("endPage",endPage);
        request.setAttribute("currentPage",pageNum);
        request.setAttribute("totalPage",totalPage);

    }

}
