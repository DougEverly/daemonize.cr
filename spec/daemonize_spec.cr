require "spec"
require "process"
require "tempfile"
require "./spec_helper"

describe "Daemonize" do
  it "daemonizes and has parent pid == 1" do
    # run = ->(command : String) {
    #   Process.run(
    #     "/bin/sh", input: MemoryIO.new(command), output: STDOUT, error: STDOUT
    #   )
    # }

    tmp = Tempfile.new("it_daemonizes")
    fork {
      Daemonize.daemonize
      sleep 1
      File.write(tmp.path, Process.ppid.to_s)
    }
    sleep 2
    res = File.read(tmp.path)
    res.should eq("1")
    tmp.delete
  end
end
