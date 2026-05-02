using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Newtonsoft.Json;
using MiniStudentSystem.Models;

namespace MiniStudentSystem
{
    public partial class Register : System.Web.UI.Page
    {
        string filePath = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            filePath = Server.MapPath("~/App_Data/users.json");

            if (!File.Exists(filePath))
            {
                File.WriteAllText(filePath, "[]");
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string email = txtEmail.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password) || string.IsNullOrEmpty(email))
            {
                lblMessage.Text = "Bütün xanaları doldurun!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string json = File.ReadAllText(filePath);
            List<User> users = JsonConvert.DeserializeObject<List<User>>(json) ?? new List<User>();

            // 1. İstifadəçi adı yoxlanışı
            if (users.Any(u => u.Username.Equals(username, StringComparison.OrdinalIgnoreCase)))
            {
                lblMessage.Text = "Bu istifadəçi adı artıq mövcuddur!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // 2. SİZİN İSTƏDİYİNİZ EMAİL YOXLANIŞI:
            if (users.Any(u => u.Email.Equals(email, StringComparison.OrdinalIgnoreCase)))
            {
                lblMessage.Text = "Bu e-poçt ünvanı ilə artıq qeydiyyatdan keçilib!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            users.Add(new User { Username = username, Password = password, Email = email });
            File.WriteAllText(filePath, JsonConvert.SerializeObject(users, Formatting.Indented));

            lblMessage.Text = "Qeydiyyat uğurla tamamlandı!";
            lblMessage.ForeColor = System.Drawing.Color.Green;

            txtUsername.Text = "";
            txtPassword.Text = "";
            txtEmail.Text = "";
        }
    }
}