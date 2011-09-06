<html>
  <head>
    <title>JLogger Web {{params.account}} chats</title>
    {{>head.mt}}
  </head>
  <body>
    {{>header.mt}}

    <h1>{{params.account}} chats</h1>
    <ul class="unstyled">
      <li><a href="/{{params.account}}/messages">All messages</a></li>
      {{#chats}}
      <li>
        <a href="/{{params.account}}/{{.}}">{{.}}</a>
      </li>
      {{/chats}}
    </ul>

    {{>footer.mt}}
  </body>
</html>
