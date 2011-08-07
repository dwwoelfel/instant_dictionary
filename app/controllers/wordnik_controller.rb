class WordnikController < ApplicationController

  require 'net/http'
  require 'json'
  
  def initialize
    @api_key = "a0d90d68b5ceed2b585060c2d470cedd42a4eead8ea809459"
  end

  def definition
    render :json => get_definitions(params["word"])
  end

  def search
    render :json => get_related(params["term"])
  end

  def get_definitions(word)
    json_obj = api_request(:definitions, word)
    
    definitions = []

    logger.info word
    logger.info json_obj

    json_obj.each do |item|
      logger.info item
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
    base = "http://api.wordnik.com/v4"
    if type == :definitions
      url = "#{base}/word.json/#{word}/definitions?api_key=#{@api_key}"
    elsif type == :search
      url = "#{base}/words.json/search?query=#{word}&api_key=#{@api_key}"
    end

    logger.info url

    response = Net::HTTP.get_response(URI.parse(url))

    logger.info response

    return JSON.parse(response.body)
  end
end

