# for more uRequire comments & examples see uBerscore https://github.com/anodynos/uBerscore/blob/bb6fa0ae60105bec381eae64b8a96d1579450f22/Gruntfile_CommentsExamples.coffee
startsWith = (string, substring) -> string.lastIndexOf(substring, 0) is 0
S = if process.platform is 'win32' then '\\' else '/'
nodeBin       = "node_modules#{S}.bin#{S}"
_ = require 'lodash'

sourceDir     = "source/code"
buildDir      = "build"
sourceSpecDir = "source/spec"
buildSpecDir  = "build/spec"

module.exports = gruntFunction = (grunt) ->
  pkg = grunt.file.readJSON('package.json')

  gruntConfig =
    urequire:
      _defaults:
        bundle:
          path: "#{sourceDir}"
          resources: [
            'inject-version'
            ['less', {$srcMain: 'style/myMainStyle.less', compress: true}]
            'teacup-js'
          ]
          main: "urequire-example"
          dependencies: exports: bundle: lodash: ['_']

        build:
          verbose: false
#          debugLevel: 100
          clean: true
          template:
            banner: """
             /**
              * #{ pkg.name } - version #{ pkg.version }
              * Compiled on #{ grunt.template.today("yyyy-mm-dd h:MM:ss") }
              * #{ pkg.repository.url }
              * Copyright(c) #{ grunt.template.today("yyyy") } #{ pkg.author.name } (#{ pkg.author.email } )
              * Licensed #{ pkg.licenses[0].type } #{ pkg.licenses[0].url }
              */\n"""

      UMD:
        template: 'UMDplain'
        dstPath: "#{buildDir}/UMD"
        optimize: uglify2:
          output: beautify: true
          compress: false
          mangle: false

        resources: [ ['teacup-js2html', {deleteJs: true, args: ['World!'] }] ] # works only with nodejs/UMD templates

      min:
        template:
          name: 'combined'
          moduleName: 'urequire-example'
        dstPath: "#{buildDir}/minified/urequire-example-min.js"
        optimize: true # true equals 'uglify2'
        rjs: preserveLicenseComments: false

      spec:
#        debugLevel: 100
        derive: []
        path: "#{sourceSpecDir}"
        copy: [/./]
        dstPath: "#{buildSpecDir}"

        dependencies: exports: bundle:
          chai: 'chai'
          lodash: ['_']
          'uberscore': '_B'
          'urequire-example': ['uEx']
          'helpers/specHelpers': 'spH'

        resources: [
          [ '+inject-_B.logger', ['**/*.js'], (m)-> m.beforeBody = "var l = new _B.Logger('#{m.dstFilename}');"]

          ['import',
              'helpers/specHelpers': [ 'tru', ['equal', 'eq'], 'fals' ]
              'lodash': [ 'isFunction' ]  # just for test
              'chai': ['expect']
          ]
        ]

      specCombined:
        derive: ['spec']
        dstPath: "#{buildSpecDir}_combined/index-combined.js"
        template: name: 'combined'

    watch:
      options: spawn: false
      UMD:
        files: ["#{sourceDir}/**/*", "#{sourceSpecDir}/**/*"]
        tasks: ['urequire:UMD' , 'urequire:spec', 'mochaCmd'] #'mocha:UMD']
      min:
        files: ["#{sourceDir}/**/*", "#{sourceSpecDir}/**/*"]
        tasks: ['urequire:min', 'urequire:specCombined', 'concat:specCombinedFakeModuleMin', 'mochaCmdDev', 'mocha:plainScript']

    shell:
      mochaCmd: command: "#{nodeBin}mocha #{buildSpecDir}/index --recursive --reporter spec"
      mochaCmdDev: command: "#{nodeBin}mocha #{buildSpecDir}_combined/index-combined --recursive --reporter spec"
      run: command: "#{nodeBin}coffee source/examples/runExample.coffee"
      options: {verbose: true, failOnError: true, stdout: true, stderr: true}

    mocha:
      plainScript:
        src: ["#{buildSpecDir}/SpecRunner_almondJs_noAMD_plainScript_min.html"]
        options: run: true

      UMD: src: ["#{buildSpecDir}/SpecRunner_unoptimized_UMD.html"]

    concat:
      specCombinedFakeModuleMin:
        options: banner: '{"name":"urequire-example", "main":"../../../minified/urequire-example-min.js"}'
        src:[]
        dest: "#{buildSpecDir}_combined/node_modules/urequire-example/package.json"

    clean: files: [buildDir]

  splitTasks = (tasks)-> if !_.isString tasks then tasks else (_.filter tasks.split(/\s/), (v)-> v)
  for task in ['shell', 'urequire']
    for cmd of gruntConfig[task]
      grunt.registerTask cmd, splitTasks "#{task}:#{cmd}"

  grunt.registerTask shortCut, splitTasks tasks for shortCut, tasks of {
    default:   "clean build test min testMin mocha run"
    build:     "urequire:UMD"

    test:      "urequire:spec mochaCmd"
    testMin:   "urequire:specCombined concat:specCombinedFakeModuleMin mochaCmdDev"
  }

  grunt.loadNpmTasks task for task of pkg.devDependencies when startsWith(task, 'grunt-')
  grunt.initConfig gruntConfig