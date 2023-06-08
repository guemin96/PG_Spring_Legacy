package com.bit.controller;


import com.bit.dto.CategoryCount;
import com.bit.dto.ProductInfo;
import com.bit.dto.UserInfo;
import com.bit.service.SPService;
import com.mysql.cj.Session;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.*;

@Controller
public class CartController {
    @Resource(name = "SPServiceImp")
    private SPService service;
    //로그인 체크 함수
    @ResponseBody
    @PostMapping(value = "/logincheck")
    public void LoginCheck(UserInfo userInfo,
                           String checker,
                           HttpSession session,
                           HttpServletResponse response) throws IOException {
        String count = service.LoginCheck(userInfo);

        //로그인 실패
        if (count.equalsIgnoreCase("0")){
            response.getWriter().write("F");

        }
        else {
            response.getWriter().write("T");

            //쿠키 생성 (아이디 저장 체크가 되어있을때)
            Cookie cookie = new Cookie("id",userInfo.getId());
            cookie.setMaxAge((checker.equalsIgnoreCase("true"))?3000:0);
            response.addCookie(cookie);

            //세션 생성 (로그인 정보 저장)
            session.setAttribute("userInfo",userInfo);
            session.setMaxInactiveInterval(6000);
        }
    }
    //리스트 페이지 이동 함수
    @RequestMapping(value = "/list",method = {RequestMethod.GET,RequestMethod.POST})
    public String list(HttpServletRequest request, HttpServletResponse response){
        try {
            request.setCharacterEncoding("UTF-8");
        }
        catch (Exception e){
            e.printStackTrace();
        }
        //업체목록 가지고 오기
        request.setAttribute("companyList",service.GetCompany());
        
        //업체명,검색종류,검색내용,페이지 번호 파라미터 가져오기
        String companyname = request.getParameter("companyname")==null?"empty":request.getParameter("companyname");
        String searchtype = request.getParameter("searchtype")==null?"empty":request.getParameter("searchtype");
        String txtSearch = request.getParameter("txtSearch")==null?"":request.getParameter("txtSearch");
        String pageNum = request.getParameter("pageNum")==null?"1":request.getParameter("pageNum");

        int offsetPage =  ((Integer.parseInt(pageNum)-1)*10);
        //DB에 넘길 파라미터 값
        HashMap<String,Object> map = new HashMap<>();
        map.put("companyname",companyname);
        map.put("searchtype",searchtype);
        map.put("txtSearch",txtSearch);
        map.put("offsetPage",offsetPage);

        //페이징 작업
        pagingComponent pg = new pagingComponent();
        pg.pagingWork(request,service.selectCount(map),pageNum);

        request.setAttribute("list",service.selectAll(map));
        request.setAttribute("companyname",companyname);
        request.setAttribute("searchtype",searchtype);
        request.setAttribute("txtSearch",txtSearch);


        return "productList";
    }



