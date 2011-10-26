function MessagesLoader(url, page) {
    
    this.enabled = true;
    this.page    = page;

    this.loadMessages = function(cb) {
        this.enabled = false;
        this.page++;
        var that = this;

        $("#preloader").show();

        $.get(url, {page: this.page, no_layout: 1}, function(data) {
            $("#preloader").hide();

            if (data) {
                that.enabled = true;
                $(data).appendTo($("#messages"));

                if (cb !== undefined) cb();
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

      this.fillWindowWithMessages();
    }

    this.fillWindowWithMessages = function() {
      if ($(window).height() === $(document).height())
          var that = this;
          this.loadMessages(function(){that.fillWindowWithMessages()});
    }
}
