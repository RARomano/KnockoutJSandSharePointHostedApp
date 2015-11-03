var MySample = MySample || {};

MySample.Lists = (function ($) {
	var getSpecificItem = function (baseUrl, listName, itemId, callback) {
		var url = baseUrl + "/_api/web/lists/getByTitle('" + listName + "')/items(" + itemId + ")";
		$.ajax({
			url: url,
			type: "GET",
			datatype: "JSON",
			headers: {
				"Accept": "application/json;odata=verbose"
			}
		})
            .done(function (data) {
            	callback(null, data);
            })
            .fail(function (jqxhr, textStatus, error) {
            	var err = textStatus + ", " + error;
            	callback(err);
            });
	};

	var getItems = function (baseUrl, listName, optionalParams, query, callback) {
		query = query || "";

		if (!query) {
			$.ajax({
				url: optionalParams ? baseUrl + "/_api/web/lists/getByTitle('" + listName + "')/items?" + optionalParams : baseUrl + "/_api/web/lists/getByTitle('" + listName + "')/items",
				type: "GET",
				datatype: "JSON",
				headers: {
					"Accept": "application/json;odata=verbose"
				}
			})
            .done(function (data) {
            	callback(null, data);
            })
            .fail(function (jqxhr, textStatus, error) {
            	var err = textStatus + ", " + error;
            	callback(err);
            });
		}
		else {
			$.ajax({
				url: optionalParams ? baseUrl + "/_api/web/lists/getByTitle('" + listName + "')/getitems(query=@v1)?" + optionalParams + "&@v1={'ViewXml':'" + query + "'}" : baseUrl + "/_api/web/lists/getByTitle('" + listName + "')/getitems",
				type: "POST",

				datatype: "JSON",
				headers: {
					"Accept": "application/json;odata=verbose",
					"X-RequestDigest": $('#__REQUESTDIGEST').val(),
					"content-type": "application/json; odata=verbose"
				}
			})
            .done(function (data) {
            	callback(null, data);
            })
            .fail(function (jqxhr, textStatus, error) {
            	var err = textStatus + ", " + error;
            	callback(err);
            });
		}
	};

	var getItemsLegacy = function (baseUrl, listName, optionalParams, callback) {
		$.ajax({
			url: optionalParams ? baseUrl + "/_vti_bin/listdata.svc/" + listName + "?" + optionalParams : baseUrl + "/_vti_bin/listdata.svc/" + listName,
			type: "GET",
			datatype: "JSON",
			headers: {
				"Accept": "application/json;odata=verbose"
			}
		})
        .done(function (data) {
        	callback(null, data);
        })
        .fail(function (jqxhr, textStatus, error) {
        	var err = textStatus + ", " + error;
        	callback(err);
        });
	};

	return {
		getSpecificItem: getSpecificItem,
		getItems: getItems,
		getItemsLegacy: getItemsLegacy
	};
})(jQuery);