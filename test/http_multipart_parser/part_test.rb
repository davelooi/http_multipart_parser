# frozen_string_literal: true

require 'test_helper'

module HttpMultipartParser
  describe Part do
    describe 'valid http multipart response' do
      def setup
        input = %(
Content-Id:<parameters=b67c4f2f-bff7-44c1-865f-3fcafdaed638@example.com>
Content-Type: application/octet-stream
Content-Transfer-Encoding: binary

"first_name","last_name","preferred_name"
"david", "looi", "dave"
)
        @part = HttpMultipartParser::Part.new(input)
      end

      it 'has Content-Id' do
        assert_equal '<parameters=b67c4f2f-bff7-44c1-865f-3fcafdaed638@example.com>', @part.headers['Content-Id']
      end

      it 'has Content-Type' do
        assert_equal 'application/octet-stream', @part.headers['Content-Type']
      end

      it 'has Content-Transfer-Encoding' do
        assert_equal 'binary', @part.headers['Content-Transfer-Encoding']
      end

      it 'has a body' do
        assert_equal "\"first_name\",\"last_name\",\"preferred_name\"\n\"david\", \"looi\", \"dave\"", @part.body
      end
    end
  end
end
