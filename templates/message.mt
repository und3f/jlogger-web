<div class="message well
  {{#outgoing}}outgoing{{/outgoing}}
  ">
  <span class="sender-recipient">
    <a href="{{#uri}}/{{sender.jid}}/messages{{/uri}}">
      {{sender.jid}}/{{sender_resource}}
    </a>
    ↝
    <a href="{{#uri}}/{{recipient.jid}}/messages{{/uri}}">
      {{recipient.jid}}/{{recipient_resource}}
    </a>
  </span>
  <span class="timestamp">{{timestamp}}</span>

  <p class="body">{{body}}</p>
</div>
