# frozen_string_literal: false

module Integral
  module TextCalculations
    def self.text_to_a4(text)
      fail ArgumentError unless text.nil? || text.is_a?(String)
      str = text.to_s
      return 0 if str == ""
      (str.size / 1800.0).round(1)
    end
  end
end
