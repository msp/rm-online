'use strict';

// # Globbing
// for performance reasons we're only matching one level down:
// 'test/spec/{,*/}*.js'
// use this if you want to recursively match all subfolders:
// 'test/spec/**/*.js'

module.exports = function (grunt) {

  // Load grunt tasks automatically
  require('load-grunt-tasks')(grunt);

  grunt.initConfig({

    express: {
      options: {
       // Override defaults here
//       delay: 300
        port: process.env.PORT || 9000
      },
      dev: {
        options: {
          script: 'bin/www'
        }
      }
    },

    stylus: {
      compile: {
        files: {
          'public/stylesheets/main.css': 'public/stylesheets/main.styl' // 1:1 compile
        }
      }
    },

    watch: {
      options: {
        livereload: true
      },
      express: {
        files: [
          'public/stylesheets/**/*.css',
          'views/**/*.jade',
          'public/javascripts/**/*.js',
          'public/images/**/*'
        ],
        tasks:  [ 'express:dev' ],
        options: {
          livereload: true,
          spawn: false
        }
      },
      stylus: {
        files: [
          'public/stylesheets/**/*.styl'
        ],
        tasks: [
          'stylus'
        ]
      }
    }
  });

  grunt.registerTask('default', ['express:dev','watch']);
};