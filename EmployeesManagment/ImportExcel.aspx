<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ImportExcel.aspx.cs" Inherits="EmployeesManagment.ImportExcel" %>

<!DOCTYPE html>
<html lang="ar">
<head runat="server">
    <title>استيراد من Excel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="p-4">
<form id="form1" runat="server" class="container">
    <h4>استيراد بيانات الموظفين من ملف Excel</h4>
    <asp:FileUpload ID="fuExcel" runat="server" CssClass="form-control mb-3" />
    <asp:Button ID="btnUpload" runat="server" Text="استيراد" CssClass="btn btn-primary" OnClick="btnUpload_Click" />
    <asp:Label ID="lblStatus" runat="server" CssClass="d-block mt-2" />
</form>
</body>
</html>
