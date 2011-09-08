<html>
  <head>
    <title>{{>messages_title.mt}}</title>
    {{>head.mt}}
    <script type="text/javascript">
    <!--
      $(document).ready(function(){
          var loader = new MessagesLoader("{{load_url}}", {{params.page}});
        loader.setup();
      });
    -->
    </script>
  </head>
  <body>
    {{>header.mt}}

    <h1>{{>messages_title.mt}}</h1>

    <div id="messages">
      {{>just_messages.mt}}
    </div>

    <img src="/images/preloader.gif" id="preloader"/>

    {{>footer.mt}}
  </body>
</html>
