<div class="message alert-message block-message
  {{#outgoing}}
    success
  {{/outgoing}}
  {{^outgoing}}
    info
  {{/outgoing}}
  ">
  <span class="sender-recipient">
    <a href="/{{sender.jid}}/messages">
      {{sender.jid}}/{{sender_resource}}
    </a>
    ↝
    <a href="/{{recipient.jid}}/messages">
      {{recipient.jid}}/{{recipient_resource}}
    </a>
  </span>
  <span class="timestamp">{{timestamp}}</span>

  <p class="body">{{body}}</p>
</div>
