$(document).on("turbolinks:load", function() {
  function previewImageUpload(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $("#img-prev").attr("src", e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $("#img-upload").change(function() {
    previewImageUpload(this);
  });
});
