Entity  = require './Entity'
Calais = require('calais').Calais
mapEntityName = require './map'

calaisEntities = (text, apiKey, opts) ->
    calais = new Calais apiKey, {language: opts.language}
    new Promise (resolve) ->
        calais.set('content', text)
        calais.fetch (err, result) ->
            entities = []
            for endpoint, data of result
                if data._typeGroup == 'entities'
                    meta =
                        instances: data.instances
                        relevance: data.relevance
                    entities.push new Entity mapEntityName(data._type), data.name, meta
            resolve entities

module.exports = calaisEntities
