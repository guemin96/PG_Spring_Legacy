<%--
  Created by IntelliJ IDEA.
  User: guemi
  Date: 2023-05-25
  Time: 오전 9:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script type="text/javascript">
        function moveLogin(){
            location.href = "${pageContext.request.contextPath}/login"
        }



    </script>
</head>
<body>
    <button onclick="moveLogin()">로그인 화면</button>
</body>
</html>
