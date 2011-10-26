{{#title}}JLogger Web {{params.account}} chats{{/title}}

<h1>{{params.account}} chats</h1>
<ul class="unstyled">
  <li><a href="/{{params.account}}/messages">All messages</a></li>
  {{#chats}}
  <li>
  <a href="{{#uri}}/{{params.account}}/{{.}}{{/uri}}">{{.}}</a>
  </li>
  {{/chats}}
</ul>
