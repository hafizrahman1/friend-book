// for the next post to render into the DOM
function nextPost() {
  $('.js-next').on('click', function(e) {
    e.preventDefault();
    var nextId = parseInt($('.js-next').attr('data-id')) + 1;
    var url = window.location.pathname.replace(/\d+$/, nextId);
    $.ajax({
      url: url,
      method: 'GET',
      dataType: 'json',
      success: function(response) {
        $('#posts.posts-container').empty();
        var post = new Post(response.post);
        $('#posts.posts-container').append(post.renderHtml());
        $(".js-next").attr("data-id", post.id);
        $(".js-prev").attr("data-id", post.id);
      },
      error: function(jqXHR, status, errorThrown) {
        console.log(errorThrown);
        $('#posts.posts-container').empty();
        $('#posts.posts-container').append(`<h3>The post does not exist!</h3>`);
      }
    });
  });
}

// for the previous post to render into the DOM
function previousPost() {
  $('.js-prev').on('click', function(e) {
    e.preventDefault();
    var prevId = parseInt($('.js-prev').attr('data-id')) - 1;
    var url = window.location.pathname.replace(/\d+$/, prevId);
    $.ajax({
      url: url,
      method: 'GET',
      dataType: 'json',
      success: function(response) {
        $('#posts.posts-container').empty();
        var post = new Post(response.post);
        $('#posts.posts-container').append(post.renderHtml());
        $(".js-prev").attr("data-id", post.id);
        $(".js-next").attr("data-id", post.id);
      },
      error: function(jqXHR, status, errorThrown) {
        console.log(errorThrown);
        //alert(jqXHR.responseText);
        $('#posts.posts-container').empty();
        $('#posts.posts-container').append(`<h3>The post does not exist!</h3>`);
      }
    });
  });
}

// display the current post
function currentPost() {
  var postId = parseInt($('.js-next').attr('data-id'));
  var url = window.location.pathname;

  // get the post data
  $.ajax({
    url: url,
    method: 'GET',
    dataType: 'json',
    success: function(response) {
      var post = new Post(response.post);
      $('#posts.posts-container').append(post.renderHtml()); 
    }
  });
}

// document ready for next and previous post listeners
$(document).on('turbolinks:load', function() {
  currentPost();
  nextPost();
  previousPost();
});
