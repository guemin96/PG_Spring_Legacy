<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<title>관리자</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10" />
<meta http-equiv="imagetoolbar" content="no" />
 <link href="${pageContext.request.contextPath}/resources/css/contents.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css" />
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/JS/MainFunc.js"></script>
	<script type="text/javascript">
		function pdInfo_Add(){
			$("#product_modify").html('02. 상품수정');
			$("#product_add").addClass("over");
			$("#method").val("add");

			$("#pdname").val("");
			$("#pdcountry").val("");
			$("#pdprice").val("");
			$("#pdcategory").val("empty");
			$("#pdcompany").val("empty");

		}
		function pdInfo_modify(button){
			var row = button.parentNode.parentNode.parentNode;
			var no = row.getElementsByTagName("td")[0].innerHTML;

			$.ajax({
				url:'${pageContext.request.contextPath}/pdInfo_modify',
				type:'post',
				data:{no:no},

				success: function (data){

					console.log(data)
					$("#pdname").val(data.pdname);
					$("#pdcountry").val(data.pdcountry);
					$("#pdprice").val(data.pdprice);
					$("#pdcategory").val(data.pdcategory);
					$("#pdcompany").val(data.pdcompany);

					$("#product_modify").html('<a href="#info1">02. 상품수정</a>');
					$("#product_add").removeClass("over");
					$("#method").val("modify");

				},
				error: function(error){
					console.log(error)
				}
			});
		}
	</script>
</head>
<body> 
	<div id="wrap">
	

		<div id="sub_container">
			<div id="contentsWrap" class="sub_con5">
				<div class="board_form">   
		            <div class="con_title">
		               <p>상품등록/보기/수정</p>   
		            </div>
			
			
			
				<div class="contents">
					<div class="btnSet clfix mgb15">
						<span class="fr"> <span class="button"><a href="#">목록</a></span>
						</span>
					</div>
					<form action="${pageContext.request.contextPath}/productAdd" method="post">
						<table class="bbsWrite mgb35">
							<caption></caption>
							<colgroup>
								<col width="95" />
								<col width="395" />
								<col width="95" />
								<col />
							</colgroup>
							<tbody>
							<tr>
								<th>업체명</th>
								<td>
									<select id="companyname" name="companyname" style="width: 200px;">
										<option value="empty" <c:if test="${empty companyname or companyname eq 'empty'}" > selected="selected"</c:if>>선택하세요</option>
										<c:forEach var="item" items="${companyList}">
											<option value="${item.no_company}" <c:if test="${companyname eq item.no_company}"> selected</c:if>> ${item.name_company}</option>
										</c:forEach>

										<%--<option value="samsung" <c:if test="${companyname eq 'samsung'}"> selected</c:if> >samsung</option>
										<option value="apple" <c:if test="${companyname eq 'apple'}"> selected</c:if> >apple</option>
										<option value="shaomi" <c:if test="${companyname eq 'shaomi'}"> selected</c:if> >shaomi</option>--%>
									</select>
								</td>
								<th>상품명</th>
								<td>
									<input type="text" name="productName" style="border:1px solid #ddd; height:20px;" class="inputText" value="${productname}" size="30" />
									<span class="button"><input type="submit" id="btn_search" value="검색" ></span>
								</td>
							</tr>
							</tbody>
						</table>
					</form>


					<div class="clfix">
						<div class="tbWrapLt">
							<table class="bbsList">
								<colgroup>
									<col width="30" />
									<col width="100" />
									<col width="100" />
									<col width="100" />
									<col width="100" />
								</colgroup>
								<thead>								
									<tr>
										<th scope="col">NO.</th>
										<th scope="col">상품명</th>
										<th scope="col">모델</th>
										<th scope="col">가격</th>
										<th scope="col">상태</th>
										
									</tr>
								</thead>

								<tbody>
								 	<c:forEach var="item" items="${myAddProductList}">
										<tr>
											<td>${item.no}</td>
											<td><img src="${pageContext.request.contextPath}/resources/upload/${item.imgname}" width="50" height="50"/></td>
											<td>${item.pdname}</td>
											<td>${item.pdprice}</td>
											<td>
												<span class="buttonFuc"><input type="button" id="btn_modify" value="수정" onclick="pdInfo_modify(this)"></span>
												<span class="buttonFuc"><input type="button" id="btn_delete" value="삭제" onclick=""></span>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<form action="${pageContext.request.contextPath}/myproductAddORModify" name="frm" method="post"  enctype="multipart/form-data">
						<div class="tbWrapRt">
							<ul class="tabA clfix mgb15">
								<li class="over" id="product_add"><a href="javascript:pdInfo_Add()">01. 상품등록</a></li>
								<li class="over" id="product_modify">02. 상품수정</li>
								<input id="method" type="hidden" name="method" value="add">
							</ul>

							<div id="info1" class="tbWrapCnt" style="display: block;">
								<table class="bbsWrite mgb10">
									<caption></caption>
									<colgroup>
										<col width="95" />
										<col />
									</colgroup>
									<tbody>
										<tr>
											<th>상품명</th>
											<td><input type="text" style="border:1px solid #ddd; height:20px;" id="pdname" name="pdname" class="inputText"
												size="50" /></td>
										</tr>
										<tr>
											<th>원산지</th>
											<td><input type="text" style="border:1px solid #ddd; height:20px;" id="pdcountry" name="pdcountry" class="inputText"
												size="50" /></td>
										</tr>
										<tr>
											<th>상품가격</th>
											<td><input type="text" style="border:1px solid #ddd; height:20px;" id="pdprice" name="pdprice" class="inputText"
												size="50" />
												<input type="hidden" name="id"  value="${id}"/>
												</td>
										</tr>
										<tr>
											<th>카테고리</th>
											<td>
											<select style="width: 200px;" id="pdcategory" name="pdcategory">
												<option value="empty" selected="selected">선택하세요</option>
												<c:forEach var="item" items="${categoryList}">
													<option value="${item.no_category}">${item.name_category}</option>
												</c:forEach>
											</select>
											</td>
										</tr>
										<tr>
											<th>업체명</th>
											<td>
												<select style="width: 200px;" id="pdcompany" name="pdcompany">
													<option value="empty" selected="selected">선택하세요</option>
													<c:forEach var="item" items="${companyList}">
														<option value="${item.no_company}">${item.name_company}</option>
													</c:forEach>
												</select>
											</td>
										</tr>
										<tr>
											<th>상품이미지1</th>
											<td class="alignM"><input type="file" name="file" class="inputText" size="10" /></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<p class="agr">
							<span class="button"><input type="submit" id="btn_save" value="저장"></span>
						</p>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	
  <!--Footer-->
     
   <!--END Footer-->	
   	</div>
	
</body>
</html>