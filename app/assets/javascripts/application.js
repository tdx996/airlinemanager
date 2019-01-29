// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery.min.js
//= require jquery.dataTables.min.js
//= require_tree .

$(document).ready(function() {

	$(document).on('hidden.bs.modal', '.modal', function (e) {
		$(this).find('input[type=text]').val('');
		$(this).find('input[type=number]').val('');
		$(this).find('input[type=hidden]:not([name=authenticity_token]):not(.permanent)').val('');
		$(this).find('select').val('').trigger('change');
		$(this).find('.alert').remove();
	});

	$(document).on('shown.bs.modal', '.modal', function (e) {
		// $('.select2').select2({ width: '100%' });
	});

	$(document).on('click', '[data-load="ajax"]', function(e) {
		e.preventDefault();

		let origin 		= $(this);
		let href 		= $(this).data('href');
		let view 		= $(this).data('view') || '#main-content';
        let method 		= $(this).data('method') || 'GET';
        let dataType 	= $(this).data('data-type') || 'JSON';

        AppRails.loadView(href, view, [], method, dataType, {
        	success: function(data) {
        		$('ul#main-menu li').removeClass('active');
        		console.log(origin);
        		origin.parent().addClass('active');
        	}
        });
	});

	$(document).on('click', '#EditFlightBtn', function(e) {
		e.preventDefault();

		let href = $(this).data('href');

		AppRails.loadView(href, '#BasicFlightInfo', [], 'GET', 'JSON', {
			success: function() {
				$('.select2').select2({
					width: '100%',
					ajax: {
					    url: '/airports/autocomplete',
					    data: function (params) {
					    	return {
					        	search: params.term,
					        	type: 'public'
					      	};
				    	}
			  		}
				});
			    $('#arrival_at, #departure_at').datetimepicker();
			}
		});
	});

	$(document).on('click', '#BasicFlightInfo #CancelEditBtn', function(e) {
		e.preventDefault();

		let redirect = $('#BasicFlightInfo form').data('redirect');

		AppRails.loadView(redirect, '#BasicFlightInfo');
	});

	$(document).on('submit', '#BasicFlightInfo form', function(e) {
		e.preventDefault();

		let redirect = $(this).data('redirect');

		AppRails.submitCardForm('#BasicFlightInfo', {
			success: function(data) {
				AppRails.loadView(redirect, '#BasicFlightInfo');
			},
			error: function(data) {

			}
		});
	});

	$(document).on('shown.bs.modal', '#NewFlightModal', function(e) {
		$('.select2').select2({
			width: '100%',
			ajax: {
			    url: '/airports/autocomplete',
			    data: function (params) {
			    	return {
			        	search: params.term,
			        	type: 'public'
			      	};
		    	}
	  		}
		});
	});

	$(document).on('submit', '#NewFlightModal form', function(e) {
		e.preventDefault();

		AppRails.submitModalForm('#NewFlightModal', {
			success: function(data) {
				AppRails.loadView('/flights/list', '#FlightList');
			},
			error: function(data) {

			}
		});
	});

	$(document).on('click', '#FlightList .pagination a', function(e) {
		e.preventDefault();

		var href = $(this).attr('href');

		AppRails.loadView(href, '#FlightList');
	});

	// $(document).on('shown.bs.modal', '#NewPassengerModal', function(e) {
	// 	var href = $(this).find('form').data('select2');

	// 	AppRails.loadSelect2Data('#NewPassengerModal .select2', href, {});
	// });

	$(document).on('click', '#PassengersCard .plane-seat:not(.sold)', function(e) {
		e.preventDefault();

		let seat = $(this).data('seat');

		$('#NewPassengerModal').modal('show');
		$('#NewPassengerModal').on('shown.bs.modal', function(e) {
			$('#NewPassengerModal .select2').select2({
				ajax: {
				    url: '/flight/autocomplete',
				    data: function (params) {
				    	return {
				        	search: params.term,
				        	type: 'public'
				      	};
			    	}
		  		}
			});

			var href = $(this).find('form').data('select2');


			AppRails.loadSelect2Data('#NewPassengerModal .select2', href, {
				success: function() {
					$('#NewPassengerModal select#seat').val(seat).trigger('change.select2');
				}
			});

		});
	});

	$(document).on('click', '#PassengersCard .plane-seat.sold', function(e) {
		e.preventDefault();

		let href = $(this).data('href');

		$('#PassengersCard').addClass('be-loading-active');
		AppRails.loadView(href, '#EditPassengerModal', [], 'GET', 'JSON', {
			success: function() {
				$('#EditPassengerModal').modal('show');		
				$('#PassengersCard').removeClass('be-loading-active');
			}
		});
	});

	$(document).on('shown.bs.modal', '#NewPassengerModal', function(e) {

		$(this).find('.select2').select2({
			width: '100%',
		});
		
		let href = $('#NewPassengerModal #passenger_name').data('href');
		let fid = $('#NewPassengerModal #ticket_flight_id').val();

		$('#NewPassengerModal #passenger_name').autocomplete(AppRails.passengerAutocompleteConfig('#NewPassengerModal', href, fid));
	});

	$(document).on('shown.bs.modal', '#EditPassengerModal', function(e) {

		$(this).find('.select2').select2({
			width: '100%',
		});
		
		let href = $('#EditPassengerModal #passenger_name').data('href');
		let fid = $('#EditPassengerModal #ticket_flight_id').val();

		$('#EditPassengerModal #passenger_name').autocomplete(AppRails.passengerAutocompleteConfig('#EditPassengerModal', href, fid));
	});

	$(document).on('submit', '#NewPassengerModal form', function(e) {
		e.preventDefault();

		let redirect = $(this).data('redirect');

		AppRails.submitModalForm('#NewPassengerModal', {
			success: function() {
				AppRails.loadView(redirect, '#PassengersCard')
			}
		});
	});

	$(document).on('submit', '#EditPassengerModal form', function(e) {
		e.preventDefault();

		let redirect = $(this).data('redirect');

		AppRails.submitModalForm('#EditPassengerModal', {
			success: function() {
				AppRails.loadView(redirect, '#PassengersCard');
			}
		});
	});

	$(document).on('click', '#EditPassengerModal #DeleteBtn', function(e) {
		e.preventDefault();

		let href = $(this).data('href');
		let redirect = $('#EditPassengerModal form').data('redirect');

		$('#EditPassengerModal').modal('hide');
		$('#EditPassengerModal').on('hidden.bs.modal', function() {
			$('#DeleteTicketModal').modal('show');
			$('#DeleteTicketModal').on('click', '#ConfirmBtn', function(e) {
				$('#EditPassengerModal .modal-content').addClass('be-loading-active');
				AppRails.deleteAction(href, {
					success: function(data) {
						$('#EditPassengerModal .modal-cotent').removeClass('be-loading-active');
						AppRails.loadView(redirect, '#PassengersCard');
					}
				});
			});
		});
	});

	$(document).on('click', '.show-flight', function(e) {
		e.preventDefault();

		AppRails.loadView($(this).data('href'));
	});

	$(document).on('click', '.delete-flight', function(e) {
		e.preventDefault();

		let href = $(this).data('href');

		$('#DeleteFlightModal').modal('show');
		$('#DeleteFlightModal #ConfirmBtn').on('click', function(e) {
			AppRails.deleteAction(href, {
				success: function() {
					AppRails.loadView('/flights/list', '#FlightList');
				},

				errors: function() {
					$('#DeleteFlightModal').modal('hide');
					$('#DeleteFlightModal').on('hidden.bs.modal', function(e) {
						$('#DeleteFlightErrorModal').modal('show');
					});
				}
			});
		});
	});
});

