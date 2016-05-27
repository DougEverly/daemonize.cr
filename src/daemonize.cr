require "./daemonize/*"

lib LibC
  fun setsid : PidT
  fun getsid(pid : PidT) : PidT
end

class Daemonize
  def self.setsid
    LibC.setsid
  end

  def self.sid(pid : Int32 = 0)
    LibC.getsid(pid)
  end

  # Daemonizes the process
  #
  # This method detaches the process from the terminal so the program
  # may run in the backgound without the terminal.
  #
  # By default STDIN, STDOUT, and STDERR are redirected to /dev/null.
  # They may be redirected to a file to be read-in by STDIN, or written-
  # to by STDOUT and STDERR.
  #
  # By default, the daemonized process will change to root as a working directory.
  # Another working directory can be provided.
  def self.daemonize(stdin : String = "/dev/null", stdout : String = "/dev/null", stderr : String = "/dev/null", dir : String = "/")
    exit if fork
    setsid
    exit if fork
    Dir.cd(dir)
    STDIN.reopen(File.open(stdin, "a+"))
    STDOUT.reopen(File.open(stdout, "a"))
    STDERR.reopen(File.open(stderr, "a"))
  end
end
