
Event.observe(window, 'load', function() {
   $('add_poem').hide();
   Event.observe($('add_poem_link'), 'click', function() {
      new Effect.BlindUp($('add_poem_link'));
      new Effect.BlindDown($('add_poem'));
//      $('add_poem_link')
   });
});