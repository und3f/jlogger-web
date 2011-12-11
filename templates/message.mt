<div class="message well
  {{#outgoing}}outgoing{{/outgoing}}
  ">
  <span class="sender-recipient">
    <a href="{{#uri}}/{{sender}}/messages{{/uri}}">
      {{sender}}/{{sender_resource}}
    </a>
    ↝
    <a href="{{#uri}}/{{recipient}}/messages{{/uri}}">
      {{recipient}}/{{recipient_resource}}
    </a>
  </span>
  <span class="timestamp">{{timestamp}}</span>

  <p class="body">{{body}}</p>
</div>
