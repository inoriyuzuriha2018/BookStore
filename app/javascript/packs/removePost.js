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
      if (confirm('Bạn có chắc chắn muốn xóa bài viết này không?')) {
        $.ajax({
          url: '/posts/' + postId, // Đường dẫn xóa bài viết
          type: 'DELETE', // Phương thức HTTP DELETE
          dataType: 'json', // Định dạng dữ liệu trả về
          success: function(response) {
            console.log(response)
            if (response.message == "success") {
              // Xóa DOM của bài viết sau khi xóa thành công
              $('#post-' + postId).remove();
              alert('Đã xóa bài viết thành công!');
            } else {
              alert('Xóa bài viết thất bại.');
            }
          },
          error: function() {
            alert('Đã xảy ra lỗi. Vui lòng thử lại.');
          }
        });
      }
    })
  })