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

    <h1>
      {{params.account}}
      {{^params.account}}All{{/params.account}}
      messages
    </h1>

    {{#messages}}
      {{>message.mt}}
    {{/messages}}

    {{>footer.mt}}
  </body>
</html>
