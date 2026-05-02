<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Students.aspx.cs" Inherits="MiniStudentSystem.Students" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4361ee;
            --primary-hover: #3730a3;
            --danger: #ef4444;
            --success: #10b981;
            --bg: #f3f4f6;
            --card: #ffffff;
            --text-main: #1f2937;
            --text-muted: #6b7280;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg);
            color: var(--text-main);
            margin: 0;
            padding: 0;
        }

        .navbar {
            background: var(--card);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .navbar h2 { margin: 0; font-size: 1.25rem; font-weight: 600; color: var(--primary); }

        .btn-logout {
            background: #fee2e2; color: var(--danger); border: none;
            padding: 6px 12px; border-radius: 6px; cursor: pointer; font-weight: 600;
        }

        .container {
            max-width: 1200px; margin: 30px auto;
            display: grid; grid-template-columns: 320px 1fr; gap: 25px; padding: 0 20px;
        }

        .card {
            background: var(--card); border-radius: 12px; padding: 20px;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);
        }

        .form-group { margin-bottom: 12px; }
        
        .form-control {
            width: 100%; padding: 10px; border: 1px solid #d1d5db;
            border-radius: 8px; font-size: 14px; box-sizing: border-box;
        }

        .btn-save {
            width: 100%; background: var(--primary); color: white; border: none;
            padding: 10px; border-radius: 8px; font-weight: 600; cursor: pointer;
        }

        .search-bar {
            display: flex; gap: 10px; margin-bottom: 20px;
            background: #f9fafb; padding: 15px; border-radius: 10px;
        }

        .student-table { width: 100%; border-collapse: collapse; }
        .student-table th { text-align: left; padding: 12px; color: var(--text-muted); border-bottom: 2px solid #f3f4f6; font-size: 0.85rem; }
        .student-table td { padding: 12px; border-bottom: 1px solid #f3f4f6; }

        .action-btn { text-decoration: none; font-weight: 600; font-size: 0.85rem; margin-right: 10px; }
        .edit-btn { color: var(--primary); }
        .delete-btn { color: var(--danger); }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        
        <nav class="navbar">
            <h2>TələbəSistemi</h2>
            <div>
                <span>Xoş gəldiniz, <strong><asp:Label ID="lblUsername" runat="server"></asp:Label></strong></span>
                <asp:Button ID="btnLogout" runat="server" Text="Çıxış" CssClass="btn-logout" OnClick="btnLogout_Click" style="margin-left:15px;"/>
            </div>
        </nav>

        <div class="container">
            <div class="card">
                <h3>Tələbə Məlumatı</h3>
                <asp:HiddenField ID="hfStudentId" runat="server" />
                <div class="form-group"><asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Ad"></asp:TextBox></div>
                <div class="form-group"><asp:TextBox ID="txtSurname" runat="server" CssClass="form-control" placeholder="Soyad"></asp:TextBox></div>
                <div class="form-group"><asp:TextBox ID="txtNumber" runat="server" CssClass="form-control" placeholder="Tələbə nömrəsi"></asp:TextBox></div>
                
                <asp:Button ID="btnSave" runat="server" Text="Yadda Saxla" CssClass="btn-save" OnClick="btnSave_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Ləğv Et" CssClass="btn-save" style="background:#6b7280; margin-top:5px;" Visible="false" OnClick="btnCancel_Click" />
                
                <asp:Label ID="lblMessage" runat="server" style="display:block; margin-top:10px; font-size:13px; font-weight:bold;"></asp:Label>
            </div>

            <div class="card">
                <div class="search-bar">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Ad, Soyad və ya No ilə axtar..."></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="Axtar" CssClass="btn-save" style="width:100px; margin:0;" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnClearSearch" runat="server" Text="Sıfırla" CssClass="btn-save" style="width:100px; margin:0; background:#9ca3af;" OnClick="btnClearSearch_Click" />
                </div>

                <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="False" 
                    CssClass="student-table" GridLines="None" OnRowCommand="gvStudents_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Name" HeaderText="Ad" />
                        <asp:BoundField DataField="Surname" HeaderText="Soyad" />
                        <asp:BoundField DataField="StudentNumber" HeaderText="Tələbə No" />
                        <asp:TemplateField HeaderText="Əməliyyatlar">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditStudent" CommandArgument='<%# Eval("Id") %>' Text="Redaktə" CssClass="action-btn edit-btn" />
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteStudent" CommandArgument='<%# Eval("Id") %>' Text="Sil" CssClass="action-btn delete-btn" OnClientClick="return confirm('Silinsin?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>