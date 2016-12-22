# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'pry'

def it_behaves_like_a_word_clock(*args)
  it_behaves_like('a word clock', description, *args)
end

def phrase_length(description)
  description.tr(' ', '').length
end
