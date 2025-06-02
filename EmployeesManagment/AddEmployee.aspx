<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddEmployee.aspx.cs" Inherits="EmployeesManagment.AddEmployee" %>

<!DOCTYPE html>
<html lang="ar">
<head runat="server">
    <title>إضافة موظف</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<form id="form1" runat="server" class="container py-4">
    <h4>إضافة موظف جديد</h4>
    <div class="row mb-3">
        <div class="col-md-4">
            <asp:TextBox ID="txtEmpNum" runat="server" CssClass="form-control" placeholder="رقم الموظف" />
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="اسم الموظف" />
        </div>
        <div class="col-md-4">
            <asp:DropDownList ID="ddlBranch" runat="server" CssClass="form-select" />
        </div>
    </div>
    <div class="row mb-3">
        <div class="col-md-4">
            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select" />
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtPosition" runat="server" CssClass="form-control" placeholder="المسمى الوظيفي" />
        </div>
        <div class="col-md-4">
            <asp:TextBox ID="txtHireDate" runat="server" CssClass="form-control" placeholder="تاريخ التعيين (yyyy-MM-dd)" />
        </div>
    </div>
    <h5>أرقام الهواتف</h5>
    <table class="table" id="tblPhones">
        <thead><tr><th>الرقم</th><th>النوع</th><th></th></tr></thead>
        <tbody>
            <tr>
                <td><input name="phones" class="form-control" /></td>
                <td><input name="types" class="form-control" /></td>
                <td></td>
            </tr>
        </tbody>
    </table>
    <button type="button" id="addRow" class="btn btn-secondary mb-3">إضافة رقم آخر</button>
    <asp:Button ID="btnSave" runat="server" Text="حفظ" CssClass="btn btn-primary" OnClick="btnSave_Click" />
    <asp:Label ID="lblMsg" runat="server" CssClass="text-success ms-3" />
</form>
<script>
$("#addRow").click(function(){
    $("#tblPhones tbody").append("<tr><td><input name='phones' class='form-control'/></td><td><input name='types' class='form-control'/></td><td></td></tr>");
});
</script>
</body>
</html>
