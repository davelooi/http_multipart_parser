# frozen_string_literal: true

module HttpMultipartParser
  class Part
    def initialize(part)
      @part = part
    end

    def headers
      headers = @part.strip.split("\n\n").first
      headers.split("\n").map { |h| h.split(':').map(&:strip) }.to_h
    end

    def body
      @part.strip.split("\n\n").last
    end
  end
end
