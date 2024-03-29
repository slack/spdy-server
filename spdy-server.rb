require 'eventmachine'
require 'spdy'

class SPDYHandler < EM::Connection
  def post_init
    @parser = SPDY::Parser.new
    @parser.on_headers do |stream_id, headers|
      p [:SPDY_HEADERS, headers]

      sr = SPDY::Protocol::Control::SynReply.new({:zlib_session => @parser.zlib_session})
      h = {'Content-Type' => 'text/plain', 'status' => '200 OK', 'version' => 'HTTP/1.1'}
      sr.create({:stream_id => stream_id, :headers => h})
      send_data sr.to_binary_s

      p [:SPDY, :sent, :SYN_REPLY]

      d = SPDY::Protocol::Data::Frame.new
      d.create(:stream_id => stream_id, :data => "This is SPDY.")
      send_data d.to_binary_s

      p [:SPDY, :sent, :DATA]

      d = SPDY::Protocol::Data::Frame.new
      d.create(:stream_id => stream_id, :flags => 1)
      send_data d.to_binary_s

      p [:SPDY, :sent, :DATA_FIN]
    end

  end

  def receive_data(data)
    p [:received, data]
    @parser << data
  end

  def unbind
    p [:SPDY, :connection_closed]
    @parser.zlib_session.reset
  end
end

EM.run do
  EM.start_server '0.0.0.0', 10000, SPDYHandler
end
