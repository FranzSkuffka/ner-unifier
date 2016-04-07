fs = require 'fs'

module.exports = apiKeys =
    alchemy: fs.readFileSync("#{__dirname}/API_keys/alchemy").toString().split('\n')[0]
    calais: fs.readFileSync("#{__dirname}/API_keys/calais").toString().split('\n')[0]
