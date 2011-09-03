<html>
  <head>
    <title>
      {{params.account}}
      {{^params.account}}All{{/params.account}}
      messages
    </title>
    {{>head.mt}}
  </head>
  <body>
    {{>header.mt}}

    {{#messages}}
      {{>message.mt}}
    {{/messages}}

    {{>footer.mt}}
  </body>
</html>
