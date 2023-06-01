<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<!--  관리자페이지 구현 X  -->

<title>관리자</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="imagetoolbar" content="no" />
<!-- <link href="../css/contents.css" rel="stylesheet" type="text/css" /> -->
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css" />
	<script src="${pageContext.request.contextPath}/resources/JS/MainFunc.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script type="text/javascript">
		function clearText(){
			$("#companyname").val("empty");
			$("#searchtype").val("empty");
			$("#txtSearch").val("");
		}
	</script>
	<script type="text/javascript">
		function pdRowClick(row){
			var tds = row.getElementsByTagName('td');
			var no = tds[0].textContent;
			location.href = "${pageContext.request.contextPath}/productInfo?no="+no;
		};
		function registerMove(){
			location.href = "${pageContext.request.contextPath}/productAddPage";
		};
		$(function(){

			var s_userInfo ='${sessionScope.userInfo.id}'
			console.log(s_userInfo);
			if (!s_userInfo){
				$('#btn_logout').hide();
				$('#btn_register').hide();
				$('#btn_login').show();

			}
			else{
				$('#btn_logout').show();
				$('#btn_register').show();
				$('#btn_login').hide();
			}
		});

	</script>
	<style type="text/css">
		.bbsList tr:hover{
			background-color: #f5f5f5;
			cursor: pointer;
		}
	</style>
</head>
<body>	
	<div id="wrap">
		<!-- header -->
		
		<!--// header -->

		<div id="sub_container">
			<div id="contentsWrap" class="sub_con5">
				<div class="board_form">   
		            <div class="con_title">
		               <p>상품 등록/보기/수정</p>   
		            </div>
	
				<div class="contents">
					<div class="btnSet clfix mgb15">
						<span class="fr">
							<span class="button"><input type="button" id="btn_login" value="로그인" onclick=""></span>
							<span class="button"><input type="button" id="btn_logout" value="로그아웃" onclick=""></span>
							<span class="button"><input type="button" id="btn_register" value="등록" onclick="registerMove()"></span>
						</span>
					</div>
                   <form id="form" action="${pageContext.request.contextPath}/list" method="post">
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
								<th>
								<select id="searchtype" name="searchtype">
									<option value="empty" <c:if test="${empty searchtype or searchtype eq 'empty'}" > selected="selected"</c:if>>선택하세요</option>
									<option value="pdname" <c:if test="${searchtype eq 'pdname'}"> selected</c:if> >상품명</option>
								  <option value="pdcountry" <c:if test="${searchtype eq 'pdcountry'}"> selected</c:if>>원산지</option>
								  <option value="pdcategory" <c:if test="${searchtype eq 'pdcategory'}"> selected</c:if>>카테고리</option>
								</select>
								</th>
								<td>
									<input type="text" id="txtSearch" name="txtSearch" style="border:1px solid #ddd; height:20px;" class="inputText" size="30" value="${txtSearch}" />
									<input type="submit" value="검색"></input>
									<input type="button" onclick="clearText()" value="새로고침"></input>
									<%-- 이렇게 사용하면 type이 submit으로 됨 ...
									<button></button>
									--%>
								</td>
							</tr>
						</tbody>
					</table>

							<table class="bbsList">
								<colgroup>
									<col width="80" />
									<col width="170" />
									<col width="170" />
									<col width="170" />
									<col width="170" />
									<col width="170" />
									<col width="170" />
									<col width="170" />
								</colgroup>
								<thead>

									<tr>
										<th scope="col">NO.</th>
										<th scope="col">상품명</th>
										<th scope="col">이미지</th>
										<th scope="col">원산지</th>
										<th scope="col">가격</th>
										<th scope="col">종류</th>
										<th scope="col">날짜</th>
										<th scope="col">판매자</th>

									</tr>
								</thead>

								<tbody>
									<c:forEach var="item" items="${list}">
										<tr onclick="pdRowClick(this)">
											<td>${item.no}</td>
											<td>${item.pdname}</td>
											<td><img src="${pageContext.request.contextPath}/resources/upload/${item.imgname}" width="50" height="50"/></td>
											<td>${item.pdcountry}</td>
											<td>${item.pdprice}</td>
											<td>${item.pdcategory}</td>
											<td>${item.pdreg}</td>
											<td>${item.userid}</td>
										</tr>
									</c:forEach>

									
								</tbody>
							</table>
					   		<div class="paging">
								<a href="${pageContext.request.contextPath}/list?companyname=${companyname}&searchtype=${searchtype}&txtSearch=${txtSearch}&pageNum=1">처음</a>
								<span>
									 <c:forEach begin="${startPage}" end="${endPage}" var="i">
										 <c:choose>
											 <c:when test="${i==currentPage}">
												 <a href="${pageContext.request.contextPath}/list?companyname=${companyname}&searchtype=${searchtype}&txtSearch=${txtSearch}&pageNum=${i}"><b>${i}</b></a>
											 </c:when>
											 <c:otherwise>
												 <a href="${pageContext.request.contextPath}/list?companyname=${companyname}&searchtype=${searchtype}&txtSearch=${txtSearch}&pageNum=${i}">${i}</a>
											 </c:otherwise>
										 </c:choose>

									 </c:forEach>
								</span>
								<a href="${pageContext.request.contextPath}/list?companyname=${companyname}&searchtype=${searchtype}&txtSearch=${txtSearch}&pageNum=${totalPage}">끝</a>
							</div>


				   		</form>
						</div>
					</div>
				</div>
			</div>
	
  <!--Footer-->
     
   <!--END Footer-->	
	</div>
</body>
</html>