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
        assert_equal 2, @response.parts.count
      end

      it 'has a boundary' do
        assert_equal '--uuid:0909325b-5e74-44eb-9a5e-4c7067f14c50', @response.boundary
      end

      it 'first part body is xml' do
        assert_equal(
          "<?xml version='1.0' encoding='UTF-8'?><S:Body />",
          @response.parts[0].body
        )
      end

      it 'second part body is csv' do
        assert_equal(
          '"first_name","last_name","preferred_name"',
          @response.parts[1].body
        )
      end
    end

    describe 'valid http multipart response with CRLF' do
      def setup
        http_body = File.read('test/files/valid-multipart-xml-csv-crlf')
        @response = HttpMultipartParser::Response.new(http_body)
      end

      it 'has 2 parts' do
        assert_equal 2, @response.parts.count
      end

      it 'has a boundary' do
        assert_equal '--uuid:4e63c9b1-2114-4921-9c22-043383db828b', @response.boundary
      end

      it 'first part body is xml' do
        assert_equal(
          "<?xml version='1.0' encoding='UTF-8'?><S:Envelope />",
          @response.parts[0].body
        )
      end

      it 'second part body is csv' do
        assert_equal(
          '"second_name","name","fancy_name"',
          @response.parts[1].body
        )
      end
    end
  end
end
