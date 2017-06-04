var nibbleToNumber, numberToNibble;

module.exports = function(helper) {
  var binaryToPulse, protocolInfo, pulsesToBinaryMapping;
  pulsesToBinaryMapping = {
    '00': '1',
    '01': '0',
    '02': ''
  };
  binaryToPulse = {
    '0': '01',
    '1': '00'
  };
  return protocolInfo = {
    name: 'dimmer3',
    type: 'dimmer',
    values: {
      remoteCode: {
        type: "number"
      },
      unitCode: {
        type: "number"
      },
      state: {
        type: "boolean"
      },
      dimlevel: {
        type: "number",
        min: 0,
        max: 31
      }
    },
    brands: ["LightwaveRF"],
    pulseLengths: [296, 1212, 11156], 
    pulseCount: 144,
    decodePulses: function(pulses) {
      var binary, message, result;
      message = [];
      binary = helper.map(pulses, pulsesToBinaryMapping);
      console.log(binary);
      message.push(nibbleToNumber(helper.binaryToNumber(binary, 1, 7)));
      message.push(nibbleToNumber(helper.binaryToNumber(binary, 8, 14)));
      message.push(nibbleToNumber(helper.binaryToNumber(binary, 15, 21)));
      message.push(nibbleToNumber(helper.binaryToNumber(binary, 22, 28)));
      message.push(nibbleToNumber(helper.binaryToNumber(binary, 29, 35)));
      message.push(nibbleToNumber(helper.binaryToNumber(binary, 36, 42)));
      message.push(nibbleToNumber(helper.binaryToNumber(binary, 43, 49)));
      message.push(nibbleToNumber(helper.binaryToNumber(binary, 50, 56)));
      message.push(nibbleToNumber(helper.binaryToNumber(binary, 57, 63)));
      message.push(nibbleToNumber(helper.binaryToNumber(binary, 64, 70)));
      return result = message;
    },
    encodeMessage: function(message) {
      var id1, id2, id3, id4, id5, id6, level1, level2, state, unitCode;
      level1 = helper.map(helper.numberToBinary(numberToNibble(message[0]), 7), binaryToPulse);
      level2 = helper.map(helper.numberToBinary(numberToNibble(message[1]), 7), binaryToPulse);
      unitCode = helper.map(helper.numberToBinary(numberToNibble(message[2]), 7), binaryToPulse);
      state = helper.map(helper.numberToBinary(numberToNibble(message[3]), 7), binaryToPulse);
      id1 = helper.map(helper.numberToBinary(numberToNibble(message[4]), 7), binaryToPulse);
      id2 = helper.map(helper.numberToBinary(numberToNibble(message[5]), 7), binaryToPulse);
      id3 = helper.map(helper.numberToBinary(numberToNibble(message[6]), 7), binaryToPulse);
      id4 = helper.map(helper.numberToBinary(numberToNibble(message[7]), 7), binaryToPulse);
      id5 = helper.map(helper.numberToBinary(numberToNibble(message[8]), 7), binaryToPulse);
      id6 = helper.map(helper.numberToBinary(numberToNibble(message[9]), 7), binaryToPulse);
      return "00" + level1 + level2 + unitCode + state + id1 + id2 + id3 + id4 + id5 + id6 + "02";
    }
  };
};

nibbleToNumber = function(nibble) {
  var number;
  return number = ((function() {
    switch (nibble) {
      case 0x7A:
        return 0x00;
      case 0x76:
        return 0x01;
      case 0x75:
        return 0x02;
      case 0x73:
        return 0x03;
      case 0x6E:
        return 0x04;
      case 0x6D:
        return 0x05;
      case 0x6B:
        return 0x06;
      case 0x5E:
        return 0x07;
      case 0x5D:
        return 0x08;
      case 0x5B:
        return 0x09;
      case 0x57:
        return 0x0A;
      case 0x3E:
        return 0x0B;
      case 0x3D:
        return 0x0C;
      case 0x3B:
        return 0x0D;
      case 0x37:
        return 0x0E;
      case 0x2F:
        return 0x0F;
    }
  })());
};

numberToNibble = function(number) {
  var nibble;
  return nibble = ((function() {
    switch (number) {
      case 0x00:
        return 0x7A;
      case 0x01:
        return 0x76;
      case 0x02:
        return 0x75;
      case 0x03:
        return 0x73;
      case 0x04:
        return 0x6E;
      case 0x05:
        return 0x6D;
      case 0x06:
        return 0x6B;
      case 0x07:
        return 0x5E;
      case 0x08:
        return 0x5D;
      case 0x09:
        return 0x5B;
      case 0x0A:
        return 0x57;
      case 0x0B:
        return 0x3E;
      case 0x0C:
        return 0x3D;
      case 0x0D:
        return 0x3B;
      case 0x0E:
        return 0x37;
      case 0x0F:
        return 0x2F;
    }
  })());
};
