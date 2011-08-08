class PagesController < ApplicationController
  def home
    @title = "Home"
    @word = params[:word]
    logger.info "word is #{@word}"
    unless @word.nil?
      # get_definitions returns an array of definitions
      @definitions = WordnikController.new.get_definitions(@word)
      logger.info "definitions are #{@definitions}"
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
