# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	$('#calendar_guess_start_date_time').timepicker('getTime');
	$('#calendar_guess_end_date_time').timepicker('getTime');