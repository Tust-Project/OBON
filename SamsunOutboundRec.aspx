<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageNotree.master" AutoEventWireup="true" CodeFile="SamsunOutboundRec.aspx.cs" Inherits="SamsunOutboundRec" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        function OpenURL(uname,url)
        {
            var cmd = "OPENURL" + uname + "," + url;
            parent.postMessage(cmd,"*");
        }

        //Agent 無法手動切換值機狀態
        function BLOCKAGENTSTATE1() {
            parent.postMessage("BLOCKAGENTSTATE1", "*");
        }
        //Agent 恢復成可以手動
        function BLOCKAGENTSTATE0() {
            parent.postMessage("BLOCKAGENTSTATE0", "*");
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


        //呼叫關閉視窗時,先向ADT要求取得視窗正確的Index, 從發出GETURLINDEX到取得ADT送來的Index, 這中間所花費的世間應該在200ms以內,
        //所以設定200ms之後去執行 CloseURLWithIndex	
        function CloseURL() {
            parent.postMessage("GETURLINDEX", "*");
            setTimeout(CloseURLWithIndex, 200);
        }

        function CloseURLWithIndex() {
            if (Index != "") {
                parent.postMessage("CLOSEURLINDEX" + Index, "*");
            } else {
                setTimeout(CloseURLWithIndex, 200);
            }

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

        外撥電話號碼：<asp:TextBox ID="txbPhone" runat="server" Height="20px"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txbPhone" ErrorMessage="不能空白" ValidationGroup="outmem" ForeColor="Red"></asp:RequiredFieldValidator>
        <p>

            服務單號1：<asp:TextBox ID="txbCasID1" runat="server"></asp:TextBox>
            　　服務單號2：<asp:TextBox ID="txbCasID2" runat="server"></asp:TextBox>
            　<p>

        是否付費：<asp:DropDownList ID="ddlPayYN" runat="server">
            <asp:ListItem>請選擇</asp:ListItem>
            <asp:ListItem>是</asp:ListItem>
            <asp:ListItem>否</asp:ListItem>
        </asp:DropDownList>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txbPayMoney" runat="server"></asp:TextBox>
        元<p>

            接觸紀錄：<asp:DropDownList ID="ddlBackState" runat="server">
                <asp:ListItem>請選擇</asp:ListItem>
                <asp:ListItem>成功</asp:ListItem>
                <asp:ListItem>未成功</asp:ListItem>
            </asp:DropDownList>
            <br />
        <br />

        備註<br />
        <asp:TextBox ID="txbMemo" runat="server" Height="105px" TextMode="MultiLine" Width="530px"></asp:TextBox>
        <br />
        <asp:Button ID="btnSendOK" runat="server" Height="34px" OnClick="btnSendOK_Click" Text="確定存檔" Width="122px" ValidationGroup="outmem" BackColor="Blue" ForeColor="White" />
    </p>

        <asp:Label ID="lblErrorShow" runat="server"></asp:Label>
        <asp:Label ID="lblOBID" runat="server"></asp:Label>
        <br />
        <asp:Label ID="lblEmpID" runat="server"></asp:Label>
        <br />
    <asp:Label ID="lblOutPhone" runat="server"></asp:Label>
        <br />
        <asp:Label ID="lblAni" runat="server"></asp:Label>
        →ani<br />
        <asp:Label ID="lblCall_Key" runat="server"></asp:Label> 
        <br />
        <asp:Label ID="lblACDDN" runat="server"></asp:Label>
        <br />
        <asp:Label ID="lblCall_ID" runat="server"></asp:Label>
  
    
    <br />
    <asp:Label ID="caller_type" runat="server"></asp:Label>
  
    
    <br />
    <asp:Label ID="lblNowTime" runat="server"></asp:Label>
  
    
    <br />
</asp:Content>

