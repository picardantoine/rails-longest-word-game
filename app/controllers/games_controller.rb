require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabet = ("a".."z").to_a
    @letters = []
    10.times do |i|
      @letters.push(alphabet.sample)
    end
  end

  def score
    @word = params[:word]
    @test = true
    @letters = params[:letters].split("").join(", ")
    params[:word].split("").each do |letter|
      @test = @test&params[:letters].split("").include?(letter)
    end

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    url_serialized = open(url).read
    api = JSON.parse(url_serialized)
    @dictionary = api['found']



    if @test == false
      @message = "Sorry"
    elsif @dictionary == false
      @message = "Not in the dictionary"
    else
      @message = "bravo"
    end
  end
end

# "Sorry, but <b><%= @word.upcase %></b> can't be built out of <%= @letters.upcase %>"
