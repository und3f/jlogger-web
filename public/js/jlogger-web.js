$(document).ready(function() {
    $("#preloader").ajaxStart(function(){
        $(this).show();
    }).ajaxStop(function(){
        $(this).hide();
    });
});

function MessagesLoader(url, page) {
    
    this.enabled = true;
    this.page    = page;

    this.loadMessages = function() {
        this.enabled = false;
        this.page++;
        var that = this;
        $.get(url, {page: this.page, no_layout: 1}, function(data) {
            if (data) {
                that.enabled = true;
                $(data).appendTo($("#messages"));
            }
        });
    }

    this.onScroll = function() {
      if (!this.enabled) return;

      var rest = $(document).height()
          - $(window).height() - $(window).scrollTop();
      if (rest < 50) this.loadMessages();
    }

    this.setup = function() {
      var that = this;
      $(window).scroll(function(){that.onScroll()});
    }
}
