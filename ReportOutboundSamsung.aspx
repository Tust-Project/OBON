<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ReportOutboundSamsung.aspx.cs" Inherits="ReportOutboundSamsung"  EnableEventValidation = "false"%>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <p>
    請選擇項目ACD-DN：<asp:DropDownList ID="ddlAcddn" runat="server">
            <asp:ListItem>3901370</asp:ListItem>
        </asp:DropDownList>
        <br />
        開始日期：
        <asp:TextBox ID="txbStartDate" runat="server"></asp:TextBox>
        <cc1:CalendarExtender ID="txbStartDate_CalendarExtender" runat="server" 
            Enabled="True" TargetControlID="txbStartDate" Format ="yyyy/MM/dd">
        </cc1:CalendarExtender>
        　　結束日期：<asp:TextBox ID="txbEndDate" runat="server"></asp:TextBox>
        <cc1:CalendarExtender ID="txbEndDate_CalendarExtender" runat="server" 
            Enabled="True" TargetControlID="txbEndDate" Format ="yyyy/MM/dd">
        </cc1:CalendarExtender>
        <asp:Button ID="btnSendOK" runat="server" Text="查詢" onclick="btnSendOK_Click" Height="28px" Width="81px" />
    </p>
    <div style="font-size: 9pt">
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="2" CellSpacing="1" DataKeyNames="ID" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" AllowPaging="True" AllowSorting="True" PageSize="30">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                <asp:BoundField DataField="CasID1" HeaderText="CasID1" SortExpression="CasID1" />
                <asp:BoundField DataField="CasID2" HeaderText="CasID2" SortExpression="CasID2" />
                <asp:BoundField DataField="PayYN" HeaderText="PayYN" SortExpression="PayYN" />
                <asp:BoundField DataField="PayMoney" HeaderText="PayMoney" SortExpression="PayMoney" />
                <asp:BoundField DataField="SDateTime" HeaderText="SDateTime" SortExpression="SDateTime" />
                <asp:BoundField DataField="EDateTime" HeaderText="EDateTime" SortExpression="EDateTime" />
                <asp:BoundField DataField="WorkTime" HeaderText="WorkTime" SortExpression="WorkTime" />
                <asp:BoundField DataField="Memo" HeaderText="Memo" SortExpression="Memo" />
                <asp:BoundField DataField="BackState" HeaderText="BackState" SortExpression="BackState" />
                <asp:BoundField DataField="TranPhone" HeaderText="TranPhone" SortExpression="TranPhone" />
                <asp:BoundField DataField="AgentID" HeaderText="AgentID" SortExpression="AgentID" />
                <asp:BoundField DataField="Call_ID" HeaderText="Call_ID" SortExpression="Call_ID" />
                <asp:BoundField DataField="Current_ANI" HeaderText="Current_ANI" SortExpression="Current_ANI" />
                <asp:BoundField DataField="Call_KEY" HeaderText="Call_KEY" SortExpression="Call_KEY" />
                <asp:BoundField DataField="ACD_DN" HeaderText="ACD_DN" SortExpression="ACD_DN" />
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <EmptyDataRowStyle BackColor="Black" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="White" Font-Bold="True" ForeColor="Black" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFFFCC" BorderWidth="1px" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OBONConnectionString %>" SelectCommand="SELECT * FROM [CusSamsunHistory] WHERE (([ACD_DN] = @ACD_DN) AND ([SDateTime] &gt;= @SDateTime + ' 00:00:00') AND ([SDateTime] &lt;= @SDateTime2 + ' 23:59:59'))">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlAcddn" Name="ACD_DN" PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="txbStartDate" Name="SDateTime" PropertyName="Text" Type="DateTime" />
                <asp:ControlParameter ControlID="txbEndDate" Name="SDateTime2" PropertyName="Text" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <asp:Button ID="btnOutExcel" runat="server" BackColor="#3333CC" ForeColor="White" Height="27px" OnClick="btnOutExcel_Click" Text="匯出EXCEL" Visible="False" Width="113px" />
    </p>
        <p>
            因為資安要求，匯出Excel要經過申請，核可後寄送個人信箱。</p>
        <p>
            <asp:Label ID="lblCAG_FK" runat="server"></asp:Label>
            <asp:Label ID="lblError" runat="server"></asp:Label>            
        </p>
    </div>

</asp:Content>

