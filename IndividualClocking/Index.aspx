<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="IndividualClocking.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script type="text/javascript">
        $(function () {
            $("#Calendar1").datepicker();
        })
    </script>
    <style type="text/css">
        .auto-style1 {
            color: #00CCFF;
            font-family: "Franklin Gothic Medium", "Arial Narrow", Arial, sans-serif;
            font-weight: normal;
        }
        .auto-style2
        {
            width: 155px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            

            <table>
                <tr>
                    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                        <asp:Image ID="PPLogo" runat="server" ImageUrl="~/Images/Peters_Papers.png" />
                        </td>
                </tr>
                <tr>
                    <td>

                        <asp:Label ID="lblCalendar" runat="server" Text="Select a date" ForeColor="#00CCFF" Font-Names="Arial"></asp:Label>

                        <asp:Calendar ID="Calendar1" runat="server" FirstDayOfWeek="Monday"  SelectionMode="DayWeek" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px" >
                            <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                            <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                            <OtherMonthDayStyle ForeColor="#999999" />
                            <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                            <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                            <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                            <WeekendDayStyle BackColor="#CCCCFF" />
                        </asp:Calendar>

                    </td>
                    <td class="auto-style2">
                        <asp:Label ID="lblName" runat="server" Text="Name" ForeColor="#00CCFF" Font-Names="Arial"></asp:Label>
                        <br />

                        <asp:DropDownList ID="ddlNames" runat="server" AutoPostBack="True"  DataSourceID="Names" DataTextField="Name" DataValueField="Name" BackColor="#CCFFFF" ForeColor="#000099" Font-Names="Arial">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="Names" runat="server" ConnectionString="<%$ ConnectionStrings:Names %>" ProviderName="<%$ ConnectionStrings:Names.ProviderName %>" SelectCommand="SELECT DISTINCT CONCAT(firstname,' ', lastname) AS Name  FROM acc_monitor_log
ORDER BY Name"></asp:SqlDataSource>
                        

                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" OnClick="btnRefresh_Click" BackColor="#A2E3F9" ForeColor="#000099" />
                   
                        <br />
                        <br />
                        <asp:RadioButton ID="rbDetail" runat="server" GroupName="Radio"  Text="     Detailed" />
                        <br />
                        <asp:RadioButton ID="rbSummary" runat="server" GroupName="Radio"  Text=" Summarised" />
                        <br />
                        <br />
                        <br />
                        <br />
                        <br />
                        <br />
                   
                    </td>
                </tr>
            </table>
            <br />


        </div>
        <div>
            <table>
                <tr>
                                        <th class="auto-style1">&nbsp;&nbsp; Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; State</th>
                </tr>
                <tr>
                    <td>
                        <asp:DataList ID="IndividualINOUT" runat="server" CellPadding="3" BackColor="#00CCFF" BorderColor="#006699" BorderStyle="None" BorderWidth="1px" GridLines="Vertical" ForeColor="#000099" Font-Names="Arial" OnItemDataBound="IndividualINOUT_ItemDataBound">
                            <AlternatingItemStyle BackColor="#DCDCDC" />
                            <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                            <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                            <ItemStyle BackColor="#EEEEEE" ForeColor="Black" />
                            <ItemTemplate>
                                <table>
                                    <tr>
                                        
                                        <td >
                                            <asp:Label ID="DateLabel" runat="server" Text='<%# Eval("The_date") %>' />
                                        </td>
                                        <td>&nbsp;&nbsp;</td>
                                        <td >
                                            <asp:Label ID="TimeLabel" runat="server" Text='<%# Eval("The_Time") %>' />
                                        </td>
                                        <td>&nbsp;&nbsp;</td>
                                        <td>
                                            <asp:Label ID="SateLabel" runat="server" Text='<%# Eval("The_State") %>' />
                                        </td>

                                    </tr>
                                </table>
                            </ItemTemplate>
                            <SelectedItemStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                        </asp:DataList>
                    </td>
                </tr>

            </table>

        </div>

        <p>
            &nbsp;
        </p>

    </form>
</body>
</html>
