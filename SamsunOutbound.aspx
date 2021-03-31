<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageNotree.master" AutoEventWireup="true" CodeFile="SamsunOutbound.aspx.cs" Inherits="SamsunOutbound" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        function OpenURL(uname,url)
        {
            var cmd = "OPENURL" + uname + "," + url;
            parent.postMessage(cmd,"*");
        }

        ////外撥postMessage("MAKECALL"+calledNum + "," + DN + "," + ANI,"*");
        ////外撥
        //function MobileSend() {
        //    var msg = "MAKECALL0" + document.getElementById("ContentPlaceHolder1_txbPhone").value + ",";
        //    parent.postMessage(msg, "*");
        //}


        //外撥postMessage("MAKECALL"+calledNum + "," + DN + "," + ANI,"*");
        //行動電話
        function MobileSend() {
            var msg = "MAKECALL0" + document.getElementById("ctl00_ContentPlaceHolder1_txbPhone").value + ",,280699026,0280699026@@" + document.getElementById("ctl00_ContentPlaceHolder1_txbPhone").value + "";
            parent.postMessage(msg, "*");
        }

        //Agent 恢復成可以READY
        function CHANGEAGENTSTATEReady() {
            parent.postMessage("CHANGEAGENTSTATE3", "*");
        }


        //關視窗
        var Index = "";  //視窗索引

        window.onmessage = function (evt) {
            var msg = "";

            if (window.event) {
                msg = window.event.data;
            } else {
                msg = evt.data;
            }

            if (msg.substring(0, 8) == "URLINDEX") {
                Index = msg.substring(8);
            }
        }
        function CloseURL() {
            parent.postMessage("CLOSEURL" + window.location, "*");
        }
    </script>

    <style type="text/css">
        .auto-style1 {
            font-size: x-large;
            color: #666666;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p class="auto-style1">

        <strong>外撥</strong></p>
    <p>

        輸入電話號碼：<asp:TextBox ID="txbPhone" runat="server" Height="20px"></asp:TextBox>
        <asp:Button ID="btnAudi" runat="server" BackColor="#3333FF" ForeColor="White" Height="31px" Text="三星外撥" OnClientClick="MobileSend();CloseURL();" Width="96px" />

    <p>
        <asp:Label ID="lblErrorShow" runat="server"></asp:Label>
        <asp:Label ID="lblOBID" runat="server"></asp:Label>
    </p>
    
</asp:Content>

