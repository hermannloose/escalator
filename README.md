# Escalator [![Build Status on Travis CI](https://secure.travis-ci.org/hermannloose/escalator.png)](http://travis-ci.org/hermannloose/escalator)

## Running the tests

### RSpec

Start [Spork](https://github.com/sporkrb/spork):
```bash
$ spork
```

Both `autotest` and `rspec spec` should pick up the `--drb` option in `.rspec`.

### Cucumber

```bash
$ rake cucumber
```

or

```bash
$ bundle exec cucumber
```

(Still unsure as to why just `cucumber` doesn't work fully.)
