{{#title}}JLogger Web index{{/title}}

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
