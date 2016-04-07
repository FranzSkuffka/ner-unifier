Promise     = require 'bluebird'
services    = require './services/index'
postProcess = require './postProcess'
_           = require 'underscore'

ner = (text, apiKeys, opts) =>

    defaults =
        language: 'english'

    opts = _.extend defaults, opts



    if !text?
        throw new Error("input is #{ text }")

    # initialize extraction for each service
    # TODO: Define if API requires key and catch missing key exceptions

    extractions = []
    for name, service of services
        if apiKeys[name]
            extractions.push(service text, apiKeys[name], opts)
        else
            extractions.push(service text, opts)

    # join api results
    Promise.all(extractions).then (results) ->
        new Promise (resolve) ->
            entities = postProcess results
            resolve entities


ner.Entity = require './Entity'
module.exports = ner
