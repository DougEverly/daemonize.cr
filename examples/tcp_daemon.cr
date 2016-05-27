require "../src/daemonize.cr"
require "socket"

# goes with tcp_client.cr

HOST = "127.0.0.1"
PORT = 9000

puts "Telnet to #{HOST} port #{PORT} and type exit to kill daemon."

Daemonize.daemonize

def process(client)
  client_addr = client.remote_address
  puts "#{client_addr} connected"

  while msg = client.read_line.chop
    if msg == "exit"
      client.puts "The daemon is exiting"
      Process.exit
    end
    client.puts "The daemon got \"#{msg}\""
  end
rescue IO::EOFError
  puts "#{client_addr} dissconnected"
ensure
  client.close
end

server = TCPServer.new HOST, PORT
puts "listen on #{HOST}:#{PORT}"
loop { spawn process(server.accept) }
