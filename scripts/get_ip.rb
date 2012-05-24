require 'net/http'

uri = URI('http://checkip.dyndns.com')

Net::HTTP.start(uri.host, uri.port) do |http|
  request = Net::HTTP::Get.new uri.request_uri
  response = http.request request # Net::HTTPResponse object
  puts response.body.split('</body>')[0].split('Address: ')[1]
end