    @GetMapping(value = "/productInfo")
    public String productInfoPage(HttpServletRequest request,
                                  @RequestParam(value = "no",required = false )String no){

        /*String no = request.getParameter("no");*/

        HashMap<String,Object> map = new HashMap<>();
        map.put("no",no);
        request.setAttribute("productInfo",service.selectPDInfo(map));

        request.setAttribute("commentInfo",service.selectCommentList(map));


        return "productInfo";
    }
    @RequestMapping (value = "/User/productAddPage")
    public String productAddPage(HttpServletRequest request, Model model){
        UserInfo userInfo =  (UserInfo) request.getSession().getAttribute("userInfo");
        //회사 콤보박스에 넣기
        request.setAttribute("companyList",service.GetCompany());
        request.setAttribute("categoryList",service.GetCategory());

        //업체명,상품명 파라미터 넣기
        String no_company = request.getParameter("companyname")==null?"empty":request.getParameter("companyname");
        String name_product = request.getParameter("productName")==null?"":request.getParameter("productName");

        HashMap<String,Object> map = new HashMap<>();
        map.put("id",userInfo.getId());
        map.put("no_company",no_company);
        map.put("name_product",name_product);


        request.setAttribute("myAddProductList",service.selectAddProduct(map));

        //업체명,상품명 유지 시키기
        request.setAttribute("companyname",no_company);
        request.setAttribute("productname",name_product);


        return "productAdd";
    }
    @RequestMapping(value = "/User/myproductAddORModify")
    public String productAddOrModify(ProductInfo productInfo,
                                    HttpSession session,
                                    @RequestParam(value = "method",required = false)String method,
                                     @RequestParam (value = "file",required = false)MultipartFile file){
        UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
        productInfo.setUserid(userInfo.getId());

        String locations = "C:/PG_Spring_Legacy/spring-legacy-main/src/main/webapp/resources/upload/";
        FileOutputStream fos;
        String fileDemo = file.getOriginalFilename();
        if (fileDemo.length()>0){
            try {
                fos = new FileOutputStream(locations + fileDemo);
                fos.write(file.getBytes());
                productInfo.setImgname(fileDemo);

            }
            catch (Exception e){
                e.printStackTrace();
            }
        }
        if (method.equalsIgnoreCase("add")){
            service.AddMyproduct(productInfo);
        }
        else {
            service.ModifyMyproduct(productInfo);
        }

        return "redirect:/User/productAddPage";
    }
    @RequestMapping (value = "/User/myProductPage")
    public String myProductPage(HttpServletRequest request, Model model) {
        try {
            request.setCharacterEncoding("UTF-8");
        }
        catch (Exception e){
            e.printStackTrace();
        }

        model.addAttribute("companyList",service.GetCompany());


        String no_company = request.getParameter("companyname")==null?"empty":request.getParameter("companyname");
        String name_product = request.getParameter("productName")==null?"":request.getParameter("productName");

        UserInfo userInfo =  (UserInfo) request.getSession().getAttribute("userInfo");

        //DB에 넘길 파라미터 값
        HashMap<String,Object> map = new HashMap<>();
        if (userInfo != null){
            map.put("id",userInfo.getId());
        }
        else {
            map.put("id","");
        }

        map.put("no_company",no_company);
        map.put("name_product",name_product);


        model.addAttribute("list",service.selectMyProductList(map));
        model.addAttribute("companyname",no_company);
        model.addAttribute("productname",name_product);

        return "cartList";
    }
    @RequestMapping( value = "/User/addMyCart")
    public String addMyCart(HttpSession session,
                                @RequestParam(value = "no",required = false)String no){

        UserInfo userinfo = (UserInfo) session.getAttribute("userInfo");
        HashMap<String,Object> map = new HashMap<>();
        map.put("no",no);
        map.put("id",userinfo.getId());

        service.AddMyCart(map);

        return "redirect:/User/myProductPage";
    }
    @PostMapping(value = "ajaxPieChart1")
    public String pieChart(Model model) {
    // 카운트랑 name이 계속 거꾸로 나옴 이거 체크하기
        List<CategoryCount> list = service.selectChart();
        System.out.println(list);
        StringBuffer sb = new StringBuffer();
        sb.append("['name_category','category_count'],");
        int lastIndex = 0;

        for (CategoryCount categoryCount : list) {
            sb.append("['");
            sb.append(categoryCount.getCategory());
            sb.append("',");
            sb.append(categoryCount.getCount());
            if (lastIndex == list.size() - 1) {
                sb.append("]");
            } else {
                sb.append("],");
            }

            lastIndex++;
        }
        /*
        for(Object o:list) {//o 는 맵
            //System.out.println("o"+ o);


            Set<Map.Entry<String, Object>> set = ((HashMap<String, Object>) o).entrySet();

            Iterator<Map.Entry<String, Object>> i = set.iterator();
            sb.append("[");
            int index=0;
            while(i.hasNext()) {
                Map.Entry<String,Object> entry=i.next();
                index++;
                System.out.println(entry.getKey()+" "+entry.getValue());
                if(entry.getKey().equals("count")) {
                    sb.append(entry.getValue());
                }else if(entry.getKey().equals("category")) {
                    sb.append("'"+entry.getValue()+"',");
                }
            }//while
            if(lastIndex==list.size()-1)
                sb.append("]");
            else {
                sb.append("],");
            }
            lastIndex++;
        }*/

        System.out.println(sb.toString());
        model.addAttribute("data", sb.toString());


        return "ajaxChartResult";
    }

}

