ner-unifier
======

A unified interface for named entity recognition libraries and services

> **Note:** If you have any feedback or questions, don't hesitate to open file an issue.

> **Note:** This project is in early development, and versioning is a little different. [Read this](http://markup.im/#q4_cRZ1Q) for more details.

### Why should you care?

If you build an application that relies heavily on named entity recognition you may want to use multiple services to optimize the data your software is operating on.
NER-unifier allows you to extract entities through a single interface.

### Installation

Currently only available in CoffeeScript, installed directly from GitHub.

`npm install franzskuffka/ner-unifier`

### Usage

NER-unifier currently exposes a function through it's JavaScript API.
You need to pass it a string, API keys and options.
The function call returns a Promise.


```coffee

ner = require 'ner-unifier'

options =
    language: 'english'

apiKeys =
    alchemy: 'ABCDEFG'
    calais: 'ABCDEFG'

ner 'You do not work for Apple in London, Mr. Anderson hello@anderson.com', apiKeys, options'
    .then (res) -> console.log res
```

### Options
NER-unifier currently has a single option

- `language`: possible values depend on the service support

### Supported APIs and libraries

- [knwl.js](https://github.com/loadfive/Knwl.js/) by @loadfive
- [OpenCalais](http://www.opencalais.com/)
- [AlchemyAPI](http://www.alchemyapi.com/)

### Adding services

Take a look at the adapters inside the `lib/services` directory to learn more about adding services.

### Roadmap

- Improve comments of source code
- make API more robust (error messages for missing API keys, API errors, input etc.)
- come up with a better format for service adapters
- CI and tests

### License

Licensed under [MIT](license.md)
