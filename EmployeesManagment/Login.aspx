<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="EmployeesManagment.Login" %>

<!DOCTYPE html>
<html lang="ar">
<head runat="server">
    <title>تسجيل الدخول</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light d-flex align-items-center" style="height:100vh;">
    <form id="form1" runat="server" class="container">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="card shadow-lg">
                    <div class="card-body">
                        <h3 class="text-center mb-3">تسجيل الدخول</h3>
                        <asp:TextBox ID="txtUser" runat="server" CssClass="form-control mb-3" placeholder="اسم المستخدم" />
                        <asp:TextBox ID="txtPass" runat="server" CssClass="form-control mb-3" placeholder="كلمة المرور" TextMode="Password" />
                        <asp:Button ID="btnLogin" runat="server" Text="دخول" CssClass="btn btn-primary w-100" OnClick="btnLogin_Click" />
                        <asp:Label ID="lblMsg" runat="server" CssClass="text-danger d-block mt-2" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
