using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using MiniStudentSystem.Models;

namespace MiniStudentSystem
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Əgər istifadəçi artıq daxil olubsa, birbaşa əsas səhifəyə yönləndiririk
            if (Session["UserLoggedIn"] != null || Request.Cookies["UserInfo"] != null)
            {
                Response.Redirect("Students.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            string filePath = Server.MapPath("~/App_Data/users.json");

            if (!File.Exists(filePath))
            {
                lblMessage.Text = "Sistemdə hələ heç bir istifadəçi qeydiyyatdan keçməyib!";
                return;
            }

            string json = File.ReadAllText(filePath);
            List<User> users = JsonConvert.DeserializeObject<List<User>>(json) ?? new List<User>();

            var user = users.FirstOrDefault(u => u.Username.Equals(username, StringComparison.OrdinalIgnoreCase) && u.Password == password);

            if (user != null)
            {
                
                Session["UserLoggedIn"] = user.Username;

                // Əgər "Məni xatırla" seçilibsə cookie yaradırıq (istəyə bağlıdır)
                if (chkRemember.Checked)
                {
                    HttpCookie userCookie = new HttpCookie("UserInfo");
                    userCookie["UserName"] = user.Username;
                    userCookie.Expires = DateTime.Now.AddDays(15);
                    Response.Cookies.Add(userCookie);
                }

              
                Response.Redirect("Students.aspx");
            }
        
            else
            {
                lblMessage.Text = "İstifadəçi adı və ya parol yanlışdır!";
            }
        }
    }
}