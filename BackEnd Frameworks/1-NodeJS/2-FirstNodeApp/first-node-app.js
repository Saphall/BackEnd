// First Output from node.
// command : `node first-node-app.js`
console.log('> Hello! This is first node app.')

// Writing Output into file.
const fs = require('fs')
fs.writeFileSync('hello.txt', 'Writing Hello World into the file.')
