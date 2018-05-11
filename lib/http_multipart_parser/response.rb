# frozen_string_literal: true

module HttpMultipartParser
  class Response
    def initialize(http_body)
      @http_body = http_body
    end

    def parts
      Separator.separate(@http_body, boundary)
    end

    def boundary
      # the first line with --
      @http_body.lines.find do |line|
        line.start_with?('--')
      end.strip
    end
  end
end
