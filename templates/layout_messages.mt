{{#layout}}layout.mt{{/layout}}
{{#title}}{{>messages_title.mt}}{{/title}}

<script type="text/javascript">
<!--
  $(document).ready(function(){
      var loader = new MessagesLoader("{{#uri}}{{load_url}}{{/uri}}", {{params.page}});
    loader.setup();
  });
-->
</script>

<h1>{{>messages_title.mt}}</h1>

<div id="messages">
  {{&body}}
</div>

<img src="/images/preloader.gif" id="preloader"/>
