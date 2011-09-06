<html>
  <head>
    <title>{{>messages_title.mt}}</title>
    {{>head.mt}}
  </head>
  <body>
    {{>header.mt}}

    <h1>{{>messages_title.mt}}</h1>

    {{#messages}}
      {{>message.mt}}
    {{/messages}}

    {{>footer.mt}}
  </body>
</html>
