<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>관리자</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=10" />
  <meta http-equiv="imagetoolbar" content="no" />
  <meta name="copyright" content="Copyright 2009 @ high1 all rights reserved" />
  <link href="${pageContext.request.contextPath}/resources/css/contents.css" rel="stylesheet" type="text/css" />
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/JS/MainFunc.js"></script>
  <!-- 모델1 모델2 -->
  <script>
    $(function(){
      $("img#btnSubmit").click(function(){
        if($("input[name='id']").val().length==0||$("input[type='password']").val().length==0){
          alert('ID OR PASS CHECK!');
          $("input[name='id']").val('');
          $("input[type='password']").val('');
          $("input[name='id']").focus();
          return false;
        }else{
          //$("form[name='login']").submit();


          $.ajax({
            url:'${pageContext.request.contextPath}/logincheck',
            type:'POST',
            data:{"id":$("input#user_id").val(),"pw":$("input#user_passwd").val(),"checker":$("input#checker").prop("checked")},
            success:function(data){
              console.log(data);
              if(data.trim()=='T'){
                document.location.href='${pageContext.request.contextPath}/list';
              }else{

                $("input[name='id']").val('');
                $("input[name='pass']").val('');
                $("input[name='id']").focus();
              }
            },error:function(){
              console.log('error');
            }
          });
        }
      });

    });
    $(function(){
      var ck_id = getCookie("id");
      if (!ck_id) {
        $("#checker").prop("checked",false);
      }
      else{
        $("#checker").prop("checked",true);
        $("#user_id").val(ck_id);
      }
    });
  </script>
</head>
<body>

<form name="login" method="post" action="#">
  <div id="loginWrapper">
    <div class="loginForm">
      <fieldset>
        <legend>관리자 시스템 로그인</legend>
        <dl>
          <dt><img src="${pageContext.request.contextPath}/resources/img/common/th_id.gif" alt="아이디" /></dt>
          <dd><input type="text" name="id" class="text" id="user_id"  /></dd>

          <dt><img src="${pageContext.request.contextPath}/resources/img/common/th_pw.gif" alt="비밀번호" /></dt>
          <dd><input type="password" name="pass" class="text" id="user_passwd" /></dd>
        </dl>

        <div class="btn">
          <img id="btnSubmit" src="${pageContext.request.contextPath}/resources/img/button/btn_login.gif" alt="LOGIN" title="LOGIN"  />
        </div>

        <div class="saveId"><input type="checkbox" id="checker" name="checker" />
          <img src="${pageContext.request.contextPath}/resources/img/common/save_id.gif" alt="아이디 저장" />
        </div>
      </fieldset>
    </div>
  </div>
</form>
</body>
</html>