<html>
  <head>
    <title>JLogger Web {{params.account}} messages</title>
    {{>head.mt}}
  </head>
  <body>
    {{>header.mt}}

    <ul id="accounts">
      <li>
        <a href="/messages">All messages</a>
      </li>
      {{#chats}}
      <li>
        <a href="/{{params.account}}/{{.}}">{{.}}</a>
      </li>
      {{/chats}}
    </ul>

    {{>footer.mt}}
  </body>
</html>
