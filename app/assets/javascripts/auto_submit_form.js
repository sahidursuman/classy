$(document).on("turbolinks:load", function(){
  $(".auto-submit-form").change(function(){
    $(this).submit();
  });
});
