*To flow on, to perpetually wander, to pass through states of existence.*

```coffeescript
{ Cont , Proc , runProc } = require "nbl"

print = (x) -> -> console.log x
pause = Cont (_, r) -> setTimeout r, 1000

countDown = Proc( print 3 ).then( pause ).
            then( print 2 ).then( pause ).
            then( print 1 ).then( pause ).
            then( print "Lift off!" )

runProc countDown, ->
```

## Install

It's not necessary to install nbl to use it in a web browser, just link to
it with a `script` tag.

```html
<!doctype html>
<html>
  <head>
    <script src="//nbl-cdn.appspot.com/nbl.min.js"></script>
```

To use it as a Node module:

```sh
$ npm install nbloc
```

## Contribute

```sh
$ git clone git://github.com/nbl.git
$ cd nbloc
$ npm install --dev
$ make dist
```

[browserify]: https://github.com/substack/node-browserify
[coffee-script]: https://github.com/jashkenas/coffee-script
