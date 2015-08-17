_.mixin
  pairs: (obj) ->
    keys = _.keys(obj)
    length = keys.length
    pairs = Array(length)
    i = 0

    while i < length
      pairs[i] = [
        keys[i]
        obj[keys[i]]
      ]
      i++
    pairs

_.mixin
  matches: (attrs) ->
    pairs = _.pairs(attrs)
    length = pairs.length
    (obj) ->
      return not length  unless obj?
      obj = new Object(obj)
      i = 0

      while i < length
        pair = pairs[i]
        key = pair[0]
        return false  if pair[1] isnt obj[key] or (key not of obj)
        i++
      true

_.mixin
  findWhere: (obj, attrs)->
    _.find obj, _.matches(attrs)

_.mixin
  createCallback: (func, context, argCount) ->
    return func  if context is undefined
    switch (if not argCount? then 3 else argCount)
      when 1
        return (value) ->
          func.call context, value
      when 2
        return (value, other) ->
          func.call context, value, other
      when 3
        return (value, index, collection) ->
          func.call context, value, index, collection
      when 4
        return (accumulator, value, index, collection) ->
          func.call context, accumulator, value, index, collection
    ->
      func.apply context, arguments


_.mixin
  iteratee: (value, context, argCount) ->
    return _.identity  unless value?
    return _.createCallback(value, context, argCount)  if _.isFunction(value)
    return _.matches(value)  if _.isObject(value)
    _.property value

_.mixin
  find: (obj, predicate, context) ->
    result = undefined
    predicate = _.iteratee(predicate, context)
    _.some obj, (value, index, list) ->
      if predicate(value, index, list)
        result = value
        true

    result

_.mixin
  where: (obj, attrs) ->
    _.filter obj, _.matches(attrs)

_.mixin
  compactObject: (o) ->
    clone = _.clone(o)
    _.each clone, (v, k) ->
      delete clone[k]  unless v
      return
    clone
