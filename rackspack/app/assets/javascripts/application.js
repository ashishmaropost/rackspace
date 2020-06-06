//= require jquery
//= require jquery_ujs
//= require popper.min
//= require typeahead
//= require activestorage
//= require notify
//= require turbolinks
//= require select2-full
//= require_tree .

$( window ).load(function() {
  $( "#friend_ids" ).select2();
});

setTimeout(function(){$('.FlashNotice').fadeOut('fast')},2000)