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
        options: {
          compress: true
        },
        files: {
          'src/stylesheets/main.css': ['src/stylesheets/*.styl']
        }
      }
    },

    watch: {
      express: {
        files: [
          'views/**/*.jade'
          ,'public/javascripts/**/*.js'
          ,'routes/**/*.coffee'
          ,'public/images/**/*'
          ,'public/stylesheets/**/*.css'
        ],
        tasks:  ['express:dev' ],
        // server used with FF extension
        options: {
          livereload: true,
          spawn: false
        }
      },
      stylus: {
        files: ['src/stylesheets/**/*.styl'],
        tasks: ['stylus', 'autoprefixer']
      },
      bower: {
        files: ['bower.json'],
        tasks: ['bowerInstall']
      }
    },

    reload: {
      port: 35729,
      liveReload: {},
      proxy: {
        host: "localhost",
        port: 9000
      }
    },

    // Add vendor prefixed styles
    autoprefixer: {
      multiple_files: {
         diff: true
        // ,expand: false
        // ,flatten: true
        ,src: 'src/stylesheets/main.css'
        ,dest: 'public/stylesheets/main.css'
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
      'stylus',
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
