using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using MiniStudentSystem.Models;

namespace MiniStudentSystem
{
    public partial class Students : System.Web.UI.Page
    {
        // Məlumatların saxlanacağı fayl yolu
        string filePath = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Təhlükəsizlik: Giriş edilməyibsə Login-ə göndər
            if (Session["UserLoggedIn"] == null && Request.Cookies["UserInfo"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // Session yoxdursa amma Cookie varsa, bərpa et
            if (Session["UserLoggedIn"] == null && Request.Cookies["UserInfo"] != null)
            {
                Session["UserLoggedIn"] = Request.Cookies["UserInfo"]["UserName"];
            }

            filePath = Server.MapPath("~/App_Data/students.json");

            if (!IsPostBack)
            {
                lblUsername.Text = Session["UserLoggedIn"].ToString();
                LoadStudents();
            }
        }

        // Tələbələri JSON-dan oxuyub cədvələ yükləyən funksiya
        private void LoadStudents()
        {
            if (!File.Exists(filePath)) File.WriteAllText(filePath, "[]");

            string json = File.ReadAllText(filePath);
            var allStudents = JsonConvert.DeserializeObject<List<Student>>(json) ?? new List<Student>();

            // Yalnız daxil olan istifadəçiyə aid olanları seç:
            string currentUser = Session["UserLoggedIn"].ToString();
            var myStudents = allStudents.Where(s => s.CreatedBy == currentUser).ToList();

            gvStudents.DataSource = myStudents;
            gvStudents.DataBind();
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            string currentNumber = txtNumber.Text.Trim();
            string name = txtName.Text.Trim();
            string surname = txtSurname.Text.Trim();
            string currentUser = Session["UserLoggedIn"].ToString(); // Hazırkı istifadəçi

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(currentNumber))
            {
                lblMessage.Text = "Ad və nömrə boş ola bilməz!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (!File.Exists(filePath)) File.WriteAllText(filePath, "[]");
            string json = File.ReadAllText(filePath);
            var allStudents = JsonConvert.DeserializeObject<List<Student>>(json) ?? new List<Student>();

            // --- YOXLANIŞ HİSSƏSİ ---
            if (string.IsNullOrEmpty(hfStudentId.Value)) // Yeni tələbə əlavə edilirsə
            {
                // YALNIZ BU İSTİFADƏÇİNİN SİYAHISINDA bu nömrə varmı?
                bool existsInMyList = allStudents.Any(s =>
                    s.StudentNumber.Equals(currentNumber, StringComparison.OrdinalIgnoreCase) &&
                    s.CreatedBy == currentUser);

                if (existsInMyList)
                {
                    lblMessage.Text = $"Sizin siyahınızda {currentNumber} nömrəli tələbə artıq var!";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                var newStudent = new Student
                {
                    Id = Guid.NewGuid().ToString(),
                    Name = name,
                    Surname = surname,
                    StudentNumber = currentNumber,
                    CreatedBy = currentUser
                };
                allStudents.Add(newStudent);
                lblMessage.Text = "Tələbə əlavə edildi.";
            }
            else // Redaktə edilirsə
            {
                // Öz nömrəmizdən başqa, BİZİM SİYAHIMIZDA bu nömrə varmı?
                bool duplicateInMyList = allStudents.Any(s =>
                    s.StudentNumber.Equals(currentNumber, StringComparison.OrdinalIgnoreCase) &&
                    s.CreatedBy == currentUser &&
                    s.Id != hfStudentId.Value);

                if (duplicateInMyList)
                {
                    lblMessage.Text = "Sizin siyahınızda bu nömrə artıq istifadə olunub!";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                var student = allStudents.FirstOrDefault(s => s.Id == hfStudentId.Value);
                if (student != null)
                {
                    student.Name = name;
                    student.Surname = surname;
                    student.StudentNumber = currentNumber;
                    lblMessage.Text = "Yeniləndi.";
                }
            }

            File.WriteAllText(filePath, JsonConvert.SerializeObject(allStudents, Formatting.Indented));
            lblMessage.ForeColor = System.Drawing.Color.Green;

            ClearForm();
            LoadStudents();
        }
        // Cədvəldəki düymələr (Sil və Redaktə)
        protected void gvStudents_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            string json = File.ReadAllText(filePath);
            var students = JsonConvert.DeserializeObject<List<Student>>(json);

            if (e.CommandName == "DeleteStudent")
            {
                // SİLMƏK
                students.RemoveAll(s => s.Id == id);
                File.WriteAllText(filePath, JsonConvert.SerializeObject(students, Formatting.Indented));
                LoadStudents();
                lblMessage.Text = "Tələbə silindi.";
                lblMessage.ForeColor = System.Drawing.Color.Orange;
            }
            else if (e.CommandName == "EditStudent")
            {
                // REDAKTƏ REJİMİNƏ KEÇMƏK
                var student = students.FirstOrDefault(s => s.Id == id);
                if (student != null)
                {
                    txtName.Text = student.Name;
                    txtSurname.Text = student.Surname;
                    txtNumber.Text = student.StudentNumber;
                    hfStudentId.Value = student.Id; // Gizli xanaya ID-ni qoyuruq

                    btnSave.Text = "Yenilə";
                    btnCancel.Visible = true;
                    lblMessage.Text = "Məlumatları redaktə edirsiniz...";
                    lblMessage.ForeColor = System.Drawing.Color.Blue;
                }
            }
        }

        // Ləğv Et düyməsi
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        // Formu təmizləmə funksiyası
        private void ClearForm()
        {
            txtName.Text = "";
            txtSurname.Text = "";
            txtNumber.Text = "";
            hfStudentId.Value = "";
            btnSave.Text = "Yadda Saxla";
            btnCancel.Visible = false;
        }

        // Çıxış düyməsi
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            if (Request.Cookies["UserInfo"] != null)
            {
                HttpCookie myCookie = new HttpCookie("UserInfo");
                myCookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(myCookie);
            }
            Response.Redirect("Login.aspx");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchText = txtSearch.Text.Trim().ToLower();
            string currentUser = Session["UserLoggedIn"].ToString();

            string json = File.ReadAllText(filePath);
            var allStudents = JsonConvert.DeserializeObject<List<Student>>(json) ?? new List<Student>();

            // Həm istifadəçiyə aid olmalıdır, həm də axtarış sözünə uyğun:
            var filteredList = allStudents.Where(s =>
                s.CreatedBy == currentUser &&
                (s.Name.ToLower().Contains(searchText) ||
                 s.Surname.ToLower().Contains(searchText) ||
                 s.StudentNumber.ToLower().Contains(searchText))
            ).ToList();

            gvStudents.DataSource = filteredList;
            gvStudents.DataBind();
        }

        protected void btnClearSearch_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            LoadStudents();
            lblMessage.Text = "";
        }
    }
}