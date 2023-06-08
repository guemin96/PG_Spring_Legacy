package com.bit.service;

import com.bit.dao.SPDao;
import com.bit.dto.*;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

@Service
public class SPServiceImp implements SPService {
    @Resource(name ="SPDaoImp")
    private SPDao dao;
    @Override
    public String LoginCheck(UserInfo userInfo) {
        return dao.LoginCheck(userInfo);
    }

    @Override
    public List<ProductInfo> selectAll(HashMap<String, Object> map) {
        return dao.selectAll(map);
    }

    @Override
    public int selectCount(HashMap<String, Object> map) {
        return dao.selectCount(map);
    }

    @Override
    public ProductInfo selectPDInfo(HashMap<String, Object> map) {
        return dao.selectPDInfo(map);
    }

    @Override
    public List<ProductInfo> selectAddProduct(HashMap<String, Object> map) {
        return dao.selectAddProduct(map);
    }

    @Override
    public List<CompanyInfo> GetCompany() {

        return dao.GetCompany();
    }

    @Override
    public List<CategoryInfo> GetCategory() {
        return dao.GetCategory();
    }



    @Override
    public ProductInfo ModifyPDInfo(HashMap<String, Object> map) {
        return dao.ModifyPDInfo(map);
    }

    @Override
    public int DeletePDInfo(HashMap<String, Object> map) {
        return dao.DeletePDInfo(map);
    }
    @Override
    public int AddMyproduct(ProductInfo dto) {
        return dao.AddMyproduct(dto);
    }

    @Override
    public int ModifyMyproduct(ProductInfo dto) {
        return dao.ModifyMyproduct(dto);
    }

    @Override
    public List<ProductInfo> selectMyProductList(HashMap<String, Object> map) {
        return dao.selectMyProductList(map);
    }

    @Override
    public void AddMyCart(HashMap<String, Object> map) {
        dao.AddMyCart(map);
    }

    @Override
    public int myCartCheck(HashMap<String, Object> map) {
        return dao.myCartCheck(map);
    }

    @Override
    public int myCart_delete(HashMap<String, Object> map) {
        return dao.myCart_delete(map);
    }

    @Override
    public List<CategoryCount> selectChart() {
        return dao.selectChart();
    }

    @Override
    public int AddComment(HashMap<String,Object>map) {
        return dao.AddComment(map);
    }
    @Override
    public int selectCommentNum() {
        return dao.selectCommentNum();
    }

    @Override
    public List<CommentDTO> selectCommentList(HashMap<String, Object> map) {
        return dao.selectCommentList(map);
    }

    @Override
    public List<CommentDTO> selectCommentChild(HashMap<String, Object> map) {
        return dao.selectCommentChild(map);
    }
}