function ajax(options) {
  return new Promise(function(resolve, reject) {
    $.ajax(options).done(resolve).fail(reject);
  });
}

AppRails = {
	passengerAutocompleteConfig: function (selector, href, fid) {
		return {
            source: function(request, response) {
                $.ajax({
                    url: href,
                    dataType: "JSON",
                    data: {
                        q: request.term,
                        flight_id: fid,
                    },
                    success: function(data) {
                        if (data.status)
                            response(data.list);
                    }
                });
            },
            select: function(e, ui) {
            	e.preventDefault();
                $(this).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
                $(selector +' #passenger_name').val(ui.item.label);
                $(selector +' #ticket_passenger_id').val(ui.item.value);
            },
            focus: function(e, ui) {
            	e.preventDefault();
                $(selector +' #passenger_name').val(ui.item.label);
            },
            open: function() {
                $(this).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
            },
            close: function() {
                $(this).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
            },
            appendTo: selector,
        };
	},

	loadSelect2Data: function(selector, href, callbacks = {}) {
		ajax({
			url: href,
			dataType: 'JSON',
			method: 'GET',
			success: function(data) {
				if (data.status) {
					$(selector).empty();
					$(selector).select2({
						width: '100%',
						data: data.options,
					});
					console.log(data.options);

					if (callbacks.success) callbacks.success(data);
				}
			},
			errors: function(data) {
				if (callbacks.errors) callbacks.errors();
			},
			complete: function(data) {
				if (callbacks.complete) callbacks.complete();
			}
		});
	},

	deleteAction: function(href, callbacks = {}) {
		ajax({
			url: href,
			dataType: 'JSON',
			method: 'DELETE',
			data: {
				authenticity_token: $('meta[name=csrf-token]').attr('content'),
			},
			success: function(data) {
				if (data.status) {
					if (callbacks.success) callbacks.success(data);
				} else {
					if (callbacks.errors) callbacks.errors();
				}
			},
			errors: function(data) {
				if (callbacks.errors) callbacks.errors();
			},
			complete: function(data) {
				if (callbacks.complete) callbacks.complete();
			}
		});
	},

	loadView: function(href, view = '#main-content', data = [], method = 'GET', dataType = 'JSON', callbacks = {}) {

		// Start loading animation
        $(view).addClass('be-loading-active');

		ajax({
			url: href,
			dataType: "JSON",
			method: "GET",
			success: function(data) {
				if (data.status) {

					// Display view
					$(view).replaceWith	(data.view);

					// Update title
					if (data.title) $('#page-title').text(data.title);
					
					if (callbacks.success) callbacks.success(data);
				}
			},
			complete: function() {

				// End loading animation
				$(view).removeClass('be-loading-active');

			}
		});
	},

	submitCardForm: function(selector, callbacks = {}) {
		let card = $(selector);
		let form = card.find('form');

		let action = form.attr('action');
		let method = form.attr('method');

		let formData = new FormData(form[0]);

		card.addClass('be-loading-active');

		ajax({
			url: action,
			method: method,
			processData: false,
            contentType: false,	
            data: formData,
			dataType: 'JSON',
			success: function(data) {
				if (data.status) {
					if (callbacks.success) callbacks.success(data);
				} else if (data.errors) {
					card.find('.alert').remove();
					card.find('.card-body').prepend(data.errors);
				}
			},
			error: function(data) {
				if (callbacks.error) callbacks.error(data);	
			},
			complete: function(data) {
				if (callbacks.complete) callbacks.complete(data);	

				form.find('[type=submit]').prop('disabled', false);
				card.removeClass('be-loading-active');
			}
		});
	},

	submitModalForm: function(selector, callbacks = {}) {
		let modal = $(selector);
		let form = modal.find('form');

		let action = form.attr('action');
		let method = form.attr('method');

		let formData = new FormData(form[0]);

		modal.find('.modal-content').addClass('be-loading-active');

		ajax({
			url: action,
			method: method,
			processData: false,
            contentType: false,	
            data: formData,
			dataType: 'JSON',
			success: function(data) {
				if (data.status) {
					if (callbacks.success) callbacks.success(data);

					modal.modal('hide');
				} else if (data.errors) {
					modal.find('.alert').remove();
					modal.find('.modal-body').prepend(data.errors);
				}
			},
			error: function(data) {
				if (callbacks.error) callbacks.error(data);	
			},
			complete: function(data) {
				if (callbacks.complete) callbacks.complete(data);	

				form.find('[type=submit]').prop('disabled', false);
				modal.find('.modal-content').removeClass('be-loading-active');
			}
		});
	}
};















