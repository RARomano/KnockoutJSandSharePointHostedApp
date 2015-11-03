<%@ Page Language="C#" MasterPageFile="~masterurl/default.master" Inherits="Microsoft.SharePoint.WebPartPages.WebPartPage, Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<asp:Content ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
	<script type="text/javascript" src="../Scripts/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="/_layouts/15/sp.runtime.js"></script>
	<script type="text/javascript" src="/_layouts/15/sp.js"></script>
	<script type="text/javascript" src="../Scripts/createItemModel.js"></script>
	<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/knockout/knockout-3.3.0.js"></script>
	
	<link rel="Stylesheet" type="text/css" href="../Content/bootstrap.min.css" />
	<link rel="Stylesheet" type="text/css" href="../Content/app.css" />

	<script type="text/javascript">
		var model = new MySample.createItemModel();
		$(document).ready(function () {
			ko.applyBindings(model);

			$("#btnSave").click(function (evt) {
				var url = _spPageContextInfo.webServerRelativeUrl;
				model.saveItem(url, function (err, data) {
					if (!err) {
						window.location.href = url + "/Lists/Example";
					}
				});
			});
		});
	</script>

	
</asp:Content>

<asp:Content ContentPlaceHolderID="PlaceHolderMain" runat="server">
	<div class="container">
		<div class="panel panel-default">
			<div class="form panel-body" id="frmRoot">
				<div class="row">
					<div class="form-group col-md-12">
						<label for="txtName" class="control-label requiredLabel">Title:</label>
						<input type="text" class="form-control required" id="txtName" data-bind="value: title">
					</div>
					<div class="form-group col-md-12">
						<label for="txtNotes" class="control-label">Notes:</label>
						<textarea rows="5" class="form-control" id="txtNotes" data-bind="value: notes"></textarea>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-md-12">
				<div class="btn-group btn-group-lg" role="group" aria-label="toolbar">
					<button type="button" id="btnSave" class="btn btn-primary" data-bind="enable: isReadyToSave()">Save</button>
				</div>
			</div>
		</div>
	</div>

</asp:Content>


