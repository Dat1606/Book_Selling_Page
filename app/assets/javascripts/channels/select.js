$(document).on('turbolinks:load', function(){
$('#select-requests').change(function() {
  var requests = $('#select-requests').val()

  $.ajax({
    url: '/requests',
    method: 'GET',
    data: {
      requests: requests
    }
  })
})
})
