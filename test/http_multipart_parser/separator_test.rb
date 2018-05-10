# frozen_string_literal: true

require 'test_helper'

module HttpMultipartParser
  describe Separator do
    describe 'valid http multipart response' do
      def setup
        input = %(
--uuid:1fe211a2-9207-4981-b1ba-95c51dc9dadd
Content-Type: text/xml

<?xml version='1.0' encoding='UTF-8'?><Body />
--uuid:1fe211a2-9207-4981-b1ba-95c51dc9dadd
Content-Type: text/plain

Hello World

--uuid:1fe211a2-9207-4981-b1ba-95c51dc9dadd--
)
        @parts = HttpMultipartParser::Separator.separate(input, '--uuid:1fe211a2-9207-4981-b1ba-95c51dc9dadd')
      end

      it 'has 2 content parts' do
        assert_equal 2, @parts.count
      end

      it 'contains Part objects' do
        @parts.each do |part|
          assert_equal Part, part.class
        end
      end
    end
  end
end
