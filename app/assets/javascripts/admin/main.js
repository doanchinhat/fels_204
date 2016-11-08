$(document).on('click', '.glyphicon-remove', function() {
  $(this).closest('tr').fadeOut(500);
  setTimeout(function() {
    $('.alert').fadeOut(500);
  }, 3000);
});
$(document).ready(function(){

$(document).on('click', '.add-word', function(e)
{
  e.preventDefault();

  var controlForm = $('.controls form:first'),
      currentEntry = $(this).parents('.entry:first'),
      newEntry = $(currentEntry.clone()).appendTo(controlForm);

  newEntry.find('input').val('');
  controlForm.find('.entry:not(:last) .add-word')
    .removeClass('add-word').addClass('btn-remove')
    .removeClass('btn-success').addClass('btn-danger')
    .html('<span class="glyphicon glyphicon-minus"></span>');
}).on('click', '.btn-remove', function(e) {
  $(this).parents('.entry:first').remove();
  e.preventDefault();
  return false;
});
});
