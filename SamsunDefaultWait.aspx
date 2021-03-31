<%@ Page Language="C#" MasterPageFile="~/MasterPageNotree.master" AutoEventWireup="true" CodeFile="SamsunDefaultWait.aspx.cs" Inherits="SamsunDefaultWait" Title="台灣優勢外撥紀錄" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 1000px;
            font-weight: bold;
        }
        .style2
        {
            font-size: x-large;
        }
        .style3
        {
            color: #FF0066;
        }
        .style4
        {
            font-size: small;
        }
        .style5
        {
            border-left-color: #A0A0A0;
            border-right-color: #FFFFFF;
            border-top-color: #A0A0A0;
            border-bottom-color: #FFFFFF;
        }
    </style>
    <script>
        function OpenURL(uname,url)
        {
            var cmd = "OPENURL" + uname + "," + url;
            parent.postMessage(cmd,"*");
        }
    </script>    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table cellpadding="0" cellspacing="0" class="style1">
        <tr>
            <td class="style2" style="text-align: left">
                                &nbsp;

                　<asp:Button ID="btnCallOut" runat="server" BackColor="#FFDDCC" Height="36px" 
                    OnClientClick="OpenURL('外撥視窗','http://172.30.200.71/OBON/SamsunOutbound.aspx?agentid=$_AGENT_ID_$')" 
                    Text="外撥" Width="120px" />
                                </td>
        </tr>
        <tr>
            <td class="style2" style="text-align: center">
                <br />
                <br />
                <br />
                <span class="style3">Wait for Call&nbsp; 等待來電<br />
                <br />
                </span><span class="style4"><span class="style5">Login agent id</span>：<asp:Label ID="lblAgentID" runat="server"></asp:Label><br />
                </span></td>
        </tr>
    </table>
    <div style="display:none"><iframe src="wFrmRefresh.aspx" id="refresh"></iframe></div>
</asp:Content>

