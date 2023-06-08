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
<!-- <link href="../css/contents.css" rel="stylesheet" type="text/css" /> -->
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css" />
	<script src="${pageContext.request.contextPath}/resources/JS/MainFunc.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script type="text/javascript">
		$(function(){
			var tdElements = document.getElementsByClassName('pdprice');
			var total = 0;

			for (var i = 0; i < tdElements.length; i++) {
				var value = parseFloat(tdElements[i].textContent);
				total += value;
			}
			$("#total").val(total+"원");
		});

		function mycart_buy(button){

		}
		function mycart_delete(button){
			var row = button.parentNode.parentNode.parentNode;
			var no = row.getElementsByTagName("td")[0].innerHTML;
			if (confirm("정말로 삭제하시겠습니까?"))
			{
				$.ajax({
					url:'${pageContext.request.contextPath}/User/mycart_delete',
					type:'post',
					data:{no:no,id:'${sessionScope.userInfo.id}'},

					success: function (data){
						if (data=="1") {
							document.location.href = "${pageContext.request.contextPath}/User/myProductPage"
						}
						else {
							alert("삭제하는 과정에서 오류가 발생하였습니다.");
						}
					},
					error: function(error){
						console.log(error)
					}
				});
			}
			else {
				alert("취소버튼을 누르셨습니다.");
			}
		}
	</script>

</head>
<body>

	<div id="wrap">
		<!-- header -->
		
		<!--// header -->

		<div id="sub_container">
			<div id="contentsWrap" class="sub_con5">
				<div class="board_form">   
		            <div class="con_title">
		               <p>장바구니 리스트</p>   
		            </div>
					<div class="contents">
					
					<div class="btnSet clfix mgb15">
						<span class="fr"> <span class="button"><a href="${pageContext.request.contextPath}/list">목록</a></span>
						</span>
					</div>
						<form action="${pageContext.request.contextPath}/User/myProductPage" method="post">
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

										</select>
									</td>
									<th>상품명</th>
									<td>
										<input type="text" name="productName" class="" size="30" value="${productname}" style="border:1px solid #ddd; height:20px;"/>
										<span class="button"><input type="submit" id="btn_search" value="검색" ></span>
									</td>
								</tr>
								</tbody>
							</table>
						</form>

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
										<th scope="col">상태</th>									
									</tr>
								</thead>
								<tbody>
									<c:forEach var="item" items="${list}">
										<tr>
											<td>${item.no}</td>
											<td>${item.pdname}</td>
											<td><img src="${pageContext.request.contextPath}/resources/upload/${item.imgname}" width="50" height="50"/></td>
											<td>${item.pdcountry}</td>
											<td class="pdprice">${item.pdprice}</td>
											<td>${item.pdcategory}</td>
											<td>${item.pdreg}</td>
											<td>
												<span class="buttonFuc"><input type="button" id="btn_buy" value="구매" onclick="mycart_buy(this)"></span>
												<span class="buttonFuc"><input type="button" id="btn_delete" value="삭제" onclick="mycart_delete(this)"></span>

											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<table class="bbsList" align="right">
							<tr align="right">
								<th align="right">총합계 &nbsp; <input type="text" name="total" id="total" class="inputText" size="30"  align="right" value="0"/></th>
								</tr>	
							</table>	
						</div>
					</div>
					</div>
				</div>
   <!--Footer-->
    
   <!--END Footer-->	
   </div>
	
	
</body>
</html>