var MySample = MySample || {};

MySample.createItemModel = function () {

	title = ko.observable(null);
	notes = ko.observable(null);

	isReadyToSave = function () {
		return title() ? true : false;
	};

	saveItem = function (siteUrl, callback) {
		var ctx = new SP.ClientContext(siteUrl);
		var web = ctx.get_web();
		var list = web.get_lists().getByTitle('Example');
		var itemCreateInfo = new SP.ListItemCreationInformation();
		var item = list.addItem(itemCreateInfo);

		item.set_item('Title', self.title());
		item.set_item('Note', self.notes());

		item.update();

		ctx.load(item);

		var onQuerySucceedded = function () {
			callback(null, "ok");
		};

		var onQueryFailed = function () {
			callback("error");
		};

		ctx.executeQueryAsync(onQuerySucceedded, onQueryFailed);
	};

	return {
		saveItem: saveItem,
		isReadyToSave: isReadyToSave
	}

};

