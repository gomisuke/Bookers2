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
//= require turbolinks
//= require jquery
//= require bootstrap-sprockets
//= require_tree .

$(function(){
	function toFullWidth(input) {
		return input.replace(/[!-~]/g,
			function(input){
				return String.formCharCode(input.charCodeAt(0)+0xFEE0);
			}
		);
	};

	$('#address_street').on('blur',function(e){
		$(this).val(toFullWidth($(this).val()));
	});
});