require "../src/daemonize.cr"
require "tempfile"

stdout = Tempfile.new("out")
stdin = Tempfile.new("in")

puts <<-THE_END
Reading from #{stdin.path}
Writing to #{stdout.path}

To kill daemon: 'echo "exit" >> #{stdin.path}'

  or

Type `kill -9 #{Process.pid}` to kill the daemon.

THE_END

Daemonize.daemonize(stdin: stdin.path, stdout: stdout.path)

def process(msg)
  if msg
    puts "The daemon got line '#{msg.chop}'"
    if msg.chop == "exit"
      puts "bye"
      exit
    end
  end
end

loop { process(STDIN.gets) }
