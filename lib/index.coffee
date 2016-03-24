Promise  = require 'bluebird'
services = require './services/index'
_        = require 'underscore'

ner = (text, apiKeys) =>

    # sort entities into lists
    sortEntities = (allEntities) ->
        entities = {}
        for entity in allEntities
            # assign entity to entity list with pluralized type as name
            pluralTypeName = entity.type + 'List'
            if !entities[pluralTypeName]?
                entities[pluralTypeName] = [entity]
            else
                entities[pluralTypeName].push entity
        return entities

    if !text?
        throw new Error("input is #{ text }")

    # initialize extraction for each service
    # TODO: Define if API requires key and catch missing key exceptions

    extractions = []
    for name, service of services
        if apiKeys[name]
            extractions.push(service text, apiKeys[name])
        else
            extractions.push(service text)

    # join api results
    Promise.all(extractions).then (results) ->
        new Promise (resolve) ->
            entities = sortEntities _.flatten results
            resolve entities

module.exports = ner
