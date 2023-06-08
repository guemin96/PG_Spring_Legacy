package com.bit.dao;

import com.bit.dto.*;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public class SPDaoImp  implements SPDao{
    @Autowired
    private SqlSessionTemplate sqlSession;
    static String nameSpace = "com.bit.dto.basicMapper";
    @Override
    public String LoginCheck(UserInfo userInfo) {
        String count = sqlSession.selectOne(nameSpace+".logincheck",userInfo);
        //로그인 실패
       return count;
    }

    @Override
    public List<ProductInfo> selectAll(HashMap<String, Object> map) {
        List<ProductInfo> list = sqlSession.selectList(nameSpace+".selectall",map);
        return list;
    }

    @Override
    public int selectCount(HashMap<String, Object> map) {
        int count = sqlSession.selectOne(nameSpace+".selectcount",map);

        return count;
    }

    @Override
    public ProductInfo selectPDInfo(HashMap<String, Object> map) {
        ProductInfo pi = sqlSession.selectOne(nameSpace+".selectpdinfo",map);

        return pi;
    }

    @Override
    public List<ProductInfo> selectAddProduct(HashMap<String, Object> map) {
        List<ProductInfo> list = sqlSession.selectList(nameSpace+".selectAddProduct",map);
        return list;
    }

    @Override
    public List<CompanyInfo> GetCompany() {
        return sqlSession.selectList(nameSpace+".selectCompany");
    }

    @Override
    public List<CategoryInfo> GetCategory() {
        return sqlSession.selectList(nameSpace+".selectCategory");
    }



    @Override
    public ProductInfo ModifyPDInfo(HashMap<String, Object> map) {
        ProductInfo pi = sqlSession.selectOne(nameSpace+".modifypdinfo",map);

        return pi;
    }
    @Override
    public int DeletePDInfo(HashMap<String, Object> map) {
        int num = sqlSession.delete(nameSpace+".deletepdinfo",map);
        return num;
    }
    @Override
    public int AddMyproduct(ProductInfo dto) {
        int num = sqlSession.insert(nameSpace+".addmyproduct",dto);
        return num;
    }

    @Override
    public int ModifyMyproduct(ProductInfo dto) {
        int num = sqlSession.update(nameSpace+".modifymyproduct",dto);
        return num;
    }

    @Override
    public List<ProductInfo> selectMyProductList(HashMap<String, Object> map) {
        return sqlSession.selectList(nameSpace+".selectmyproductlist",map);
    }

    @Override
    public void AddMyCart(HashMap<String, Object> map) {
        int num = sqlSession.insert(nameSpace+".addmycart",map);
    }

    @Override
    public int myCartCheck(HashMap<String, Object> map) {
        int num = sqlSession.selectOne(nameSpace+".mycartcheck",map);

        return 0;
    }

    @Override
    public int myCart_delete(HashMap<String, Object> map) {
        int num = sqlSession.delete(nameSpace+".deletemycart",map);
        return num;
    }

    @Override
    public List<CategoryCount> selectChart() {
        List<CategoryCount> list = sqlSession.selectList(nameSpace+".selectChart");
        return list;
    }

    @Override
    public int AddComment(HashMap<String,Object>map) {
        int num = sqlSession.insert(nameSpace+".addcomment",map);
        return num;
    }

    @Override
    public int selectCommentNum() {
        int Comment_id = sqlSession.selectOne(nameSpace+".selectCommentNum");
        ++Comment_id;
        return Comment_id;
    }

    @Override
    public List<CommentDTO> selectCommentList(HashMap<String, Object> map) {
        List<CommentDTO> comment_list = sqlSession.selectList(nameSpace+".selectCommentList",map);
        return comment_list;
    }

    @Override
    public List<CommentDTO> selectCommentChild(HashMap<String, Object> map) {
        List<CommentDTO> comment_Child = sqlSession.selectList(nameSpace+".selectCommentChild",map);
        return comment_Child;
    }
}
