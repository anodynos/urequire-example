# urequire-example

[![Build Status](https://travis-ci.org/anodynos/urequire-example.png)](https://travis-ci.org/anodynos/urequire-example)
[![Up to date Status](https://david-dm.org/anodynos/urequire-example.png)](https://david-dm.org/anodynos/urequire-example.png)

## Introduction

An example project build with [urequire](http://urequire.org), [grunt-urequire](https://github.com/aearly/grunt-urequire) & [urequire-ab-specrunner](https://github.com/anodynos/urequire-ab-specrunner).

*For a simpler example see [urequire-example-helloworld](http://github.com/anodynos/urequire-example-helloworld)*

With just ~50 lines of DRY & declarative uRequire config, this example shows off the **automagical** :

* transparent compilation from **coffee-script**, **coco**, **LiveScript** etc to **javascript**.

* conversion from **AMD** or **CommonJs** (or a combination of both) to **UMD** or **combined** (`<script>`, `AMD` & `nodejs` compatible) javascript.

* importing of dependencies (i.e `dependencies: imports: lodash: ['_']`) *and* keys out of them (`resources: ['import-keys', {'chai': 'expect'} ] ]`) to all modules in the bundle (held by some variable name). The latter uses the `urequire-rc-import-keys` ResourceConverter *plugin*.

* injection of a `var VERSION = 'x.x.x';` in *main module's body*, where `'x.x.x'` comes from `package.json` (using the `urequire-rc-inject-version` ResourceConverter *plugin*).

* gereration of a standard *banner*, with info from `package.json`.

* declarative exporting of main module on `window.myModule` (with `noConflict()` baked in).

* minification with **uglify2's** passing some rudimentary options.

* discovery of dependencies's paths using the info already in **bower** or nodejs's **npm**.

* generated tests that run on nodejs & **phantomjs** (browser) via **mocha** (& **chai**), both as **Web/AMD** & **Web/Script**. It even generates the required HTML, with all module's paths, **requirejs**'s configs & shims or `<script ...>` tags etc.

* watch facility with rapid rebuilds, since it compiles *only files that have really changed* and also runs the tests only if a) there were changes and b) with no compilation errors.

* clean of destination files / folders before each build.

* deriving (i.e like *inheritance* in OO) of configs.

* passing r.js options

* a cross *module systems development*, *cross runtimes deployment* & automagical continuous testing.

* and *last but not least*: The *elimination* of (the need for) **grunt plugins**. There's isnt any hint of `grunt-xxx` for `watch`, `coffee-script`, `browserify`, `uglify`, `mocha`, `concat`, `phantomjs`, `banner`, `clean` etc). This is great news cause **grunt plugins have many disadvantages** :

     * repeating the same source & dest paths & files all over again (when you should keep it DRY)

     * you have to learn the intricacies & syntax of each plugin

     * making sure they run in the right order & hope they produce the right result

     * producing many intermediate temp files (slow on i/o)

     * usually building everything with each change

     * writing stuff for things that should be automagical ;-)

Who's gulping ?

## Usage

### Prerequisites

You should already have installed and working

```bash
  $ npm install -g grunt-cli
  $ npm install -g bower
  $ npm install -g mocha
  $ npm install -g mocha-phantomjs
```

### Download repo & install deps

Clone and install dependencies for both nodejs (npm) & browser (bower):

```bash
$ git clone http://github.com/anodynos/urequire-example && cd urequire-example
$ npm install && bower install
```

### A full clean build & test.

Run the default build & specs test with

```bash
$ grunt
```

that builds with UMD & min (combined & uglified) and runs the specs on both nodejs & the browser.

The HTML spec runner and all other configs (requirejs, paths, shims, fake-module of lib inside specs etc) are automagically generated by [urequire-ab-specrunner](https://github.com/anodynos/urequire-ab-specrunner).

Hit `$ grunt all` to run all specs against all builds!

### Watch *real* changes

When you develop you need to watch **code** & **specs** paths and rebuild modules / resources that _seem_ to have changed. Then you want your tooling to run the specs *only* when modules have _really_ changed (i.e not to run when just whitespace or comments changed or any change that doesn't really alters the resulting parsed javascript AST). This is an example of what urequire offers.

To get all of this automation, just issue :

```bash
 $ grunt develop
```

which is really a shortcut to

```
 $ grunt min specWatch
```

You can of course `watch` against other lib builds, eg:

```
 $ grunt UMD specWatch
```

Note how [`specWatch`](https://github.com/anodynos/uRequire-example/blob/master/Gruntfile.coffee#L43-L45) is just derived from [`specDev`](https://github.com/anodynos/uRequire-example/blob/master/Gruntfile.coffee#L38-L43), (that is derived from [`spec`](https://github.com/anodynos/uRequire-example/blob/master/Gruntfile.coffee#L23-L38)) just adding a `watch: true`

```
    specWatch: derive: 'specDev', watch: true
```

Using `derive` allows you to inherit from other configs, like in Object Oriented Programming. You dont need to repeat existing properties, but you can add or redefine existing ones.

Under the hood, the watch feature auto generates & invokes a [`grunt-contrib-watch`](https://github.com/gruntjs/grunt-contrib-watch) task, through the [`urequire-ab-grunt-contrib-watch`](https://github.com/anodynos/urequire-ab-grunt-contrib-watch]) `afterBuild`-er.

### I want more

For more advanced uRequire config examples with comments etc see :

* uBerscore's [full grunt config](https://github.com/anodynos/uBerscore) ~~or the one with comments~~.

* uRequire's [own build & spec run with uRequire - eat your own dog food:-)](https://github.com/anodynos/uRequire/blob/master/Gruntfile.coffee)

* uRequire's [config docs](https://github.com/anodynos/uRequire/blob/master/source/code/config/MasterDefaultsConfig.coffee.md)

* Check out the [urequire-ab-specrunner](https://github.com/anodynos/urequire-ab-specrunner) docs.

Finally, write your awesome `ResourceConverter` or `AfterBuilder` (and publish it as `urequire-rc-awesome` or `urequire-ab-awesome` :-)

# License

The MIT License

Copyright (c) 2015 Agelos Pikoulas (agelos.pikoulas@gmail.com)

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