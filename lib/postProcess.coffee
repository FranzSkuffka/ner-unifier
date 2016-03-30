_ = require 'underscore'
Entity = require './Entity'

module.exports = (apiResults) ->

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

    deduplicateEntityList = (entityList, duplicateGroups) ->
        type = entityList[0].type
        for group in duplicateGroups
            meta = []
            value = ''
            for entity, i in group
                value = entityList[i].value if entityList[i].value.length > value.length
                delete entityList[i]
            entityList.push new Entity type, value, meta
        return _.compact entityList

    deduplicateEntityLists = (entityLists) ->
        deduplicated = {}

        for name, list of entityLists

            deduplicatedList = []

            # store indices of duplicated entries
            duplicateGroups = []

            for entity, firstIndex in list
                secondIndex = firstIndex + 1
                while secondIndex < list.length

                    # duplicate value detection
                    # first has more data

                    if list[firstIndex].value.indexOf list[secondIndex].value > -1 or
                    list[secondIndex].value.indexOf list[firstIndex].value > -1
                        # find if it exists already
                        if duplicateGroups.length > 0
                            for group in duplicateGroups
                                if group.indexOf firstIndex > -1
                                    group.push secondIndex
                                if group.indexOf secondIndex > -1
                                    group.push firstIndex
                        else
                            duplicateGroups.push [firstIndex, secondIndex]

                    # second has more data

                    for group, i in duplicateGroups
                        duplicateGroups[i] = _.uniq group

                    # merge entities
                    # remove both old and replace with new entity
                    secondIndex++
            deduplicated[name] = deduplicateEntityList list, duplicateGroups
        deduplicated

    return deduplicateEntityLists sortEntities _.flatten apiResults
