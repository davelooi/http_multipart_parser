# HTTP Multipart Parser

[![Build Status](https://travis-ci.org/davelooi/http_multipart_parser.svg?branch=master)](https://travis-ci.org/davelooi/http_multipart_parser)

Use this gem to parse multipart messages into coherent Ruby-flavoured pieces.

## Usage

Imagine your API vendor returns you a multipart body that looks like this:

    --uuid:0909325b-5e74-44eb-9a5e-4c7067f14c50
    Content-Type: text/xml

    <?xml version='1.0' encoding='UTF-8'?><S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"><S:Body /></S:Envelope>
    --uuid:0909325b-5e74-44eb-9a5e-4c7067f14c50
    Content-Id:<parameters=b67c4f2f-bff7-44c1-865f-3fcafdaed638@example.com>
    Content-Type: application/octet-stream
    Content-Transfer-Encoding: binary

    "first_name","last_name","preferred_name"
    "david", "looi", "dave"

    --uuid:0909325b-5e74-44eb-9a5e-4c7067f14c50--

But you only care about that CSV data near the bottom. How on earth are you supposed to process this?

Like this!

```ruby
input = %(
--uuid:0909325b-5e74-44eb-9a5e-4c7067f14c50
Content-Type: text/xml

<?xml version='1.0' encoding='UTF-8'?><S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"><S:Body /></S:Envelope>
--uuid:0909325b-5e74-44eb-9a5e-4c7067f14c50
Content-Id:<parameters=b67c4f2f-bff7-44c1-865f-3fcafdaed638@example.com>
Content-Type: application/octet-stream
Content-Transfer-Encoding: binary

"first_name","last_name","preferred_name"
"david", "looi", "dave"

--uuid:0909325b-5e74-44eb-9a5e-4c7067f14c50--
)

response = HttpMultipartParser::Response.new(input)
parts = response.parts
csv_part = parts.detect { |p| p.headers["Content-Type"] == "application/octet-stream" }
puts csv_part.body
```

## Reference

This gem is built based on this [RFC1341(MIME)](https://www.w3.org/Protocols/rfc1341/7_2_Multipart.html).
