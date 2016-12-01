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
 $('#text-area').on("click", function(e) {
   $('#form-expand').fadeIn();
}); 
}

// hide the expanded form
function hideForm() {
  $('#form-expand').hide();
}

// constructor function
function Post(id, photo, content, created_at, user, comments, tags) {
  this.id = id;
  this.photo = photo;
  this.content = content;
  this.created_at = created_at;
  this.user = user;
  this.comments = comments;
  this.tags = tags;
}

// prototype function for the Post constructor
Post.prototype.renderHtml = function() {
  var html = "";
  html += "<div class='panel panel-default'" + " id='posts-" + this.id + "'>"; 
  html += "<div class='panel-heading'>" + "<img src=" + Gravtastic(this.user.email, {default: 'identicon', size: 40 }) + "> " + this.user.name +" " + "<strong>" + this.content + "</strong>" +" " + this.displayTags() + "<br>" + this.formatTime();
  if (this.photo.url !== null) {
    html += "<br><img src=" + this.photo.url + " height='212' width='463' " + ">" + "</div>";
  } else {
    html += "</div>";
  }
  html += "<div class='panel-body'>" +"<details><summary>Comments</summary><p>" + this.displayComments() + "</p></details></div></div>";

  return html;

}
Post.prototype.displayComments = function() {
  var html = "";
  if (this.comments.length !== 0) {
    this.comments.forEach(function(comment) {
      html += "<img src=" + Gravtastic(comment.user.email, {default: 'identicon', size: 40 }) + "> " + comment.user.name + " " + "<strong>" + comment.content + "</strong><br><br>"
    });
    return html;
  }
  return html;
}

Post.prototype.displayTags = function(){
  var html= "";
  var link = "/tags/";
  this.tags.forEach(function(tag) {
   html += "<strong class='label label-danger'>#" + tag.name + "</strong>" + " ";
  });
  return html;
}

Post.prototype.formatTime = function() {
  var date = new Date(this.created_at)
  var options = {
    year: "numeric", month: "long",
    day: "numeric", hour: "2-digit", minute: "2-digit"
  };
  return date.toLocaleTimeString("en-us", options);
}

Post.prototype.displayUser = function() {
}
function getPosts(userPath) {
  $.ajax({
    url: '/feed',
    type: 'get',
    dataType: 'json',
    success: function(response) {
      response.posts.forEach(function(post) {
        var id = post.id;
        var photo = post.photo;
        var content = post.content;
        var created_at = post.created_at;
        var user = post.user;
        var comments = post.comments;
        var tags = post.tags;
        var post = new Post(id, photo, content, created_at, user, comments, tags);
        $('#posts.posts-container').append(post.renderHtml());
      });
    }
  });
}

