Entity  = require './Entity'
Alchemy = require './alchemy'
mapEntityName = require './map'

alchemyEntities = (text, apiKey) ->
    alchemy = new Alchemy(apiKey)
    new Promise (resolve) ->
        alchemy.entities "text", text, {'language': 'german'}, (res) ->
            results = []
            for entity in res.entities
                results.push new Entity mapEntityName(entity.type), entity.text
            resolve results

module.exports = alchemyEntities 
