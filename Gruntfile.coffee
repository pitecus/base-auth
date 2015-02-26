module.exports = (grunt) ->
  # Configure grunt.
  grunt.initConfig
    # Project metadata.
    'bower': grunt.file.readJSON 'bower.json'
    'package': grunt.file.readJSON 'package.json'

    # Compile in coffee script.
    'coffee':
      # Server and their minions.
      'server':
        'options':
          'bare': true
          'sourceMap': false
          'join': false
        'expand': true
        'flatten': false
        'cwd': 'src/server'
        'src': [
          '**/*.coffee'
        ]
        'dest': 'dist/server'
        'ext': '.js'
      # Application.
      'app':
        'options':
          'bare': true
          'sourceMap': true
          'join': false
        'expand': true
        'flatten': false
        'cwd': 'dist/web/static/<%= package.name %>-<%= package.version %>/js/'
        'src': [
          '**/*.coffee'
        ]
        'dest': 'dist/web/static/<%= package.name %>-<%= package.version %>/js/'
        'ext': '.js'

    # CoffeeLint
    'coffeelint':
      'options':
        'configFile': 'coffeelint.json'
      'server': [
        'src/server/**/*.coffee'
      ]
      'app': [
        'src/angular/**/*.coffee'
      ]

    # Execute concurrent tasks.
    'concurrent':
      'server':
        'tasks': [
          'nodemon'
          'watch'
        ]
        'options':
          'logConcurrentOutput': true

    # Copy resources.
    'copy':
      'app':
        'files': [
          # Coffee website.
          'expand': true
          'src': [
            '**/*.coffee'
          ]
          'cwd': 'src/app'
          'dest': 'dist/web/static/<%= package.name %>-<%= package.version %>/js'
        ]
      'server':
        'files': [
          # Configuration.
          'expand': true
          'src': [
            'app.json'
          ]
          'cwd': 'conf'
          'dest': 'dist/server/conf'
        ]
      'static':
        'files': [
            # Website.
            'expand': true
            'src': [
              '**'
            ]
            'cwd': 'src/static'
            'dest': 'dist/web'
        ]
      'vendor':
        'files': [
            # Bower: Angular Library.
            'expand': true
            'cwd': 'vendor/angular'
            'src': [
              'angular.js'
              'angular.min.js'
              'angular.min.js.map'
            ]
            'dest': 'dist/web/static/angular-<%= bower.dependencies.angular %>/js'
          ,
            # Bower: Angular Route Library.
            'expand': true
            'cwd': 'vendor/angular-route'
            'src': [
              'angular.js'
              'angular-route.min.js'
              'angular-route.min.js.map'
            ]
            'dest': 'dist/web/static/angular-<%= bower.dependencies.angular %>/js'
          ,
            # Bower: Angular Cookies Library.
            'expand': true
            'cwd': 'vendor/angular-cookies'
            'src': [
              'angular-cookies.js'
              'angular-cookies.min.js'
              'angular-cookies.min.js.map'
            ]
            'dest': 'dist/web/static/angular-<%= bower.dependencies.angular %>/js'
          ,
            # Bower: Bootstrap Library.
            'expand': true
            'cwd': 'vendor/bootstrap/dist'
            'src': [
              'css/bootstrap.min.css'
              'css/bootstrap-theme.min.css'
              'fonts/glyphicons-halflings-regular.eot'
              'fonts/glyphicons-halflings-regular.svg'
              'fonts/glyphicons-halflings-regular.ttf'
              'fonts/glyphicons-halflings-regular.woff'
            ]
            'dest': 'dist/web/static/bootstrap-<%= bower.dependencies.bootstrap %>'
          ,
            # Bower: Angular Bootstrap.
            'expand': true
            'cwd': 'vendor/angular-bootstrap'
            'src': [
              'ui-bootstrap.min.js'
              'ui-bootstrap-tpls.min.js'
            ]
            'dest': 'dist/web/static/angular-bootstrap-<%= bower.dependencies["angular-bootstrap"] %>/js'
          ,
            # Bower: RequireJS Library.
            'expand': true
            'cwd': 'vendor/requirejs'
            'src': [
              'require.js'
            ]
            'dest': 'dist/web/static/requirejs-<%= bower.dependencies.requirejs %>/js'
        ]

    # Generate documentation from the code.
    'grock':
      'options':
        'github': false
        'index': 'README.md'
        'style': 'thin'
        'verbose': false
        'out': 'dist/web/static/<%= package.name %>-<%= package.version %>/docs'
      'files': [
        'README.md'
        'Gruntfile.coffee'
        'src/server/**/*.coffee'
      ]

    # Generate the css files.
    'less':
      'build':
        'options':
          'compress': true
          'cleancss': true
          'report': 'min'
          'paths': [
            'src/less'
          ]
        'files':
          'dist/web/static/<%= package.name %>-<%= package.version %>/css/auth.min.css': 'src/less/auth.less'

    # Monitors code change and restart the server accordingly.
    'nodemon':
      'server':
        'script': 'server.js'
        'options':
          'env':
            'PORT': '3000'
          'cwd': 'dist/server'
          'ext': 'js'
          'watch': [
            '.'
          ]
          'delay': 1000
          'legacyWatch': true

    # Watch for files and act when they change.
    'watch':
      'reload':
        'files': [
          'dist/**'
        ]
        'options':
          'livereload': true
      'app':
        'files': [
          'Gruntfile.coffee'
          'src/app/**'
        ]
        'tasks': [
          'build_app'
        ]
      'less':
        'files': [
          'Gruntfile.coffee'
          'src/less/**'
        ]
        'tasks': [
          'build_less'
        ]
      'server':
        'files': [
          'Gruntfile.coffee'
          'package.json'
          'test/**/*.coffee'
          'conf/**'
          'src/server/**/*'
        ]
        'tasks': [
          'build_server'
        ]
      'static':
        'files': [
          'Gruntfile.coffee'
          'src/static/**'
        ]
        'tasks': [
          'build_static'
        ]
      'vendor':
        'files': [
          'Gruntfile.coffee'
          'bower.json'
          'vendor/**'
        ]
        'tasks': [
          'build_vendor'
        ]

    # Load tasks.
    grunt.loadNpmTasks 'grunt-coffeelint'
    grunt.loadNpmTasks 'grunt-concurrent'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-less'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-grock'
    grunt.loadNpmTasks 'grunt-nodemon'

    # Build the project.
    grunt.registerTask 'build', 'Build the project', ->
      grunt.task.run 'build_app'
      grunt.task.run 'build_less'
      grunt.task.run 'build_server'
      grunt.task.run 'build_static'
      grunt.task.run 'build_vendor'

    # Build the website.
    grunt.registerTask 'build_app', 'Compile the angular files', ->
      # Build the website.
      grunt.task.run 'coffeelint:app'
      grunt.task.run 'copy:app'
      grunt.task.run 'coffee:app'

    # Build the website server.
    grunt.registerTask 'build_less', 'Compile the less files', ->
      # Generate the css file.
      grunt.task.run 'less'

    # Build the website server.
    grunt.registerTask 'build_server', 'Compile the server', ->
      # Check the code sanity, convert the coffed files.
      grunt.task.run 'coffeelint:server'
      grunt.task.run 'coffee:server'

      # Copy the configuration file.
      grunt.task.run 'copy:server'

    # Copy web files - index and templates.
    grunt.registerTask 'build_static', 'Copy the templates', ->
      grunt.task.run 'copy:static'

    # Copy vendor web files.
    grunt.registerTask 'build_vendor', 'Copy the vendor files', ->
      grunt.task.run 'copy:vendor'

    # Default task.
    grunt.registerTask 'sandbox', [
      'build'
      'concurrent'
    ]

    # Default task.
    grunt.registerTask 'default', [
      'build'
    ]