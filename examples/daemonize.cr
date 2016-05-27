require "logger"
require "tempfile"
require "../src/daemonize"
puts "Daemonizing..."

stdout = Tempfile.new("out")
stderr = Tempfile.new("err")
stdin = Tempfile.new("in")

puts <<-THE_END
STDOUT is #{stdout.path}
STDERR is #{stderr.path}
STDIN  is #{stdin.path}

Type `kill -9 #{Process.pid}` to kill the daemon.

THE_END


Daemonize.daemonize(stdout: stdout.path, stderr: stderr.path, stdin: stdin.path)

begin
  log = Logger.new(STDERR)
  log.level = Logger::WARN

  loop do
    sleep 1
    puts "I am writing to STDOUT"
    log.warn("I am writing to STDERR")
  end
ensure
  stdout.delete
  stderr.delete
  stdin.delete
end
