# frozen_string_literal: true

require 'test_helper'

module HttpMultipartParser
  describe Response do
    describe 'valid http multipart response' do
      def setup
        http_body = File.read('test/files/valid-multipart-xml-csv')
        @response = HttpMultipartParser::Response.new(http_body)
      end

      it 'has 2 parts' do
        assert_equal 2, @response.parts
      end
    end
  end
end
