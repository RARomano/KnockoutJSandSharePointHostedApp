<%@ Page language="C#" MasterPageFile="~masterurl/default.master" Inherits="Microsoft.SharePoint.WebPartPages.WebPartPage, Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<asp:Content ContentPlaceHolderId="PlaceHolderAdditionalPageHead" runat="server">
    <script type="text/javascript" src="../Scripts/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="/_layouts/15/sp.runtime.js"></script>
	<script type="text/javascript" src="/_layouts/15/sp.js"></script>
	<script type="text/javascript" src="../Scripts/lists.js"></script>
	<script type="text/javascript" src="../Scripts/listItemsModel.js"></script>
	<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/knockout/knockout-3.3.0.js"></script>
	
	<link rel="Stylesheet" type="text/css" href="../Content/bootstrap.min.css" />
	<link rel="Stylesheet" type="text/css" href="../Content/app.css" />
	 
	<script type="text/javascript">
	 	this.model = new MySample.listItemsModel();

	 	$(document).ready(function () {
	 		ko.applyBindings(model);
	 		var url = _spPageContextInfo.webServerRelativeUrl;

	 		MySample.Lists.getItems(url, "Example", null, null, function (err, data) {
	 			if (!err) {
	 				for (i = 0; i < data.d.results.length; i++) {
	 					var listItem = data.d.results[i];
	 					var item = { id: listItem.Id, title: listItem.Title, note: listItem.Note, editUrl: url+"/Pages/CreateListItem.aspx?ID="+listItem.Id };
	 					model.items.push(item);
	 				}
	 			}
	 		});
	 	});
    </script>

</asp:Content>

<asp:Content ContentPlaceHolderId="PlaceHolderMain" runat="server">
       <div class="container">
		   <div class="row">
			   <div class="col-md-12 pull-right"><div class="pull-right"><a href="CreateListItem.aspx" class="btn btn-default">Create List Item</a></div></div>
		   </div>
        <div class="panel panel-default">
            <div class="panel-heading">Items</div>

            <div class="panel-body">
                <div class="form-inline">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Title</th>
                                <th>Note</th>
								<th>Actions</th>
                            </tr>
                        </thead>

                        <!-- ko if: items().length == 0 -->
                        <tbody>
                            <tr>
                                <td colspan="2">This list is empty</td>
                            </tr>
                        </tbody>
                        <!-- /ko -->

                        <tbody data-bind="foreach: items">
                            <tr>
                                <td><span data-bind="text: title, uniqueName: true" /></td>
                                <td><span data-bind="text: note, uniqueName: true" /></td>
								<td><a href='#' data-bind='attr: { href: editUrl }'>Edit</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
