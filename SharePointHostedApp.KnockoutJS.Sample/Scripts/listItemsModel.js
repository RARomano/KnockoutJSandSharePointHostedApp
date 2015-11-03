var MySample = MySample || {};

MySample.listItemsModel = function () {

	items = ko.observableArray(null);

	return {
		items: items
	}
};
