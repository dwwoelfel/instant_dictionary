class PagesController < ApplicationController
  def home
    @title = "Home"
    @word = params[:word]
    logger.info "word is #{@word}"
    unless @word.nil?
      @definitions = WordnikController.new.get_definitions(@word)
      logger.info "definitions are #{@definitions}"
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
