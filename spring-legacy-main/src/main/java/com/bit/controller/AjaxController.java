package com.bit.controller;

import com.bit.dto.ProductInfo;
import com.bit.service.SPService;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;

@RestController
public class AjaxController {
    @Resource(name = "SPServiceImp")
    private SPService service;
    @PostMapping(value = "/pdInfo_modify")
    public ProductInfo pdInfo_modify(Model model, @RequestParam(value = "no",required = false)String no){
        System.out.println(no);
        System.out.println("!!!!");

        HashMap<String,Object> map = new HashMap<>();

        map.put("no",no);

        ProductInfo test = service.ModifyPDInfo(map);

        return test;
    }
}
