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
        files: ['public/stylesheets/**/*.styl'],
        tasks: ['stylus', 'autoprefixer']
      },
      bower: {
        files: ['bower.json'],
        tasks: ['bowerInstall']
      }
    },

    // Add vendor prefixed styles
    autoprefixer: {
      options: {
        browsers: ['last 1 version']
      },
      dist: {
        files: [{
          expand: true,
          cwd: 'public/stylesheets/',
          src: '*.css',
          dest: 'public/stylesheets/'
        }]
      }
    },

    // Automatically inject Bower components into the app
    bowerInstall: {
      app: {
        cwd: "",
        src: ['views/index.jade']
      }
    }
  });

  grunt.registerTask('serve', 'Compile then start a connect web server', function (target) {

    grunt.task.run([
//      'bowerInstall',
      'express:dev',
      'autoprefixer',
      'watch'
    ]);
  });

  grunt.registerTask('server', 'DEPRECATED TASK. Use the "serve" task instead', function (target) {
    grunt.log.warn('The `server` task has been deprecated. Use `grunt serve` to start a server.');
    grunt.task.run(['serve:' + target]);
  });

  grunt.registerTask('default', ['serve']);
};