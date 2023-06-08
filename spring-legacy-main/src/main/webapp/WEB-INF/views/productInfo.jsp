<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>관리자</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=10" />
<meta http-equiv="imagetoolbar" content="no" />

<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css" />
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/JS/MainFunc.js"></script>
    <script type="text/javascript">
        function createCommentElement(item) {
            // letter_top 요소 생성
            var letterTop = document.createElement('div');
            letterTop.className = 'letter_top';

            var innerDiv = document.createElement('div');

            // ul 요소 생성
            var ul = document.createElement('ul');

            // hidden input 요소 생성
            var commentIdInput = document.createElement('input');
            commentIdInput.type = 'hidden';
            commentIdInput.className = 'commentid';
            commentIdInput.value = item.comment_Id;

            var levelInput = document.createElement('input');
            levelInput.type = 'hidden';
            levelInput.className = 'level';
            levelInput.value = item.level;

            var rootCommentIdInput = document.createElement('input');
            rootCommentIdInput.type = 'hidden';
            rootCommentIdInput.className = 'rootcommentid';
            rootCommentIdInput.value = item.rootCommentId;

            var parentCommentIdInput = document.createElement('input');
            parentCommentIdInput.type = 'hidden';
            parentCommentIdInput.className = 'parentcommentid';
            parentCommentIdInput.value = item.parentCommentid;

            // li 요소 생성
            var writerLi = document.createElement('li');
            writerLi.className = 'letter_f';
            writerLi.innerHTML = '<strong>대댓글 작성자:' + item.user_id + '</strong>';

            var separatorLi = document.createElement('li');
            separatorLi.innerHTML = '<span>|</span>';

            var replyLi = document.createElement('li');
            replyLi.className = 'letter_reply_f02';
            replyLi.innerHTML = '<img alt="" src="${pageContext.request.contextPath}/resources/img/re.jpg" style="width:10px;height:10px;">&nbsp;<a onclick="AddComment_Content(this)" style="display: inline-block">답글</a>';

            var contentLi = document.createElement('li');
            contentLi.className = 'letter_cl';
            contentLi.textContent = item.content;

            // ul에 생성한 요소들 추가
            ul.appendChild(commentIdInput);
            ul.appendChild(levelInput);
            ul.appendChild(rootCommentIdInput);
            ul.appendChild(parentCommentIdInput);
            ul.appendChild(writerLi);
            ul.appendChild(separatorLi);
            ul.appendChild(replyLi);
            ul.appendChild(contentLi);

            // innerDiv에 ul 추가
            innerDiv.appendChild(ul);

            // 수정 삭제 가능한 ul 요소 생성
            var editDeleteUl = document.createElement('ul');
            editDeleteUl.className = 'letter_r';
            editDeleteUl.innerHTML = '<li><span>수정</span></li><li><span>|</span></li><li><span>삭제</span></li>';

            // innerDiv에 수정 삭제 가능한 ul 추가
            innerDiv.appendChild(editDeleteUl);

            // letter_top에 innerDiv 추가
            letterTop.appendChild(innerDiv);

            // letter_bottom 요소 생성
            var letterBottom = document.createElement('div');
            letterBottom.className = 'letter_bottom';

            // 대댓글보기 버튼 생성
            var viewReplyButton = document.createElement('input');
            viewReplyButton.type = 'button';
            viewReplyButton.value = '대댓글보기';
            viewReplyButton.onclick = function() {
                selectCommentChild(this);
            };

            // ul 요소 생성
            var ul2 = document.createElement('ul');
            var li2 = document.createElement('li');

            // ul에 li 추가
            ul2.appendChild(li2);

            // letter_bottom에 대댓글보기 버튼과 ul 추가
            letterBottom.appendChild(viewReplyButton);
            letterBottom.appendChild(ul2);

            // 최종적으로 생성한 요소 반환
            var commentElement = document.createElement('div');
            commentElement.className = 'contents';
            commentElement.appendChild(letterTop);
            commentElement.appendChild(letterBottom);

            return commentElement;
        }
        function AddComment(){
            var comment_content = $("#comment_contents").val();
            if (comment_content!="")
            {
                var level = 0;
                var rootcommentid = 0;
                var parentcommentid = 0;

                $.ajax({
                    url: '${pageContext.request.contextPath}/User/AddComment',
                    type: 'POST',
                    contentType: 'application/x-www-form-urlencoded;charset=UTF-8',
                    dataType: 'script',
                    data:{
                        pd_no :'${productInfo.no}',
                        level:level,
                        rootcommentid:rootcommentid,
                        parentcommentid:parentcommentid,
                        user_id:'${sessionScope.userInfo.id}',
                        comment_contents:comment_content
                    },
                    success: function(val) {
                        console.log(val);
                    }, error: function(e) {
                        alert('error');
                    }
                });
                location.href = "${pageContext.request.contextPath}/productInfo?no=${productInfo.no}";
            }
        }
        function AddComment_Content(btn){
            var btn_val = btn;
            var parentElement = btn_val.parentNode;

            var existingReplyContainer = parentElement.querySelector(".reply-container");
            if (existingReplyContainer){
                parentElement.removeChild(existingReplyContainer);
                return;
            }

            // 텍스트박스 생성
            var textarea = document.createElement("textarea");
            textarea.className = "reply-textarea";
            textarea.placeholder = "답글을 입력하시오";

            // 전송 버튼 생성
            var button = document.createElement("button");
            button.className = "reply-button";
            button.innerHTML = "전송";

            var replyDiv = document.createElement("span");
            replyDiv.className = "reply-container";
            replyDiv.appendChild(textarea);
            replyDiv.appendChild(button);0

            parentElement.appendChild(replyDiv);

            button.addEventListener("click",function(){
                var btn_val = this;
                var parentElement = btn_val.parentNode.parentNode;
                var levelInput = parentElement.parentNode.querySelector(".level").value;
                var level = parseInt(levelInput)+1;
                var parentcommentid = parentElement.parentNode.querySelector(".commentid").value;
                var rootcommentid = parentElement.parentNode.querySelector(".rootcommentid").value;
                var comment_content = parentElement.parentNode.querySelector(".reply-textarea").value;
                $.ajax({
                    url: '${pageContext.request.contextPath}/User/AddComment',
                    type: 'POST',
                    contentType: 'application/x-www-form-urlencoded;charset=UTF-8',
                    dataType: 'script',
                    data:{
                        pd_no :'${productInfo.no}',
                        level:level,
                        rootcommentid:rootcommentid,
                        parentcommentid:parentcommentid,
                        user_id:'${sessionScope.userInfo.id}',
                        comment_contents:comment_content
                    },
                    success: function(val) {
                        console.log(val);
                    }, error: function(e) {
                        alert('error');
                    }
                });
                location.href = "${pageContext.request.contextPath}/productInfo?no=${productInfo.no}";
            });

        }
        function selectCommentChild(btn){
            var btn_value = btn;
            var parentElement = btn_value.parentNode;

            //부모의 값이기 때문에 parentcommentid가 commentid값이 들어가야됨
            var levelInput = parentElement.parentNode.querySelector(".level").value;
            var level = parseInt(levelInput)+1;
            var rootcommentid = parentElement.parentNode.querySelector(".rootcommentid").value;
            var parentcommentid = parentElement.parentNode.querySelector(".commentid").value;
            $.ajax({
                url: '${pageContext.request.contextPath}/selectCommentChild',
                type: 'POST',
                contentType: 'application/x-www-form-urlencoded;charset=UTF-8',
                dataType: 'script',
                data:{
                    pd_no :'${productInfo.no}',
                    level:level,
                    rootcommentid:rootcommentid,
                    parentcommentid:parentcommentid,

                },
                success: function(commentData) {
                    var parsedData = JSON.parse(commentData);
                    parsedData.forEach(function(comment){
                        var commentElement = createCommentElement(comment);
                        commentElement.style.paddingLeft = "20px";
                        parentElement.appendChild(commentElement);

                    })
                    console.log(parsedData);
                }, error: function(e) {
                    alert('error');
                }
            });
        }

    </script>
