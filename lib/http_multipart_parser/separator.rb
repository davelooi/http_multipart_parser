# frozen_string_literal: true

module HttpMultipartParser
  class Separator
    class << self
      # returns an array of Part objects
      def separate(http_body, boundary)
        # remove empty string and the closing --
        parts = http_body.strip.split(boundary) - [''] - ['--']
        parts.map do |part|
          Part.new(part)
        end
      end
    end
  end
end
