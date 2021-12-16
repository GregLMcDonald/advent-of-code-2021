#! /usr/bin/env ruby
puzzle_data = "00537390040124EB240B3EDD36B68014D4C9ECCCE7BDA54E62522A300525813003560004223BC3F834200CC108710E98031C94C8B4BFFF42398309DDD30EEE00BCE63F03499D665AE57B698F9802F800824DB0CE1CC23100323610069D8010ECD4A5CE5B326098419C319AA2FCC44C0004B79DADB1EB48CE5EB7B2F4A42D9DF0AA74E66468C0139341F005A7BBEA5CA65F3976200D4BC01091A7E155991A7E155B9B4830056C01593829CC1FCD16C5C2011A340129496A7EFB3CA4B53F7D92675A947AB8A016CD631BE15CD5A17CB3CEF236DBAC93C4F4A735385E401804AA86802D291ED19A523DA310006832F07C97F57BC4C9BBD0764EE88800A54D5FB3E60267B8ED1C26AB4AAC0009D8400854138450C4C018855056109803D11E224112004DE4DB616C493005E461BBDC8A80350000432204248EA200F4148FD06C804EE1006618419896200FC1884F0A00010A8B315A129009256009CFE61DBE48A7F30EDF24F31FCE677A9FB018F6005E500163E600508012404A72801A4040688010A00418012002D51009FAA0051801CC01959801AC00F520027A20074EC1CE6400802A9A004A67C3E5EA0D3D5FAD3801118E75C0C00A97663004F0017B9BD8CCA4E2A7030C0179C6799555005E5CEA55BC8025F8352A4B2EC92ADF244128C44014649F52BC01793499EA4CBD402697BEBD18D713D35C9344E92CB67D7DFF05A60086001610E21A4DD67EED60A8402415802400087C108DB068001088670CA0DCC2E10056B282D6009CFC719DB0CD3980026F3EEF07A29900957801AB8803310A0943200042E3646789F37E33700BE7C527EECD13266505C95A50F0C017B004272DCE573FBB9CE5B9CAE7F77097EC830401382B105C0189C1D92E9CCE7F758B91802560084D06CC7DD679BC8048AF00400010884F18209080310FE0D47C94AA00"


data = puzzle_data
# data = "C200B40A82"


h_to_b = {
"0" => "0000",
"1" => "0001",
"2" => "0010",
"3" => "0011",
"4" => "0100",
"5" => "0101",
"6" => "0110",
"7" => "0111",
"8" => "1000",
"9" => "1001",
"A" => "1010",
"B" => "1011",
"C" => "1100",
"D" => "1101",
"E" => "1110",
"F" => "1111",
}

data_as_b = data.chars.each.map { |h| h_to_b[h].chars }.flatten

def parse_literal(data)
  b_digits = data.chars
  digits = []
  continue = true
  while continue
    chunk = b_digits.shift(5)
    stop_bit = chunk.shift
    continue = false if stop_bit == "0"
    digits << chunk
  end
  digits.flatten.join.to_i(2)
end

def parse_packet(data)
  version = nil
  type = nil
  packet = { version: nil, type: nil, payload: nil, remaining_bits: nil }
  while packet[:remaining_bits] == nil
    if packet[:version] == nil
      packet[:version] = data.shift(3).join.to_i(2)
    elsif packet[:type] == nil
      packet[:type] = data.shift(3).join.to_i(2)
    elsif packet[:type] == 4 # literal packet
      continue = true
      value_digits = []
      while continue
        chunk = data.shift(5)
        stop_bit = chunk.shift
        continue = false if stop_bit == "0"
        value_digits << chunk
      end
      value = value_digits.flatten.join.to_i(2)
      packet[:payload] = value
      # puts "only zeroes? #{data.select { |elem| elem != "0"}.size == 0}"
      packet[:remaining_bits] = data
    else # operator packet
      payload = []
      length_type_bit = data.shift
      nb_of_subpacket_bits = nil
      nb_of_subpackets = nil
      if length_type_bit == "0"
        nb_of_subpacket_bits = data.shift(15).join.to_i(2)
        subpacket_bits = data.shift(nb_of_subpacket_bits)
        while subpacket_bits.size > 0
          result = parse_packet(subpacket_bits)
          subpacket_bits = result[:remaining_bits]
          result[:remaining_bits] = nil
          payload << result
        end
        packet[:payload] = payload
      else
        nb_of_subpackets = data.shift(11).join.to_i(2)
        while payload.size < nb_of_subpackets
          result = parse_packet(data)
          data = result[:remaining_bits]
          result[:remaining_bits] = nil
          payload << result
        end
        packet[:payload] = payload
      end
      packet[:remaining_bits] = data
    end
  end
  packet
end
packet = parse_packet(data_as_b)
# pp packet

# part 1
# def get_version_sum(packet)
#   result = 0
#   result += packet[:version]
#   packet[:payload].each { |subpacket| result += get_version_sum(subpacket) } unless packet[:type] == 4
#   result
# end
# puts get_version_sum(packet)

# part 2
def sum(packet)
  result = 0
  packet[:payload].each { |subpacket| result += packet_value(subpacket)}
  result
end

def product(packet)
  result = 1
  packet[:payload].each { |subpacket| result *= packet_value(subpacket) }
  result
end

def min(packet)
  values = []
  packet[:payload].each { |subpacket| values << packet_value(subpacket) }
  values.min
end

def max(packet)
  values = []
  packet[:payload].each { |subpacket| values << packet_value(subpacket) }
  values.max
end

def gt(packet)
  a = packet_value(packet[:payload][0])
  b = packet_value(packet[:payload][1])
  a > b ? 1 : 0
end

def lt(packet)
  a = packet_value(packet[:payload][0])
  b = packet_value(packet[:payload][1])
  a < b ? 1 : 0
end

def eq(packet)
  a = packet_value(packet[:payload][0])
  b = packet_value(packet[:payload][1])
  a == b ? 1 : 0
end

def packet_value(packet)
  return packet[:payload] if packet[:type] == 4

  case packet[:type]
  when  0  then sum(packet)
  when  1  then product(packet)
  when  2  then min(packet)
  when  3  then max(packet)
  when  5  then gt(packet)
  when  6  then lt(packet)
  when  7  then eq(packet)
  end
end
puts packet_value(packet)