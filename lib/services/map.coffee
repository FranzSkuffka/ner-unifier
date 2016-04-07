fuzzymap = require 'fuzzymap'

module.exports = (name) ->

    map =
        emailAddress: ['EmailAddress', 'emailAddress', 'email']
        city: ['City']
        companyName: ['Company']
        personName: ['Person']
        website: ['website']
        link: ['url']

    mapper = fuzzymap.defineMap map
    mapper.map name
