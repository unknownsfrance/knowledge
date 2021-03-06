var loadfunc = function () {
	gmap_initalize();
    
    $(".taggable").tagit({
	   	caseSensitive: false,
		readOnly: $('.taggable').prop('readonly'),
	  	autocomplete: {
	  		delay: 1,
			minLength: 3,
			source: "/tags.json"
		}
	});
    $('.languagable').tagit({
	   	caseSensitive: false,
		readOnly: $('.languagable').prop('readonly'),
	  	autocomplete: {
	  		delay: 1,
			minLength: 2,
			source: "/langs.json",
		},
    	beforeTagAdded: function (event, ui) {
    		// prevent event except if we found it in the last autocomplete list
    		var preventEvent = true;
    		if (!ui.duringInitialization) {
	    		$('ul#ui-id-2 > li').each(function () {
	    			if (ui.tagLabel == $(this).text()) {
	    				preventEvent = false;
	    			}
	    		});
		    	if (preventEvent) return false;
    		}
    	}
	});
    
	$('#showResultModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget)
	  var jsonid = button.data('jsonid')
	  var current_data = datajson[jsonid]
	  
	  var modal = $(this)
		  modal.find('.modal-title').text('Technology Detail: ' + current_data.name)
		  modal.find('.modal-body').html(test('Name', current_data.name))
		  modal.find('.modal-body').append(test('Url', current_data.url))
		  modal.find('.modal-body').append(test('Description', current_data.description))
		});
	
	$('#myModal').on('shown.bs.modal', function (event) {
		var button = $(event.relatedTarget)
		$('#myModal #myModalLabel').html('Assocation with ' + button.data('item-title'))
		$('#myModal #searchInput').focus();
		
		$('#myModal #searchFormAjax').submit(function( event ) {
			event.preventDefault();
			var url = event.target.action + ((event.target.action.indexOf('?') == -1)?'?':'&') 
					+ 'ajax=true&itemtype=' + button.data('item-type') + '&itemid=' + button.data('item-id')
					+ '&q=' + encodeURI($('#myModal #searchInput').val());
			
			var jqxhr = $.ajax( url )
			.done(function(data) {
				$('#myModal #modalSearchResults').html(data);
				bind_link_values(button.data('item-type'), button.data('item-id'));
			})
			.fail(function() {
				alert( "error" );
			});
		});
	});
	
	$('#showPopin').on('shown.bs.modal', function (event) {
		var button = $(event.relatedTarget);
		$('#showPopin #myModalLabel').html('Detail for ' + button.data('item-type') + ': ' + button.data('item-title'))
		if ($('#languages').length == 1) {
			$('#languages').val(cleanStr($('#languages').val()));
		}
		if ($('#tags').length == 1) {
			$('#tags').val(cleanStr($('#tags').val()));
		}
	});
	$('#showPopin').on('hidden.bs.modal', function () {
		$(this).removeData('bs.modal');
	});
};
var bind_link_values = function (elmType, elmId) {
	$('.assoc-button').click(function ( event ) {
		if ($('#' + event.target.id).hasClass('do-link')) {
			change_button_style(event.target.id, 'Link', 'glyphicon-refresh', 'glyphicon-plus');
			var err = true;
			var jqxhr = $.ajax( '/search/linkElements?type=link&elm1Type=' + elmType + '&elm1Id=' + elmId + '&elm2Type=' + $('#' + event.target.id).data('target-element-type') + '&elm2Id=' + $('#' + event.target.id).data('target-element-id'))
			.done(function(data) { if (data === "ok") err = false; })
			.always(function () {
				if (err === false) {
					$('#' + event.target.id).removeClass('do-link').addClass('do-unlink');
					change_button_style(event.target.id, 'Unlink', 'glyphicon-ok', 'glyphicon-refresh');
				}
				else {
					alert( "Error when trying to link elements" );
					change_button_style(event.target.id, 'Link', 'glyphicon-plus', 'glyphicon-refresh');
				}
			});
		}
		else if ($('#' + event.target.id).hasClass('do-unlink')) {
			change_button_style(event.target.id, 'Unlink', 'glyphicon-refresh', 'glyphicon-ok');
			var err = 'true';
			var jqxhr = $.ajax( '/search/linkElements?type=unlink&elm1Type=' + elmType + '&elm1Id=' + elmId + '&elm2Type=' + $('#' + event.target.id).data('target-element-type') + '&elm2Id=' + $('#' + event.target.id).data('target-element-id'))
			.done(function(data) { if (data === "ok") err = false; })
			.always(function () {
				if (err === false) {
					$('#' + event.target.id).removeClass('do-unlink').addClass('do-link');
					change_button_style(event.target.id, 'Link', 'glyphicon-plus', 'glyphicon-refresh');
				}
				else {
					alert( "Error when trying to link elements" );
					change_button_style(event.target.id, 'Unlink', 'glyphicon-ok', 'glyphicon-refresh');
				}
			});
		}
	});
};
var gmap_initalize = function () {
	$('.has-places').keypress(function(e){
	    if ( e.which == 13 ) {
	    	$(this).val('');
	    	$(this).focus();
	    	e.preventDefault();
	    }
	});
	$('.has-places').each(function () {
		var obj_id = $(this).attr('id');
		var autocomplete = new google.maps.places.Autocomplete(document.getElementById(obj_id));
		google.maps.event.addListener(autocomplete, 'place_changed', function () {
			var place = autocomplete.getPlace();
			// Multiple Format 
			var multiple_target = $('#' + obj_id).data('multiple-list-id');
			var multiple_format = $('#' + obj_id).data('multiple-format-name');
			if (multiple_target && multiple_format) {
				var elm_id = 'place_item_' + place.place_id;
				var inputs = ' <a href="#" id="' + elm_id + '_removelink" data-remove-id="' + elm_id + '">remove</a>'
					inputs += '<input type="hidden" name="' + multiple_format.replace('%i', place.place_id).replace('%s', 'id') + '" value="' + place.place_id + '">';
					inputs += '<input type="hidden" name="' + multiple_format.replace('%i', place.place_id).replace('%s', 'name') + '" value="' + place.formatted_address + '">'
				$('#' + multiple_target).append('<li id="' + elm_id + '">' + place.formatted_address + inputs + '</li>');
				$('#' + obj_id).val('');
				$('#' + obj_id).focus();
				// Bind click 
				$('#' + elm_id + '_removelink').click(removelink);
			}
			else {
				var target_id = $('#' + obj_id).data('target-id');
				$('#' + target_id).val(place.place_id);
			}
		});
	});
	$('#localizations > li > a').click(removelink)
}

$(document).on("page:load", loadfunc);
$(document).ready(loadfunc);

var removelink = function ( evt ) {
	evt.preventDefault();
	$('#' + $(this).data('remove-id')).remove();
}
var cleanStr = function ( str ) {
	return str.replace(/\s\s+/g, ' ').trim().replace(/,(\s+)?$/, '');
}

// Utility methods 
var test = function (attribute, value) {
	return '<div><strong>' + attribute + ':</strong> ' + value + '</div>'
}
var change_button_style = function (element_id, new_label, new_class, old_class) {
	$('#' + element_id + ' span:first').removeClass(old_class).addClass(new_class);
	$('#' + element_id + ' span:last').html(new_label);
}

