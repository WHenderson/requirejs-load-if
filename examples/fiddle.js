var requirejs = require('requirejs');
var path = require('path');

requirejs.config({
  baseUrl: path.join(__dirname, '../test/fixtures'),
  paths: {
    'load-if': path.join(__dirname, '../dist/requirejs-load-if'),
    'a':'a'
  },
  nodeRequire: require
});

requirejs(['load-if!a', 'a', 'b'], function (maybeA, a, b) {
  console.log('maybe a:', maybeA);
  console.log('      a:', a);
  console.log('      b:', b);
});
