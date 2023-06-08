
function getCookie(key){
    var cookies = document.cookie.split(';');
    for (var i = 0; i<cookies.length;i++){
        var cookie = cookies[i].trim();
        if (cookie.startsWith(key+'=')){
            return cookie.substring(key.length+1);
        }
    }
    return null;
}
