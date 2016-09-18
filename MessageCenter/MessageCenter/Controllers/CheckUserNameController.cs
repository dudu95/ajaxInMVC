using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace MessageCenter.Controllers
{
    public class CheckUserNameController : Controller
    {
        //
        // GET: /CheckUserName/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Check()
        {
            string userName = Request["UserName"];
            if(userName.Contains("tmd")||userName.Contains("尼玛")){
                return Content("forbid");
            }
            int count = SqlHelper.ExecuteScalar("select count(*) from TableUser where UserName = @UserName", new SqlParameter("@UserName", userName));
     
            if (count <= 0)
            {
                return Content("ok");
            }
            else {
                return Content("error");
            }

        }

        public ActionResult ListAll()
        {
            DataTable dt = SqlHelper.ExecuteDataTable("select * from TableUser");
            List<User> users = new List<User>();
            foreach(DataRow dr in dt.Rows){
                User user = new User();
                user.Id = (int)dr["Id"];
                user.UserName = (string)dr["UserName"];
                user.PassWord = (string)dr["PassWord"];
                users.Add(user);
            }
           // JavaScriptSerializer serializer = new JavaScriptSerializer();
           // return Content(serializer.Serialize(users));

            return Json(users, JsonRequestBehavior.AllowGet);

        }

    }
}
