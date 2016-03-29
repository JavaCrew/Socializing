humanizeDuration = require ".."
humanizer = humanizeDuration.humanizer
assert = require "assert"
ms = require "ms"

describe "humanizer", ->

  it "humanizes English when passed no arguments", ->
    h = humanizer()
    assert.equal h(1000), "1 second"

  it "humanizes English when passed an empty object", ->
    h = humanizer({})
    assert.equal h(1000), "1 second"

  it "can change the delimiter", ->
    h = humanizer(delimiter: "+")
    assert.equal h(0), "0 seconds"
    assert.equal h(1000), "1 second"
    assert.equal h(363000), "6 minutes+3 seconds"

  it "can change the spacer", ->
    h = humanizer(spacer: " whole ")
    assert.equal h(0), '0 whole seconds'
    assert.equal h(1000), '1 whole second'
    assert.equal h(260040000), '3 whole days, 14 whole minutes'

  it "can change the units", ->
    h = humanizer(units: ["d"])
    assert.equal h(0), "0 days"
    assert.equal h(ms("6h")), "0.25 days"
    assert.equal h(ms("7d")), "7 days"

  it "can overwrite the unit measures in the initializer", ->
    h = humanizer
      unitMeasures:
        y: 10512000000,
        mo: 864000000,
        w: 144000000,
        d: 28800000
        h: 3600000
        m: 60000
        s: 1000
        ms: 1
    assert.equal h(1000), "1 second"
    assert.equal h(3600000), "1 hour"
    assert.equal h(28800000), "1 day"
    assert.equal h(144000000), "1 week"

  it "can change the decimal", ->
    h = humanizer(units: ["s"], decimal: 'what')
    assert.equal h(1234), '1what234 seconds'
    assert.equal h(1234, decimal: '!!'), '1!!234 seconds'

  it "can round", ->
    h = humanizer(round: true)
    assert.equal h(0), '0 seconds'
    assert.equal h(499), '0 seconds'
    assert.equal h(500), '1 second'
    assert.equal h(1000), '1 second'
    assert.equal h(1499), '1 second'
    assert.equal h(1500), '2 seconds'
    assert.equal h(1500), '2 seconds'
    assert.equal h(121499), '2 minutes, 1 second'
    assert.equal h(121500), '2 minutes, 2 seconds'

  it "can ask for the largest units", ->
    h = humanizer(largest: 2)
    assert.equal h(0), "0 seconds"
    assert.equal h(1000), "1 second"
    assert.equal h(2000), "2 seconds"
    assert.equal h(540360012), "6 days, 6 hours"
    assert.equal h(540360012), "6 days, 6 hours"
    assert.equal h(540360012, largest: 3), "6 days, 6 hours, 6 minutes"
    assert.equal h(540360012, largest: 100),
                 "6 days, 6 hours, 6 minutes, 0.012 seconds"

  it "has properties which can be modified", ->
    h = humanizer()
    assert.equal h(363000), "6 minutes, 3 seconds"
    h.delimiter = "+"
    assert.equal h(363000), "6 minutes+3 seconds"
    h.language = "es"
    assert.equal h(363000), "6 minutos+3 segundos"
    h.units = ["m"]
    assert.equal h(363000), "6,05 minutos"

  it "is a named function", ->
    assert.equal(humanizer().name, "humanizer")

  it "can add a new language", ->
    h = humanizer({ language: "cool language" })
    h.languages["cool language"] =
      y: -> "y"
      mo: -> "mo"
      w: -> "w"
      d: -> "d"
      h: -> "h"
      m: -> "mi"
      s: -> "s"
      ms: -> "ms"
    assert.equal h(1000), "1 s"
    assert.equal h(1000, { language: "es" }), "1 segundo"
    anotherH = humanizer({ language: "cool language" })
    assert.throws((-> anotherH(1000)), Error)

  it "can overwrite an existing language", ->
    h = humanizer(language: "en")
    assert.equal h(1000), "1 second"
    h.languages["en"] =
      y: -> "y"
      mo: -> "mo"
      w: -> "w"
      d: -> "d"
      h: -> "h"
      m: -> "m"
      s: -> "s"
      ms: -> "ms"
    assert.equal h(1000), "1 s"
    assert.equal h(15600000), "4 h, 20 m"
    anotherH = humanizer(language: "en")
    assert.equal anotherH(1000), "1 second"

  it "can overwrite the languages property in the initializer", ->
    h = humanizer
      languages:
        en:
          y: -> "y"
          mo: -> "mo"
          w: -> "w"
          d: -> "d"
          h: -> "h"
          m: -> "m"
          s: -> "s"
          ms: -> "ms"
    assert.equal h(1000), "1 s"
    assert.equal h(15600000), "4 h, 20 m"
