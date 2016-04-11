mapEntityName = require './map'

try
    Knwl    = require '../../../Knwl.js'
    console.log 'Using local knwl'
catch
    Knwl    = require 'knwl.js'

Entity = require '../Entity'

knwlEntities = (text, opts) ->
    new Promise (resolve) ->
        knwlSync    = new Knwl opts.language
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
            results.push new Entity mapEntityName('phoneNumber'), phone.number, {knwl:{country: phone.country}}

        for link in knwlSync.get 'links'
            results.push new Entity mapEntityName('urls'), link.link

        for website in knwlSync.get 'websites'
            results.push new Entity mapEntityName('website'), website

        for email in knwlSync.get 'emails'
            if email.preview?
                meta =
                    knwl:
                        preview:  email.preview
            results.push new Entity mapEntityName('emailAddress'), email.address, meta
        resolve results


module.exports = knwlEntities
