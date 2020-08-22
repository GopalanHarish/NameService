<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FileCreate.aspx.cs" Inherits="WebApplication.FileCreate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            File name:
            <asp:TextBox ID="filetb" runat="server" Text="C:\harish.txt"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="Create File" OnClick="Button1_Click" />
            <br/><asp:Label ID="outputlb" runat="server"></asp:Label>
        </div>
    </form>
</body>
</html>
