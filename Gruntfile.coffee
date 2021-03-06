module.exports = gruntFunction = (grunt) ->
  gruntConfig =
    urequire:
      _all:
        dependencies:
          paths: bower: true
          imports: lodash: ['_']
        clean: true

      UMD:
        path: "source/code"
        resources: [
          'inject-version'
          [ '+single-quotes', ['**/*.js'],
            (m)-> m.codegenOptions = format: quotes: 'single'] # change escodegen options
        ]
        dependencies: node: ['nodeOnly/*']
        dstPath: "build/UMD"
        template:
          name: 'UMDplain'
          banner: true

      min:
        derive: 'UMD'
        dstPath: "build/minified/urequire-example-min.js"
        template: name: 'combined'
        optimize: uglify2:
          output: beautify: true
          compress: false
          mangle: false
        rjs: preserveLicenseComments: false

      spec:
        path: "source/spec"
        dstPath: "build/spec"
        dependencies: imports:
          chai: 'chai'
          uberscore: '_B'
          'urequire-example': ['uEx']
          'specHelpers': 'spH'
        resources: [
          ['import-keys',
             'specHelpers': [ 'tru', ['equal', 'eq'], 'fals', 'ok' ]
             'chai': 'expect' ] ]
        afterBuild: require('urequire-ab-specrunner').options
          injectCode: 'window.urequireExample = "Old global `urequireExample`";'

      specDev:
        derive: 'spec'
        dstPath: "build/spec_combined/index-combined.js"
        template: name: 'combined'

      specWatch: derive: 'specDev', watch: true

  splitTasks = (tasks)-> if (tasks instanceof Array) then tasks else tasks.split(/\s/).filter((f)->!!f)
  grunt.registerTask shortCut, "urequire:#{shortCut}" for shortCut of gruntConfig.urequire
  grunt.registerTask shortCut, splitTasks tasks for shortCut, tasks of {
    default: "UMD spec min specDev"
    develop: "min specWatch"
    all: "UMD spec UMD specDev min spec min specDev"
  }
  grunt.loadNpmTasks task for task of grunt.file.readJSON('package.json').devDependencies when task.lastIndexOf('grunt-', 0) is 0
  grunt.initConfig gruntConfig