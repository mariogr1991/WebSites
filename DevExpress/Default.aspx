<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v18.1, Version=18.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.XtraCharts.v18.1.Web, Version=18.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>    
</head>

<body>
    <form id="form1" runat="server">
    <div>
    <dx:ASPxNavBar ID="nbMain" runat="server" AllowSelectItem="true" EnableAnimation="true" CssClass="custom-nav-bar">
        <Groups>
            <dx:NavBarGroup Text="Small Items">
                <Items>
                    <dx:NavBarItem Text="Scheduler" Image-Url="~/NavBar/Images/BO_Scheduler.png">
                    </dx:NavBarItem>
                    <dx:NavBarItem Text="Clients" Image-Url="~/NavBar/Images/BO_Organizations.png">
                    </dx:NavBarItem>
                    <dx:NavBarItem Text="Users" Image-Url="~/NavBar/Images/BO_Users.png">
                    </dx:NavBarItem>
                </Items>
            </dx:NavBarGroup>
            <dx:NavBarGroup ItemImagePosition="Top" Text="Large Items">
                <ItemStyle HorizontalAlign="Center" />
                <Items>
                    <dx:NavBarItem Text="Notes" Image-Url="~/NavBar/Images/BO_Notes_Large.png">
                    </dx:NavBarItem>
                    <dx:NavBarItem Text="Reports" Image-Url="~/NavBar/Images/BO_Reports_Large.png">
                    </dx:NavBarItem>
                </Items>
            </dx:NavBarGroup>
        </Groups>
    </dx:ASPxNavBar>
    </div>
    </form>
</body>
</html>
