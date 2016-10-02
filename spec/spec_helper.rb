# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry'

def phrase_length(description)
  description.tr(' ', '').length
end
