<html>
  <head>
    <title>JLogger Web index</title>
    {{>head.mt}}
  </head>
  <body>
    {{>header.mt}}
    <h1>JLogger accounts</h1>

    <ul class="unstyled">
      <li>
        <a href="/messages">All captured messages</a>
      </li>
      {{#accounts}}
      <li>
        <a href="{{#uri}}/{{.}}{{/uri}}">{{.}}</a>
      </li>
      {{/accounts}}
    </ul>

    {{>footer.mt}}
  </body>
</html>
