<html>
  <head>
    <title>JLogger Web index</title>
    {{>head.mt}}
  </head>
  <body>
    {{>header.mt}}

    <ul id="accounts">
      <li>
        <a href="/messages">All messages</a>
      </li>
      {{#accounts}}
      <li>
        <a href="/{{.}}">{{.}}</a>
      </li>
      {{/accounts}}
    </ul>

    {{>footer.mt}}
  </body>
</html>
