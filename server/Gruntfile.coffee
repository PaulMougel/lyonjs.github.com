module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    coffee:
      compile:
        expand: true
        cwd: 'coffee'
        src: ['**/*.coffee']
        dest: 'js'
        ext: '.js'
        options:
          sourceMap: true
      compileTest:
        expand: true
        cwd: 'test'
        src: ['**/*.coffee']
        dest: 'test'
        ext: '.js'
    simplemocha:
      all:
        src: ['test/**/*.js']
    nodemon:
      dev:
        options:
          debug: true
          delaytime: 1
          watchedFolders: ['js']
    watch:
      coffeeServer:
        files: ['coffee/**/*.coffee']
        tasks: ['coffee:compile']
    concurrent:
      dev:
        tasks: ['watch', 'nodemon']
        options:
          logConcurrentOutput: true


  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-simple-mocha'
  grunt.loadNpmTasks 'grunt-concurrent'
  grunt.loadNpmTasks 'grunt-nodemon'

  grunt.registerTask 'default', ['coffee']
  grunt.registerTask 'dev', ['coffee', 'concurrent']
  grunt.registerTask 'test', ['coffee', 'simplemocha']