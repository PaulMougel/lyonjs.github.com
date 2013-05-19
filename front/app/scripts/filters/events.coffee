lyonjs = angular.module 'lyonjs'

lyonjs.filter 'nextEvent', ->
  (events) ->
    currentDate = new Date

    if events?
      _.min events, (event) ->
        if event.date.getTime() > currentDate.getTime()
          event.date

lyonjs.filter 'previousEvents', ->
  currentDate = new Date
  (events) ->
    filteredEvents =
      _.filter events, (event) ->
        event.date.getTime() < currentDate
    _.sortBy filteredEvents, (event) ->
      - event.date

lyonjs.filter 'commingEvents', ->
  currentDate = new Date
  (events) ->
    filteredEvents =
      _.filter events, (event) ->
        event.date.getTime() > currentDate
    sortedEvents =
      _.sortBy filteredEvents, (event) ->
        event.date
    sortedEvents.splice 1