assert = require 'assert'

controller = require '../src/controller.coffee'
controller.debug = yes

describe '#decodePulses()', ->
  tests = [
    {
      protocol: 'dimmer3'
      pulseLengths: [296, 204, 1212, 11156]
      pulses: [
        '000001000001000001000100000000000000000100010000000100000100000001000001000100000000010000000100000101000100000000000100000100000000000001000102',
        '000000010000000100000000010001000000000100010000000001000100000001000001000100000000010000000100000101000100000000000100000100000000000001000102'
      ],
      values: [
        [9,15,0,1,1,7,1,15,9,0]
        [4,0,0,0,1,7,1,15,9,0]
      ]
    }
  ]

  runTest = ( (t) ->
    it "#{t.protocol} should decode the pulses", ->
      for pulses, i in t.pulses
        results = controller.decodePulses(t.pulseLengths, pulses)
        console.log results
        assert(results.length >= 1, "pulse #{pulses} of #{t.protocol} should be detected.")
        result = null
        for r in results
          if r.protocol is t.protocol
            result = r
            break
        assert(result, "pulse #{pulses} of #{t.protocol} should be detected as #{t.protocol}.")
        # assert.deepEqual(result.values, t.values[i])
  )

  runTest(t) for t in tests

describe '#encodeMessage()', ->
  tests = [
    {
      protocol: 'dimmer3'
      message: [9,15,0,1,1,7,1,15,9,0]
      pulses: '000001000001000001000100000000000000000100010000000100000100000001000001000100000000010000000100000101000100000000000100000100000000000001000102'
    }
  ]


  runTest = ( (t) ->
    it "should create the correct pulses for #{t.protocol}", ->
      result = controller.encodeMessage(t.protocol, t.message)
      console.log result
      assert.equal result.pulses, t.pulses
  )

  runTest(t) for t in tests
