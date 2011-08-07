module WordnikHelper

  require 'net/http'
  
  @api_key = 'a0d90d68b5ceed2b585060c2d470cedd42a4eead8ea809459'

  def get_definitons(word)
    json_obj = api_request(:definitions, word)
    
    definitions = []
    
    
    json_obj.each do |item|
      definitions << item["text"]
    end
      
    return definitions
  end

  def get_related(word)
    json_obj = api_request(:search, word)
    
    related = []
    
    json_obj.each do |item|
      related << item["wordstring"]
    end

    return related
  end

  def api_request(type, word)
    base = "http://api.wordnik.com/v4/word.json"
    if type == :definitions
      url = "#{base}/#{word}/definitions?api_key=#{@api_key}"
    elsif type == :search
      url = "#{base}/search?query=#{word}&api_key=#{@api_key}"
    end

    response = Net::HTTP.get_response(URI.parse(url))

    return JSON.parse(response.body)
  end
end
