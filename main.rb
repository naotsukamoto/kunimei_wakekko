require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "hjUd6CUD4CS512L2aU1oKBALq"
  config.consumer_secret     = "9xo3nr9iBjRBmdkvkqplJ6iTKEwqMyIfJGSLRp2EZgN0omifHr"
  config.access_token        = "1221350086048772096-BW9FBnqcWWWELRQ8LRCdTFiBqiceGW"
  config.access_token_secret = "n2oP51udT64aq0hLo7CXOFaLrLsf5r0P20vsTuzkud4oH"
end

stream_client = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = "hjUd6CUD4CS512L2aU1oKBALq"
  config.consumer_secret     = "9xo3nr9iBjRBmdkvkqplJ6iTKEwqMyIfJGSLRp2EZgN0omifHr"
  config.access_token        = "1221350086048772096-BW9FBnqcWWWELRQ8LRCdTFiBqiceGW"
  config.access_token_secret = "n2oP51udT64aq0hLo7CXOFaLrLsf5r0P20vsTuzkud4oH"
end

client.update("test")