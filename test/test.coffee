ner = require '..'

apiKeys = require './API_keys_module'

ner('You do not work for Apple in London, Mr. Anderson hello@anderson.com', apiKeys, {language: 'english'} ).then (res) ->
    console.log()
    console.log res

ner('Was ist denn in Stuttgart los, ich hoffe dass 3/4 der Leute bei Daimler arbeiten', apiKeys, {language: 'german'} ).then (res) ->
    console.log()
    console.log res

ner('Our website is at pug2php.netlify.com', apiKeys, {language: 'german'} ).then (res) ->
    console.log()
    console.log res
