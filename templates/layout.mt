<html>
  <head>
    <title>{{title}}</title>
    <link rel="stylesheet" href="/css/bootstrap-1.2.0.min.css">
    <style type="text/css" title="jlogger-web" media="screen">
      @import "/css/jlogger-web.css";
    </style>
    <script type="text/javascript"
      src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.3/jquery.min.js">
    </script>
    <script type="text/javascript" src="/js/jlogger-web.js"></script>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  </head>
  <body>
    <div class="topbar">
      <div class="fill">
        <div class="container">
          <h3><a href="/">JLogger-Web</a></h3>
          <ul class="nav">
            <li class="active"><a href="/">Home</a></li>
            <li><a href="#" onClick="history.go(-1); return false;">Back</a></li>
          </ul>
        </div>
      </div>
    </div>
    <div class="container">
      {{&body}}
    </div>
  </body>
</html>