</head>
<body >

	<div id="wrap">
		<!-- header -->
		
		<!--// header -->

		<div id="sub_container">
			<div id="contentsWrap" class="sub_con5">
				<div class="board_form">   
		            <div class="con_title">
		               <p>게시판 상세보기</p>   
		            </div>
				<div class="contents">
					<div class="btnSet clfix mgb15">
						<span class="fr">
                            <span class="button"><input type="button" onclick="location.href = '${pageContext.request.contextPath}/User/addMyCart?no=${productInfo.no}'" value="물품구매"/></span>
							<span class="button"><input type="button" onclick="location.href = '${pageContext.request.contextPath}/User/myProductPage'" value="장바구니"/> </span>
							<span class="button"><input type="button" onclick="location.href = '${pageContext.request.contextPath}/list'" value="목록"/></span>
						</span>
					</div>
					<table class="bbsList">
						<colgroup>
							<col width="400" />
                            <col width="100" />
                            <col width="" />
						</colgroup>
						<tr>
							<th scope="col" class="fir">이미지</th>
                             <th scope="col">글번호</th>
                             <td>${productInfo.no}</td>
                        </tr>
                        <tr>
                        
                          <td class="fir" rowspan="7"><img src="${pageContext.request.contextPath}/resources/upload/${productInfo.imgname}" width="400" height="300"/></td>
                          <th scope="col">아이디</th>
                          <td>${productInfo.userid}</td>
                        </tr>
                        <tr>
                          <th scope="col">상품이름</th>
                          <td>${productInfo.pdname}</td>
                        </tr>
                        <tr>
                          <th scope="col">가격</th>
                          <td>${productInfo.pdprice}</td>
                        </tr>
                        <tr>
                          <th scope="col">원산지</th>
                          <td>${productInfo.pdcountry}</td>
                        </tr>
                        <tr>
                          <th scope="col">카테고리</th>
                          <td>${productInfo.pdcategory}</td>
                        </tr>
                        <tr>
                          <th scope="col">등록일</th>
                          <td>${productInfo.pdreg}</td>
                        </tr>                        
					</table>
					
				</div>
			</div>
		</div>
		</div>
		<div class="board_form">
            <div class="board_writer03">
                 <ul>
                    <li><textarea id="comment_contents" rows="" cols="" ></textarea>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <input type="button"  value="등록" onclick="AddComment()"/></li>
                 </ul>
            </div>
            <c:forEach var="item" items="${commentInfo}">

                <div class="contents">
                    <div class="letter_top">
                        <div>
                            <ul>
                                <input type="hidden" class="commentid" value =${item.comment_Id}>
                                <input type="hidden" class="level" value = ${item.level}>
                                <input type="hidden" class="rootcommentid" value=${item.rootCommentId}>
                                <input type="hidden" class="parentcommentid" value =${item.parentCommentid}>
                                <li class="letter_f"><strong>작성자:${item.user_id}</strong> </li>
                                <li><span>|</span></li>
                                <li class="letter_reply_f02" >
                                    <img alt="" src="${pageContext.request.contextPath}/resources/img/re.jpg" style="width:10px;height:10px;">&nbsp;
                                    <a onclick="AddComment_Content(this)" style="display: inline-block">답글</a>
                                </li>

                                <li class="letter_cl">${item.content}</li>
                            </ul>

                            <!-- 내가 작성한 부분만 수정 삭제 가능 -->
                            <ul class="letter_r">
                                <li><span>수정 </span></li>
                                <li><span>|</span></li>
                                <li><span>삭제</span></li>
                            </ul>
                        </div>
                    </div>
                    <div class="letter_bottom">
                        <input type="button" value="대댓글보기" onclick="selectCommentChild(this)">

                    </div>
                </div>
            </c:forEach>


            <div class="board_writer03" style="display: none;">
                 <ul>
                    <li ><textarea rows="" cols="" ></textarea>&nbsp;&nbsp;<input type="button" value="등록" onclick="location.href='.jsp'"/></li>
                 </ul>
            </div>
        </div>
    </div>
		
	<!--Footer-->
     
   <!--END Footer-->	
	</div>
</body>

</html>






