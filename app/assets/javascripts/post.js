// document ready function
$(document).on('turbolinks:load', function(){
 var userPath = $('.sm-profile a').attr('href');
  attachListeners();
  if (window.location.pathname == '/') { 
    getPosts(userPath);
    hideForm();
  }
});

// handle all the listeners
function attachListeners() {
// text-area expand event  
  $('#text-area').on("click", function(e) {
    $('#form-expand').fadeIn();
  });

  // new post submit event
  $('form#new_post').on('submit', function(e) {
    e.preventDefault();
    createPost(this);
    this.reset();
    hideForm();
   });

  // new comment submit event
  $('#posts').on('submit','form#new_comment', function(e) {
    e.preventDefault();
    createComment(this);
    this.reset();
  });

  // delete a clicked post
  $('#posts').on('click', '.deletePost', function(e) {
    e.preventDefault();
    destroyPost(this);
  });
  
  // delete a clicked comment
  $('#posts').on('click', '.deleteComment', function(e) {
    e.preventDefault();
    destroyComment(this);
  });
}

// hide the expanded form
function hideForm() {
  $('#form-expand').hide();
}

// post constructor function
function Post(postObj) {
  this.id = postObj.id;
  this.photo = postObj.photo;
  this.content = postObj.content;
  this.created_at = postObj.created_at;
  this.user = postObj.user;
  this.comments = postObj.comments;
  this.tags = postObj.tags;
}

// prototype function for the Post constructor
Post.prototype.renderHtml = function() {
  var html = "";
  html += "<div class='panel panel-default'" + " id='posts-" + this.id + "'>"; 
  html += "<div class='panel-heading'>" + this.deleteLink() + "<img src=" + Gravtastic(this.user.email, {default: 'identicon', size: 40 }) + "> " + this.user.name +" " + "<strong>" + this.content + "</strong>" +" " + this.displayTags() + "<br>" + this.formatTime();
  if (this.photo.url !== null) {
    html += "<br><img src=" + this.photo.url + " height='212' width='463' " + ">" + "</div>";
  } else {
    html += "</div>";
  }
  html += "<div class='panel-body'>" + `<details id="post-${this.id}"><summary>Comments</summary>` + this.displayComments() + "</details><br>" + this.commentForm() + "</div></div>";

  return html;
}

// create the comment object and render with proper html format
Post.prototype.displayComments = function() {
  var html = "";
  if (this.comments.length !== 0) {
    this.comments.forEach(function(comment) {
      var comment = new Comment(comment);
      html += comment.renderHtml();
    });
    
    return html;
  }
  return html;
}

// generate the delete link for the original post owner
Post.prototype.deleteLink = function() {
  var userPath = $('.sm-profile a').attr('href');
  var user_id = parseInt(userPath.match(/\d+/));

  var html = "";
  if (this.user.id === user_id) {
    html += `<div class="pull-right" id="deletePost-${this.id}"><a class="deletePost" href="users/${this.user.id}/posts/${this.id}" rel="nofollow"><img alt="Close" src="/assets/close-a0c254205b11abf9cdc8272d94eafbee63fa35647fe7c909bb5436897ddb3831.png" title="Delete Post"></a></div>`;
  } 
  return html;
}

// display the tags
Post.prototype.displayTags = function(){
  var html= "";
  var link = "/tags/";
  this.tags.forEach(function(tag) {
   html += "<strong class='label label-danger'>#" + tag.name + "</strong>" + " ";
  });
  return html;
}

// format the time
Post.prototype.formatTime = function() {
  var date = new Date(this.created_at)
  var options = {
    year: "numeric", month: "long",
    day: "numeric", hour: "2-digit", minute: "2-digit"
  };
  return date.toLocaleTimeString("en-us", options);
}

// generate the comment form on each post
Post.prototype.commentForm = function() {
  var authenticity_token = $('#authenticity-token').attr('content');
  var userPath = $('.sm-profile a').attr('href');
  var user_id = parseInt(userPath.match(/\d+/));

  var html = "";
  html += `<form accept-charset="UTF-8" action="posts/${this.id}/comments" class="new_comment" id="new_comment" method="post"><input id="post_id" name="comment[post_id]" type="hidden" value="${this.id}"><input id="user_id" name="comment[user_id]" type="hidden" value="${user_id}"><input type="hidden" name="authenticity_token" value="${authenticity_token}"><div class="comment-label"><label class="sr-only" for="comment_content">Content</label></div><div class="comment-input"><input id="comment_content" name="comment[content]" placeholder="Write a comment..." title="Write a comment..." type="text"></div><input class="sr-only" name="commit" type="submit" value="Comment"></form>`;
return html;
}

// destroy the selected comment from a post
function destroyComment(commentObj) {
  var url = $(commentObj).attr('href');
  $.ajax({
    url: url,
    method: 'DELETE',
    dataType: 'json',
    success: function(response) {
      $('#deleteComment-' + response.comment.id).remove();
      $('p#' + response.comment.id).remove();
    }
  });
}

// destroy the post with associated comments
function destroyPost(postObj) {
  var url = $(postObj).attr('href');
  $.ajax({
   url: url,
   method: 'DELETE',
   dataType: 'json',
   success: function(response) {
    // need to remove the panel from the DOM
    var postId = response.post.id;
    $('#posts-' + postId).remove();
   } 
  });
}

// create the comment at the back end and add the output in the DOM
function createComment(formObj) {
  var formData = $(formObj).serialize();
  $.ajax({
    url: formObj.action,
    type: 'POST',
    dataType: 'json',
    data: formData,
    success: function(response) {
      var comment = new Comment(response.comment);
      $("details#post-" + comment.post_id).append(comment.renderHtml());
    }
  });
}
// create the post and add it to the DOM
function createPost(form) {
  var formData = new FormData(form);
  $.ajax({
    url: form.action,
    type: 'POST',
    data: formData,
    processData: false,
    contentType: false,
    cache: false,
    success: function(response){
      var post = new Post(response.post);
      $('#posts.posts-container').prepend(post.renderHtml());
    }
  });
}

// get the posts and craete each post object and display it with proper html format
function getPosts(userPath) {
  $.ajax({
    url: '/feed',
    type: 'get',
    dataType: 'json',
    success: function(response) {
      response.posts.forEach(function(postObj) {
        var post = new Post(postObj);
        $('#posts.posts-container').append(post.renderHtml());
      });
    }
  });
}
