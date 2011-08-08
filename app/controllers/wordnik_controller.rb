class WordnikController < ApplicationController

  # Wordnik documentation available here: http://developer.wordnik.com/docs
  # We didn't use the provided Ruby gem because one of the dependencies
  # would not install on our development system.

  require 'net/http'
  require 'json'
  
  def initialize
    @api_key = "a0d90d68b5ceed2b585060c2d470cedd42a4eead8ea809459"
  end

  def definition
    render :json => get_definitions(params["word"])
  end

  def search
    # returns a json array of terms with same beginning

    render :json => get_related(params["term"])
    # we use "term" because it is the parameter
    # sent by jQuery's autocomplete function
  end

  def get_definitions(word)
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
    base = "http://api.wordnik.com/v4"
    if type == :definitions
      url = "#{base}/word.json/#{word}/definitions?api_key=#{@api_key}"
      # will return a json object which includes the definition
    elsif type == :search
      url = "#{base}/words.json/search?query=#{word}&api_key=#{@api_key}"
      # will return a json object with a default of 10 words with same beginning
    end

    response = Net::HTTP.get_response(URI.parse(url))

    return JSON.parse(response.body)
  end
end

