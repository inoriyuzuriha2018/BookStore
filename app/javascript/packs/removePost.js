var csrfToken = $('meta[name="csrf-token"]').attr('content');

// Thiết lập token CSRF cho tất cả các yêu cầu Ajax
$.ajaxSetup({
  headers: {
    'X-CSRF-Token': csrfToken
  }
});

$(document).ready(function() {
    $('div#post-form .delete-post').on("click", function() {
      var postId = $(this).data('id');
      console.log(postId);
      if (confirm('Are you this delete ?')) {
        $.ajax({
          url: '/posts/' + postId, // Đường dẫn xóa bài viết
          type: 'DELETE', // Phương thức HTTP DELETE
          dataType: 'json', // Định dạng dữ liệu trả về
          success: function(response) {
            console.log(response)
            if (response.message == "success") {
              // Xóa DOM của bài viết sau khi xóa thành công
              $('#post-' + postId).remove();
              toastr.success("Deleted success!");
            } else {
              toastr.error('Deleted fail');
            }
          },
          error: function() {
            toastr.error('Something is wrong. Try again!');
          }
        });
      }
    })
  })

 // text = "<script>toastr.#{type}('#{message}');</script>"