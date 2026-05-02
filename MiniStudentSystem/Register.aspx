<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="MiniStudentSystem.Register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Qeydiyyat</title>
    <style>
        /* Səhifənin arxa fonu (Login ilə eyni) */
        body {
            /* ŞƏKLİN ADINI BURADA DƏYİŞƏCƏKSİNİZ (Login səhifəsində yazdığınız eyni adı yazın) */
            background-image: url('Images/arxafon.jpg'); 
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-color: #f4f7f6;
            
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* Üst Başlıq */
        .main-title {
            font-size: 26px;
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
            text-shadow: 1px 1px 3px rgba(255, 255, 255, 0.8);
        }

        /* Ağ Qutu (Card) */
        .register-card {
            background-color: white;
            padding: 40px;
            border-radius: 5px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            width: 320px;
        }

        /* İnput qutuları */
        .form-control {
            width: 100%;
            padding: 10px 15px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
            outline: none;
        }
        
        .form-control:focus {
            border-color: #5bc0de;
        }

        /* Qeydiyyat düyməsi */
        .btn-register {
            background-color: #5bc0de; /* Fərqli rəng ki, Login-dən seçilsin */
            color: white;
            border: none;
            padding: 10px;
            width: 100%;
            border-radius: 3px;
            cursor: pointer;
            font-size: 15px;
            font-weight: bold;
            transition: 0.3s;
            margin-bottom: 20px;
        }

        .btn-register:hover {
            background-color: #31b0d5;
        }

        /* Ayırıcı Xətt */
        .divider {
            border-top: 1px solid #eee;
            margin-bottom: 20px;
        }

        /* Login Linki hissəsi */
        .login-section {
            text-align: center;
            font-size: 14px;
            color: #555;
        }

        .login-link {
            color: #337ab7;
            font-weight: bold;
            text-decoration: none;
            margin-left: 5px;
        }

        .login-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        
        <div class="main-title">Yeni Hesab Yarat</div>
        
        <div class="register-card">
            
            <asp:Label ID="lblMessage" runat="server" Font-Size="13px" style="display:block; margin-bottom:10px; text-align:center;"></asp:Label>

            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="İstifadəçi adı"></asp:TextBox>
            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" placeholder="E-poçt ünvanı"></asp:TextBox>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Parol"></asp:TextBox>

            <asp:Button ID="btnRegister" runat="server" Text="Qeydiyyatdan Keç" CssClass="btn-register" OnClick="btnRegister_Click" />

            <div class="divider"></div>

            <div class="login-section">
                Artıq hesabınız var? 
                <a href="Login.aspx" class="login-link">Daxil olun</a>
            </div>

        </div>

    </form>
</body>
</html>