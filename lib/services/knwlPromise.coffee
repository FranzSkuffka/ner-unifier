mapEntityName = require './map'

Knwl    = require 'knwl.js'
Entity = require './Entity'

knwlEntities = (text, opts) ->
    new Promise (resolve) ->
        knwlSync    = new Knwl opts.language
        knwlSync.register 'money', require '../../node_modules/knwl.js/experimental_plugins/money'
        knwlSync.register 'ratios', require '../../node_modules/knwl.js/experimental_plugins/ratios'
        # load text into knwl
        knwlSync.init text
        # define results in outer scope
        results = []

        # join and normalize results
        for money in knwlSync.get 'money'
            results.push new Entity mapEntityName('financialValue'), money.value

        for ratio in knwlSync.get 'ratios'
            results.push new Entity mapEntityName('probability'), ratio.percentileValue

        for phone in knwlSync.get 'phones'
            results.push new Entity mapEntityName('phoneNumber'), phone.phone

        for email in knwlSync.get 'emails'
            if email.preview?
                meta =
                    preview:  email.preview
            results.push new Entity mapEntityName('emailAddress'), email.address, meta
        resolve results


module.exports = knwlEntities
