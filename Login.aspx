<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style5
        {
            width: 1024px;
            height: 600px;
            margin-bottom: 93px;
        }
        .style8
        {
            width: 490px;
            top: 188px;
            left: 158px;
        }
        .style13
        {
            width: 133px;
            height: 73px;
            text-align: center;
        }
        .style14
        {
            height: 73px;
        }
        .style11
        {
            width: 133px;
            height: 75px;
            text-align: center;
        }
        .style12
        {
            height: 75px;
        }
        .style9
        {            text-align: center;
        }
        .style15
        {
            font-size: 9pt;
            color: #FF0000;
            border-left-color: #808080;
            border-right-color: #FFFFFF;
            border-top-color: #808080;
            border-bottom-color: #FFFFFF;
        }
        .style17
        {
            height: 298px;
            width: 500px;
        }
        .style18
        {
            height: 130px;
            width: 500px;
        }
        .style19
        {
            width: 500px;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style5">
        <tr>
            <td class="style18" valign="top">
            </td>
        </tr>
        <tr>
            <td class="style17" valign="top">
                <table align="center" class="style8" 
                    style="position: absolute; z-index: auto; width: 383px">
                    <tr bgcolor="#F9B7E1">
                        <td class="style13" valign="middle">
                            Login ID
                            <br />
                            帳號</td>
                        <td class="style14" style="text-align: left">
                            <asp:TextBox ID="txbLoginID" runat="server" Width="173px" Height="27px"></asp:TextBox>
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                ControlToValidate="txbLoginID" ErrorMessage="Please key in login id"></asp:RequiredFieldValidator>
                            </td>
                    </tr>
                    <tr bgcolor="#CEDEEC">
                        <td class="style11">
                            Login Password<br />
                            密碼</td>
                        <td class="style12" style="text-align: left">
                            <asp:TextBox ID="txbPW" runat="server" Height="27px" 
                                style="text-align: left" TextMode="Password" Width="171px"></asp:TextBox>
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                ControlToValidate="txbPW" ErrorMessage="Please key in login password"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="style9" colspan="2">
                            <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="OK 確定" 
                                Height="28px" Width="75px" />
                            <br />
                            <span class="style15">
                            <br />
                            <asp:Label ID="Label1" runat="server"></asp:Label>
                            </span>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="style19">
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>

