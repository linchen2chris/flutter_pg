var http = require('http');
var fs = require('fs');

http.createServer(function (req, res) {
    console.log('called');
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end("done");
}).listen(9615);
