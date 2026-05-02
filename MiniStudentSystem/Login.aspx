<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MiniStudentSystem.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sistemə Giriş</title>
    <style>
        /* Səhifənin arxa fonu */
        body {
            /* ŞƏKLİN ADINI BURADA DƏYİŞƏCƏKSİNİZ */
            background-image: url('Images/arxafon.jpg'); 
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-color: #f4f7f6; /* Şəkil yüklənməyəndə görünəcək rəng */
            
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* Tələbə Məlumat Sistemi - Üst Başlıq */
        .main-title {
            font-size: 26px;
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
            text-shadow: 1px 1px 3px rgba(255, 255, 255, 0.8);
        }

        /* Ağ Qutu (Card) */
        .login-card {
            background-color: white;
            padding: 40px;
            border-radius: 5px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            width: 320px;
        }

        /* İnput qutuları (Username və Password) */
        .form-control {
            width: 100%;
            padding: 10px 15px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box; /* Padding-in genişliyi pozmamasının qarşısını alır */
            font-size: 14px;
            outline: none;
        }
        
        .form-control:focus {
            border-color: #337ab7;
        }

        /* Daxil ola bilmirəm və Daxil ol düyməsinin sətri */
        .action-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 5px;
            margin-bottom: 20px;
        }

        .forgot-link {
            color: #337ab7;
            text-decoration: none;
            font-size: 13px;
        }

        .forgot-link:hover {
            text-decoration: underline;
        }

        /* Daxil ol düyməsi */
        .btn-login {
            background-color: #337ab7;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 3px;
            cursor: pointer;
            font-size: 14px;
            transition: 0.3s;
        }

        .btn-login:hover {
            background-color: #286090;
        }

        /* Qeydiyyat hissəsi üçün xətt və mətn */
        .divider {
            border-top: 1px solid #eee;
            margin-bottom: 20px;
        }

        .register-section {
            text-align: center;
            font-size: 14px;
            color: #555;
        }

        .register-link {
            color: #d9534f; /* Qırmızımtıl rəng diqqət çəkir */
            font-weight: bold;
            text-decoration: none;
            margin-left: 5px;
        }

        .register-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        
        <div class="main-title">Tələbə Qeydiyyat Sistemi</div>
        
        <div class="login-card">
            
            <asp:Label ID="lblMessage" runat="server" ForeColor="#d9534f" Font-Size="13px" style="display:block; margin-bottom:10px; text-align:center;"></asp:Label>

            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="İstifadəçi adı"></asp:TextBox>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Parol"></asp:TextBox>
            <div style="margin-bottom: 15px; text-align: left; font-size: 14px; color: #555;">
    <asp:CheckBox ID="chkRemember" runat="server" Text=" Məni xatırla" />
</div>
            <div class="action-row">
                <a href="#" class="forgot-link">Daxil ola bilmirəm</a>
                <asp:Button ID="btnLogin" runat="server" Text="Daxil ol" CssClass="btn-login" OnClick="btnLogin_Click" />
            </div>

            <div class="divider"></div>

            <div class="register-section">
                Hesabınız yoxdur? 
                <a href="Register.aspx" class="register-link">Qeydiyyatdan keçin</a>
            </div>

        </div>

    </form>
</body>
</html>
