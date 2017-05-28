module.exports = (helper) ->
  pulsesToBinaryMapping = {
    '00': '1' #binary 1
    '01': '0' #binary 0
    '02': ''  #footer
  }
  binaryToPulse = {
    '0': '01'
    '1': '00'
  }
  return protocolInfo = {
    name: 'dimmer3'
    type: 'dimmer'
    values:
      remoteCode:
        type: "number"
      unitCode:
        type: "number"
      state:
        type: "boolean"
      dimlevel:
        type: "number"
        min: 0
        max: 31
    brands: ["LightwaveRF"]
    pulseLengths: [296, 204, 1212, 11156]
    pulseCount: 144
    decodePulses: (pulses) ->
      message = []
      # we first map the sequences to binary
      binary = helper.map(pulses, pulsesToBinaryMapping)
      console.log(binary)

      message.push(nibbleToNumber(helper.binaryToNumber(binary, 1, 7)))
      message.push(nibbleToNumber(helper.binaryToNumber(binary, 8, 14)))

      message.push(nibbleToNumber(helper.binaryToNumber(binary, 15, 21)))

      message.push(nibbleToNumber(helper.binaryToNumber(binary, 22, 28)))

      message.push(nibbleToNumber(helper.binaryToNumber(binary, 29, 35)))
      message.push(nibbleToNumber(helper.binaryToNumber(binary, 36, 42)))
      message.push(nibbleToNumber(helper.binaryToNumber(binary, 43, 49)))
      message.push(nibbleToNumber(helper.binaryToNumber(binary, 50, 56)))
      message.push(nibbleToNumber(helper.binaryToNumber(binary, 57, 63)))
      message.push(nibbleToNumber(helper.binaryToNumber(binary, 64, 70)))

      return result = message
    encodeMessage: (message) ->
      # [9,15,0,1,1,7,1,15,9,0]
      level1 = helper.map(helper.numberToBinary(numberToNibble(message[0]), 7), binaryToPulse)
      level2 = helper.map(helper.numberToBinary(numberToNibble(message[1]), 7), binaryToPulse)

      unitCode = helper.map(helper.numberToBinary(numberToNibble(message[2]), 7), binaryToPulse)
      state = helper.map(helper.numberToBinary(numberToNibble(message[3]), 7), binaryToPulse)

      id1 = helper.map(helper.numberToBinary(numberToNibble(message[4]), 7), binaryToPulse)
      id2 = helper.map(helper.numberToBinary(numberToNibble(message[5]), 7), binaryToPulse)
      id3 = helper.map(helper.numberToBinary(numberToNibble(message[6]), 7), binaryToPulse)
      id4 = helper.map(helper.numberToBinary(numberToNibble(message[7]), 7), binaryToPulse)
      id5 = helper.map(helper.numberToBinary(numberToNibble(message[8]), 7), binaryToPulse)
      id6 = helper.map(helper.numberToBinary(numberToNibble(message[9]), 7), binaryToPulse)

      return "00#{level1}#{level2}#{unitCode}#{state}#{id1}#{id2}#{id3}#{id4}#{id5}#{id6}02"
  }

nibbleToNumber = (nibble) ->
  number = (
    switch nibble
      when 0x7A then 0x00
      when 0x76 then 0x01
      when 0x75 then 0x02
      when 0x73 then 0x03
      when 0x6E then 0x04
      when 0x6D then 0x05
      when 0x6B then 0x06
      when 0x5E then 0x07
      when 0x5D then 0x08
      when 0x5B then 0x09
      when 0x57 then 0x0A
      when 0x3E then 0x0B
      when 0x3D then 0x0C
      when 0x3B then 0x0D
      when 0x37 then 0x0E
      when 0x2F then 0x0F
  )

numberToNibble = (number) ->
  nibble = (
    switch number
      when 0x00 then 0x7A
      when 0x01 then 0x76
      when 0x02 then 0x75
      when 0x03 then 0x73
      when 0x04 then 0x6E
      when 0x05 then 0x6D
      when 0x06 then 0x6B
      when 0x07 then 0x5E
      when 0x08 then 0x5D
      when 0x09 then 0x5B
      when 0x0A then 0x57
      when 0x0B then 0x3E
      when 0x0C then 0x3D
      when 0x0D then 0x3B
      when 0x0E then 0x37
      when 0x0F then 0x2F
  )
