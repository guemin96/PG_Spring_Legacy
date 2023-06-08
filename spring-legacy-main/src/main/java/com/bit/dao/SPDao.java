package com.bit.dao;

import com.bit.dto.*;

import java.util.HashMap;
import java.util.List;

public interface SPDao {
    public String LoginCheck(UserInfo userInfo);
    public List<ProductInfo> selectAll(HashMap<String, Object> map);
    public int selectCount(HashMap<String, Object> map);
    public ProductInfo selectPDInfo(HashMap<String,Object>map);
    public List<ProductInfo> selectAddProduct(HashMap<String,Object>map);
    public List<CompanyInfo> GetCompany();
    public List<CategoryInfo> GetCategory();

    public ProductInfo ModifyPDInfo(HashMap<String,Object> map);
    public int DeletePDInfo(HashMap<String, Object>map);
    public int AddMyproduct(ProductInfo dto);
    public int ModifyMyproduct(ProductInfo dto);

    public List<ProductInfo> selectMyProductList(HashMap<String,Object>map);
    public void AddMyCart(HashMap<String,Object>map);

    public int myCartCheck(HashMap<String,Object>map);
    public int myCart_delete(HashMap<String,Object>map);
    public List<CategoryCount> selectChart();
    public int AddComment (HashMap<String,Object>map);
    public int selectCommentNum();
    public List<CommentDTO> selectCommentList(HashMap<String,Object>map);
    public List<CommentDTO> selectCommentChild(HashMap<String,Object>map);
}
