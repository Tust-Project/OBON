<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageNotree.master" AutoEventWireup="true" CodeFile="OutboundRec.aspx.cs" Inherits="OutboundRec" %>

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

        外撥接通電話號碼：<asp:TextBox ID="txbPhone" runat="server" Height="20px"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txbPhone" ErrorMessage="不能空白" ValidationGroup="outmem" ForeColor="Red"></asp:RequiredFieldValidator>
        <br />
        <br />
        

            玉碼編號：<asp:TextBox ID="TxbUmID" runat="server" Height="18px"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxbUmID" ErrorMessage="不能空白" ValidationGroup="outmem" ForeColor="Red"></asp:RequiredFieldValidator>
        <p>

            <span lang="ZH-CN" style="font-size:12.0pt;font-family:
&quot;新細明體&quot;,serif;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;
mso-bidi-font-family:Arial;color:black;mso-ansi-language:EN-US;mso-fareast-language:
ZH-CN;mso-bidi-language:AR-SA;mso-no-proof:yes">外撥號碼</span><span lang="EN-US" style="font-size:12.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-fareast-font-family:
SimSun;mso-bidi-font-family:Arial;color:black;mso-ansi-language:EN-US;
mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;mso-no-proof:yes">-</span><span lang="ZH-CN" style="font-size:12.0pt;font-family:&quot;新細明體&quot;,serif;mso-ascii-font-family:
Calibri;mso-hansi-font-family:Calibri;mso-bidi-font-family:Arial;color:black;
mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;
mso-no-proof:yes">手機1：</span><asp:TextBox ID="txbMobile1" runat="server"></asp:TextBox>
    <p>

        <span lang="ZH-CN" style="font-size:12.0pt;font-family:
&quot;新細明體&quot;,serif;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;
mso-bidi-font-family:Arial;color:black;mso-ansi-language:EN-US;mso-fareast-language:
ZH-CN;mso-bidi-language:AR-SA;mso-no-proof:yes">外撥號碼</span><span lang="EN-US" style="font-size:12.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-fareast-font-family:
SimSun;mso-bidi-font-family:Arial;color:black;mso-ansi-language:EN-US;
mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;mso-no-proof:yes">-</span><span lang="ZH-CN" style="font-size:12.0pt;font-family:&quot;新細明體&quot;,serif;mso-ascii-font-family:
Calibri;mso-hansi-font-family:Calibri;mso-bidi-font-family:Arial;color:black;
mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;
mso-no-proof:yes">手機2：</span><asp:TextBox ID="txbMobile2" runat="server"></asp:TextBox>
    <p>

        <span lang="ZH-CN" style="font-size:12.0pt;font-family:
&quot;新細明體&quot;,serif;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;
mso-bidi-font-family:Arial;color:black;mso-ansi-language:EN-US;mso-fareast-language:
ZH-CN;mso-bidi-language:AR-SA;mso-no-proof:yes">外撥號碼</span><span lang="EN-US" style="font-size:12.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-fareast-font-family:
SimSun;mso-bidi-font-family:Arial;color:black;mso-ansi-language:EN-US;
mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;mso-no-proof:yes">-</span><span lang="ZH-CN" style="font-size:12.0pt;font-family:&quot;新細明體&quot;,serif;mso-ascii-font-family:
Calibri;mso-hansi-font-family:Calibri;mso-bidi-font-family:Arial;color:black;
mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;
mso-no-proof:yes">市話</span><span lang="EN-US" style="font-size:12.0pt;font-family:
&quot;Calibri&quot;,sans-serif;mso-fareast-font-family:SimSun;mso-bidi-font-family:Arial;
color:black;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:
AR-SA;mso-no-proof:yes">1：<asp:TextBox ID="txbPhone1" runat="server"></asp:TextBox>
        </span>
    <p>

        <span lang="ZH-CN" style="font-size:12.0pt;font-family:
&quot;新細明體&quot;,serif;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;
mso-bidi-font-family:Arial;color:black;mso-ansi-language:EN-US;mso-fareast-language:
ZH-CN;mso-bidi-language:AR-SA;mso-no-proof:yes">外撥號碼</span><span lang="EN-US" style="font-size:12.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-fareast-font-family:
SimSun;mso-bidi-font-family:Arial;color:black;mso-ansi-language:EN-US;
mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;mso-no-proof:yes">-</span><span lang="ZH-CN" style="font-size:12.0pt;font-family:&quot;新細明體&quot;,serif;mso-ascii-font-family:
Calibri;mso-hansi-font-family:Calibri;mso-bidi-font-family:Arial;color:black;
mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA;
mso-no-proof:yes">市話</span><span lang="EN-US" style="font-size:12.0pt;font-family:
&quot;Calibri&quot;,sans-serif;mso-fareast-font-family:SimSun;mso-bidi-font-family:Arial;
color:black;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;mso-bidi-language:
AR-SA;mso-no-proof:yes">2：<asp:TextBox ID="txbPhone2" runat="server"></asp:TextBox>
        </span>
    <p>

        車牌號碼：<asp:TextBox ID="TxbCarNO" runat="server"></asp:TextBox>
        <p>

            接觸紀錄：<asp:DropDownList ID="ddlBackState" runat="server">
                <asp:ListItem Selected="True">請選擇</asp:ListItem>
                <asp:ListItem>成功</asp:ListItem>
                <asp:ListItem>無人接聽</asp:ListItem>
                <asp:ListItem>約訪</asp:ListItem>
                <asp:ListItem>忙線</asp:ListItem>
                <asp:ListItem>轉語音信箱</asp:ListItem>
                <asp:ListItem>失敗</asp:ListItem>
            </asp:DropDownList>
            <br />
        <br />

        備註<br />
        <asp:TextBox ID="txbMemo" runat="server" Height="105px" TextMode="MultiLine" Width="530px"></asp:TextBox>
    </p>
    <p>

            <span lang="ZH-CN" style="font-size:12.0pt;font-family:
&quot;新細明體&quot;,serif;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;
mso-bidi-font-family:Arial;color:black;mso-ansi-language:EN-US;mso-fareast-language:
ZH-CN;mso-bidi-language:AR-SA">備註</span><span lang="EN-US" style="font-size:12.0pt;
font-family:&quot;Calibri&quot;,sans-serif;mso-fareast-font-family:SimSun;mso-bidi-font-family:
Arial;color:black;mso-ansi-language:EN-US;mso-fareast-language:ZH-CN;
mso-bidi-language:AR-SA">-</span><span lang="ZH-CN" style="font-size:12.0pt;
font-family:&quot;新細明體&quot;,serif;mso-ascii-font-family:Calibri;mso-hansi-font-family:
Calibri;mso-bidi-font-family:Arial;color:black;mso-ansi-language:EN-US;
mso-fareast-language:ZH-CN;mso-bidi-language:AR-SA">更名檔名：<span lang="EN-US" style="font-size: 12.0pt; font-family: &quot;Calibri&quot;,sans-serif; mso-fareast-font-family: SimSun; mso-bidi-font-family: Arial; color: black; mso-ansi-language: EN-US; mso-fareast-language: ZH-CN; mso-bidi-language: AR-SA; mso-no-proof: yes"><asp:TextBox ID="txbSoundName" runat="server" Height="16px" Width="390px"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txbSoundName" ErrorMessage="不能空白" ValidationGroup="outmem" ForeColor="Red"></asp:RequiredFieldValidator>
            </span></span>
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
        <br />
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
    <asp:Label ID="lblCallback" runat="server"></asp:Label>
  
    
    <br />
</asp:Content>

