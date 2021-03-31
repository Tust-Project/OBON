<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageNotree.master" AutoEventWireup="true" CodeFile="Outbound3901375.aspx.cs" Inherits="Outbound3901375" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        function OpenURL(uname,url)
        {
            var cmd = "OPENURL" + uname + "," + url;
            parent.postMessage(cmd,"*");
        }

        //外撥postMessage("MAKECALL"+calledNum + "," + DN + "," + ANI,"*");
        //外撥
        //原走京威線路
        function MobileSend() {
            var msg = "MAKECALL0" + document.getElementById("ContentPlaceHolder1_txbPhone").value + ",,0255723078";
            parent.postMessage(msg, "*");
        }
        ////再靠北外撥就改下面走回AVAYA Trunk 29 但會顯示0982-441-099裕隆汽車貸款
        //function MobileSend() {
        //    var msg = "MAKECALL*024029" + document.getElementById("ContentPlaceHolder1_txbPhone").value + ",,0255992510";
        //    parent.postMessage(msg, "*");
        //}
        //function MobileSend() {
        //    var msg = "MAKECALL0" + document.getElementById("ContentPlaceHolder1_txbPhone").value + ",,255723078,0255723078@@" + document.getElementById("ContentPlaceHolder1_txbPhone").value + "";
        //    parent.postMessage(msg, "*");
        //}


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
        <asp:Button ID="btnAudi" runat="server" BackColor="Red" ForeColor="White" Height="31px" Text="外撥" OnClientClick="MobileSend();CloseURL();" Width="96px" />

    <p>
        <asp:Label ID="lblErrorShow" runat="server"></asp:Label>
        <asp:Label ID="lblOBID" runat="server"></asp:Label>
    </p>
    
</asp:Content>

