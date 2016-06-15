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

  {{#encrypted}}
    <p class="encrypted body">encrypted message</p>
    <!-- BODY:
      {{body}}
    --!>
  {{/encrypted}}
  {{^encrypted}}
    <p class="body">{{body}}</p>
  {{/encrypted}}
</div>
