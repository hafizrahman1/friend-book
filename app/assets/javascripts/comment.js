class Comment {
  constructor(commentObj) {
    this.id = commentObj.id;
    this.user_id = commentObj.user.id;
    this.userName = commentObj.user.name;
    this.user_email = commentObj.user.email;
    this.post_id = commentObj.post.id;
    this.content = commentObj.content;
    this.created_at = commentObj.created_at;
  }

  formatTime() {
    var date = new Date(this.created_at);
    var options = {
      year: "numeric", month: "long",
      day: "numeric", hour: "2-digit", minute: "2-digit"
    };
    return date.toLocaleTimeString("en-us", options); 
  }


  deleteLink() {
    var userPath = $('.sm-profile a').attr('href');
    var userId = parseInt(userPath.match(/\d+/));
    var html = "";
    
    if (this.user_id === userId) {
      html += `<div class="pull-right" id="deleteComment-${this.id}"><a class="deleteComment" href="posts/${this.post_id}/comments/${this.id}" rel="nofollow"><img alt="Close" src="/assets/close-a0c254205b11abf9cdc8272d94eafbee63fa35647fe7c909bb5436897ddb3831.png" title="Delete Comment"></a></div>`;
    }
    return html;
  }
  
  renderHtml() {
    var html = "";
    html += this.deleteLink() + `<p id="${this.id}">` +  "<img src=" + Gravtastic(this.user_email, {default: 'identicon', size: 30 }) + "> " + this.userName + " " + "<strong>" + this.content + "</strong><br>" + this.formatTime() + "</p>";    
    return html;
  }
}

