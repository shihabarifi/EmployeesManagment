<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SearchEmployee.aspx.cs" Inherits="EmployeesManagment.SearchEmployee" %>

<!DOCTYPE html>
<html lang="ar">
<head runat="server">
    <title>البحث عن موظف</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
</head>
<body class="d-flex flex-column justify-content-center align-items-center" style="height:100vh;">
    <form id="form1" runat="server" class="w-50 text-center">
        <h1 class="mb-4">🔎 نظام الموظفين</h1>
        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control form-control-lg mb-3" placeholder="ابحث بالاسم أو الهاتف..." />
        <asp:Button ID="btnFind" runat="server" Text="بحث" CssClass="btn btn-primary btn-lg" OnClick="btnFind_Click" />
        <asp:GridView ID="gvResults" runat="server" AutoGenerateColumns="false" CssClass="table table-striped mt-4" Visible="false">
            <Columns>
                <asp:BoundField DataField="FullName" HeaderText="الاسم" />
                <asp:BoundField DataField="PhoneNumber" HeaderText="رقم الهاتف" />
            </Columns>
        </asp:GridView>
    </form>

<script>
$(function(){
  $("#<%=txtSearch.ClientID%>").autocomplete({
      source:function(request,response){
          $.ajax({
              url:"SearchEmployee.aspx/GetSuggestions",
              method:"POST",
              contentType:"application/json; charset=utf-8",
              data:JSON.stringify({ term: request.term }),
              success:function(data){ response(JSON.parse(data.d)); },
              error:function(){ response([]); }
          });
      },
      minLength:2
  });
});
</script>
</body>
</html>
