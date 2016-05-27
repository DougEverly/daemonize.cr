# daemonize

Daemonize daemonizes a Crsytal process so that it properly runs in the background without needing a terminal session.

This is a shard of pending pull request https://github.com/crystal-lang/crystal/pull/2375.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  daemonize:
    github: DougEverly/daemonize.cr
```


## Usage

See examples in the examples directory.

```crystal
require "daemonize"

Daemonize.daemonize

```

Daemonize also accepts file paths for STDIN, STDOUT, and STDERR. Defaults for all are "/dev/null".

```crystal
require "daemonize"

Daemonize.daemonize(stdout: "/dev/null", stderr: "/var/log/errors.log", stdin: "/var/tmp/a_file")

```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it ( https://github.com/DougEverly/daemonize.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [[DougEverly]](https://github.com/DougEverly/daemonize.cr) Doug Everly - creator, maintainer
