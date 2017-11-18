$(document).on('turbolinks:load', function() {
  $("input[data-mask]").each(function() {
    mask = $(this).data('mask')
    $(this).mask(mask, { placeholder: mask })
  });
})