<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width" />
    <title>Index</title>
</head>
<body>
    <div>
        <label>用户名：</label><input id="userName" type="text" /><label id="lab"></label>
        <label>密码：</label><input id="passWord" type="password" />
        <input type="button" value="查看所有信息" id="btn" />
    </div>
    <script type="text/javascript" src="../ajax.js"></script>
    <script>
        var userName = document.getElementById('userName');
        var lab = document.getElementById('lab');
        userName.onblur = function () {
            var httpReq = new XMLHttpRequest();
            httpReq.open('POST', 'Check?UserName='+userName.value, true);
           
            httpReq.onreadystatechange = function () {
                if (httpReq.readyState === 4) {
                    if (httpReq.status === 200) {
                        if (httpReq.responseText == 'ok') {
                            lab.style.color = "green";
                            lab.innerHTML = 'ok';
                        }
                        else if (httpReq.responseText == "forbid") {
                            lab.style.color = "red";
                            lab.innerHTML = "forbid";
                        }
                        else {
                            lab.style.color = "red";
                            lab.innerHTML = "已存在该用户";
                        }
                    }
                    else {
                        alert(httpReq.status);
                        alert(httpReq.responseText);
                    }
                }
            }
            httpReq.send();
        }

        document.getElementById("btn").onclick = function () {
            ajax("POST", "ListAll", function (resText) {
                var users = JSON.parse(resText);
                for (var i = 0; i < users.length; i++) {
                    alert("username:" + users[i].UserName + ",Password:" + users[i].PassWord);
                }
            })
        }
        
        
    </script>
</body>
</html>
