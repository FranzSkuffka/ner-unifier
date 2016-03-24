fs = require 'fs'
ner = require '.'

apiKeys =
    alchemy: fs.readFileSync('API_keys/alchemy').toString().split('\n')[0]
    calais: fs.readFileSync('API_keys/calais').toString().split('\n')[0]

ner('You do not work for Apple in London, Mr. Anderson hello@anderson.com', apiKeys).then (res) -> console.log res
