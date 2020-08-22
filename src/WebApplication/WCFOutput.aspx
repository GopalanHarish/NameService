<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WCFOutput.aspx.cs" Inherits="WebApplication.WCFOutput" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Enter name:
            <asp:TextBox ID="nametb" runat="server"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="Invoke WCF" OnClick="Unnamed_Click" />
            <br/><br/>Outut from svc is <br/><asp:Label ID="outputlb" runat="server"></asp:Label>
        </div>
    </form>
</body>
</html>
