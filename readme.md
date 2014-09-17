# urequire-example v0.0.1

[![Build Status](https://travis-ci.org/anodynos/urequire-example.png)](https://travis-ci.org/anodynos/urequire-example)
[![Up to date Status](https://david-dm.org/anodynos/urequire-example.png)](https://david-dm.org/anodynos/urequire-example.png)

A simple example project using [urequire](http://urequire.org) & [grunt-urequire](https://github.com/aearly/grunt-urequire).

Provides boilerplate & grunt/urequire config for cross module systems development and cross runtimes deployment.

It comes with tests that run on nodejs, phantomjs and browser (Web/AMD & Web/Script).

## Usage:

### Download and install

```bash
... $ git clone anodynos/urequire-example

... $ cd urequire-example

../urequire-example $ npm install

../urequire-example $ bower install
```

### A full clean build & test.

```bash
../urequire-example $ grunt release
```

### Watch file changes (code & specs), rebuilding *only* what is changed & running tests each time.

```bash
../urequire-example $ grunt watch:dev
```


# License

The MIT License

Copyright (c) 2014 Agelos Pikoulas (agelos.pikoulas@gmail.com)

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.