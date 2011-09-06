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
    <h1>
      {{params.account}}
      {{^params.account}}All{{/params.account}}
      messages
    </h1>

    {{>header.mt}}

    {{#messages}}
      {{>message.mt}}
    {{/messages}}

    {{>footer.mt}}
  </body>
</html>
