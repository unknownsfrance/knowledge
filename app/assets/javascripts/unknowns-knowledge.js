$(document).ready(function() {
	console.log('test1');
    $(".taggable").tagit({
	   	caseSensitive: false,
	  	autocomplete: {
	  		delay: 1,
			minLength: 3,
			source: "/tags.json"
		}
	});
    
	console.log('test2');
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
});

var test = function (attribute, value) {
	return '<div><strong>' + attribute + ':</strong> ' + value + '</div>'
}
