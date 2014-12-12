module.exports = (grunt) ->
  # Configure grunt.
  grunt.initConfig
    # Project metadata.
    'bower': grunt.file.readJSON 'bower.json'
    'package': grunt.file.readJSON 'package.json'

    # Clean files and folders.
    'clean':
      'build': [
        'dist'
      ]
    # Compile in coffee script.
    'coffee':
      # Application.
      'angular':
        'options':
          # Compile the JavaScript without the top-level function safety wrapper.
          'bare': true
          # Compile JavaScript and create a .map file linking it to the CoffeeScript source.
          'sourceMap': true
          # When compiling multiple .coffee files into a single .js file, concatenate first.
          'join': false
        'expand': true
        'flatten': false
        'cwd': 'dist/static/<%= package.name %>/js/'
        'src': [
          '**/*.coffee'
        ]
        'dest': 'dist/static/<%= package.name %>/js/'
        'ext': '.js'
      # Server and their minions.
      'server':
        'options':
          # Compile the JavaScript without the top-level function safety wrapper.
          'bare': true
          # Compile JavaScript and create a .map file linking it to the CoffeeScript source.
          'sourceMap': false
          # When compiling multiple .coffee files into a single .js file, concatenate first.
          'join': false
        'expand': true
        'flatten': false
        'cwd': 'src/server'
        'src': [
          '**/*.coffee'
        ]
        'dest': 'dist/server'
        'ext': '.js'

    # CoffeeLint
    'coffeelint':
      'options':
        'configFile': 'coffeelint.json'
      'server': [
        'src/server/**/*.coffee'
      ]
      'angular': [
        'src/angular/**/*.coffee'
      ]

    # Execute concurrent tasks.
    'concurrent':
      'server':
        tasks: [
          'nodemon'
          'watch'
        ]
        options:
          logConcurrentOutput: true

    # Copy resources.
    'copy':
      'angular':
        'files': [
          # Coffee website.
          'expand': true
          'src': [
            '**/*.coffee'
          ]
          'cwd': 'src/angular'
          'dest': 'dist/static/<%= package.name %>/js'
        ]
      'config':
        'files': [
          # Configuration.
          'expand': true
          'src': [
            'app.json'
          ]
          'cwd': 'conf'
          'dest': 'dist/server/conf'
        ]
      'templates':
        'files': [
            # Index website.
            'expand': true
            'cwd': 'src/static'
            'src': [
              'index.html'
            ]
            'dest': 'dist/static'
          ,
            # Templates.
            'expand': true
            'cwd': 'src/static/templates'
            'src': [
              '**'
            ]
            'dest': 'dist/static/<%= package.name %>/templates'
        ]
      'vendor':
        'files': [
            # Bower: Angular Library.
            'expand': true
            'cwd': 'vendor/angular'
            'src': [
              'angular.min.js'
              'angular.min.js.map'
            ]
            'dest': 'dist/static/angular-<%= bower.dependencies.angular %>/js'
          ,
            # Bower: Angular Route Library.
            'expand': true
            'cwd': 'vendor/angular-route'
            'src': [
              'angular-route.min.js'
              'angular-route.min.js.map'
            ]
            'dest': 'dist/static/angular-<%= bower.dependencies.angular %>/js'
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
            'dest': 'dist/static/bootstrap-<%= bower.dependencies.bootstrap %>'
          ,
            # Bower: Angular Bootstrap.
            'expand': true
            'cwd': 'vendor/angular-bootstrap'
            'src': [
              'ui-bootstrap.min.js'
              'ui-bootstrap-tpls.min.js'
            ]
            'dest': 'dist/static/angular-bootstrap-<%= bower.dependencies["angular-bootstrap"] %>/js'
          ,
            # Bower: RequireJS Library.
            'expand': true
            'cwd': 'vendor/requirejs'
            'src': [
              'require.js'
            ]
            'dest': 'dist/static/requirejs-<%= bower.dependencies.requirejs %>/js'
        ]

    # Generate documentation from the code.
    'grock':
      'options':
        'github': false
        'index': 'README.md'
        'style': 'thin'
        'verbose': false
        'out': 'dist/static/<%= package.name %>-<%= package.version %>/docs'
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
          'dist/static/<%= package.name %>/css/auth.min.css': 'src/less/auth.less'

    # Monitors code change and restart the server accordingly.
    'nodemon':
      'server':
        'script': 'server.js'
        'options':
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
      'angular':
        'files': [
          'Gruntfile.coffee'
          'src/angular/**'
        ]
        'tasks': [
          'build_angular'
        ]
      'less':
        'files': [
          'Gruntfile.coffee'
          'src/less/**'
        ]
        'tasks': [
          'build_web_less'
        ]
      'server':
        'files': [
          'Gruntfile.coffee'
          'src/server/**/*'
        ]
        'tasks': [
          'build_server'
        ]
      'templates':
        'files': [
          'Gruntfile.coffee'
          'src/static/**'
        ]
        'tasks': [
          'build_templates'
        ]

    # Load tasks.
    grunt.loadNpmTasks 'grunt-coffeelint'
    grunt.loadNpmTasks 'grunt-concurrent'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-grock'
    grunt.loadNpmTasks 'grunt-nodemon'

    # Build the project.
    grunt.registerTask 'build', 'Build the project', ->
      grunt.task.run 'build_angular'
      grunt.task.run 'build_less'
      grunt.task.run 'build_server'
      grunt.task.run 'build_templates'
      grunt.task.run 'build_vendor'

    # Build the website.
    grunt.registerTask 'build_angular', 'Compile the angular files', ->
      # Build the website.
      grunt.task.run 'coffeelint:angular'
      grunt.task.run 'copy:angular'
      grunt.task.run 'coffee:angular'

    # Build the website server.
    grunt.registerTask 'build_less', 'Compile the less files', ->
      # Generate the css file.
      grunt.loadNpmTasks 'grunt-contrib-less'
      grunt.task.run 'less'

    # Build the website server.
    grunt.registerTask 'build_server', 'Compile the server', ->
      # Check the code sanity, convert the coffef files.
      grunt.task.run 'coffeelint:server'
      grunt.task.run 'coffee:server'

      # Copy the configuration file.
      grunt.task.run 'copy:config'

    # Copy static files - index and templates.
    grunt.registerTask 'build_templates', 'Copy the templates', ->
      grunt.task.run 'copy:templates'

    # Copy vendor static files.
    grunt.registerTask 'build_vendor', 'Build the less components', ->
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