function ajax(type, url, onsuccess) {
    var xmlHttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
    xmlHttp.open(type, url, true);
    xmlHttp.onreadystatechange = function () {
        if (xmlHttp.readyState === 4) {
            if (xmlHttp.status === 200) {
                onsuccess(xmlHttp.responseText);
            } else {
                alert(xmlHttp.status);
            }
        }
    }
    xmlHttp.send();
}