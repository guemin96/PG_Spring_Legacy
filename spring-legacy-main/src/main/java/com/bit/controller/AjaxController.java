package com.bit.controller;

import com.bit.dto.CommentDTO;
import com.bit.dto.ProductInfo;
import com.bit.service.SPService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.json.JsonWriteFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.json.JsonMapper;
import com.mysql.cj.Session;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

@RestController
public class AjaxController {
    @Resource(name = "SPServiceImp")
    private SPService service;

    @PostMapping(value = "/User/pdInfo_modify")
    public ProductInfo pdInfo_modify(Model model, @RequestParam(value = "no",required = false)String no){
        HashMap<String,Object> map = new HashMap<>();
        map.put("no",no);

        ProductInfo test = service.ModifyPDInfo(map);

        return test;
    }
    @PostMapping(value = "/User/pdInfo_delete")
    public String pdInfo_delete(@RequestParam(value = "no",required = false)String no){

        HashMap<String,Object> map = new HashMap<>();
        map.put("no",no);

        int num = service.DeletePDInfo(map);

        return Integer.toString(num);
    }
    @PostMapping(value = "/User/myCartCheck")
    public String myCartCheck(@RequestParam(value = "no",required = false)String no,
                              @RequestParam(value = "id",required = false)String id){
        HashMap<String,Object>map = new HashMap<>();
        map.put("no",no);
        map.put("id",id);

        int num = service.myCartCheck(map);

        return Integer.toString(num) ;
    }
    @PostMapping(value = "/User/mycart_delete")
    public String myCart_delete(@RequestParam(value = "no",required = false)String no,
                                @RequestParam(value = "id",required = false)String id){

        HashMap<String,Object> map = new HashMap<>();
        map.put("no",no);
        map.put("id",id);
        int num = service.myCart_delete(map);

        return Integer.toString(num);
    }
    @PostMapping(value = "/User/AddComment")
    public String AddComment(
                             @RequestParam(value = "pd_no",required = false)String pd_no,
                             @RequestParam(value = "level",required = false)int level,
                             @RequestParam(value = "rootcommentid",required = false)int rootcommentid,
                             @RequestParam(value = "parentcommentid",required = false)int parentcommentid,
                             @RequestParam(value = "user_id",required = false)String user_id,
                             @RequestParam(value = "comment_contents",required = false)String comment_contents
                             ){

        int comment_id = service.selectCommentNum();
        HashMap<String,Object>map = new HashMap<>();
        map.put("comment_id",comment_id);
        map.put("pd_no",pd_no);
        map.put("level",level);

        map.put("rootcommentid",rootcommentid==0?comment_id:rootcommentid);
        map.put("parentcommentid",parentcommentid==0?comment_id:parentcommentid);
        map.put("user_id",user_id);
        map.put("comment_contents",comment_contents);

        int num = service.AddComment(map);
        return Integer.toString(num);

    }
    @PostMapping(value = "/selectCommentChild", produces = "application/text; charset=UTF-8")
    public String selectCommentChild( @RequestParam(value = "pd_no",required = false)String pd_no,
                                      @RequestParam(value = "level",required = false)int level,
                                      @RequestParam(value = "rootcommentid",required = false)int rootcommentid,
                                      @RequestParam(value = "parentcommentid",required = false)int parentcommentid
                                      ) throws JsonProcessingException {
        HashMap<String,Object> map = new HashMap<>();
        map.put("pd_no",pd_no);
        map.put("level",level);
        map.put("rootcommentid",rootcommentid);
        map.put("parentcommentid",parentcommentid);

        List<CommentDTO> list = service.selectCommentChild(map);

        ObjectMapper objectMapper =  new ObjectMapper();
        //objectMapper.getFactory().configure(JsonWriteFeature.ESCAPE_NON_ASCII.mappedFeature(),true);

        String json = objectMapper.writeValueAsString(list);

        return json;
    }
}
