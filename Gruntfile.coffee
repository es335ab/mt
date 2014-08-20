module.exports = (grunt) ->
  # 時間計測
  require('time-grunt') grunt
  # プラグイン動的ロード
  require('jit-grunt') grunt,
    jscs: 'grunt-jscs-checker'
    sprite: 'grunt-spritesmith'

  basepath = grunt.option('basepath') || ''

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

  # パス設定
    path:
      src: 'source'
      data: 'data'
      build: 'build'

  # 不要ファイル削除
    clean:
      build: ['<%= path.build %>/img/sprites/**', '<%= path.build %>/html/**']

  # ここからbuildタスク

  # ファイルをコピー
    copy:
      main:
        expand: true
        cwd: '<%= path.build %>/html/'
        src: [
          '*.html'
        ]
        dest: '<%= path.build %>'

  # HTML整形
    prettify:
      options:
        indent: 1
        indent_char: '\t'
      prettify:
        expand: true
        cwd: '<%= path.build %>'
        src: '*.html'
        dest: '<%= path.build %>'

  # JS縮小化
    uglify:
      options:
        preserveComments: require 'uglify-save-license'
        report: 'min'
      min:
        expand: true
        cwd: '<%= path.build %>'
        src: [
          '**/*.js'
          '!**/*.min.js'
          '!js/lib/*.js'
        ]
        dest: '<%= path.build %>'

  # ここからwatchタスク

  # JS結合
    concat:
      dist:
        src: '<%= path.src %>/js/common/*.js'
        dest: '<%= path.src %>/js/common.js'

  # JS静的構文チェック
    jshint:
      options:
        jshintrc: '.jshintrc'
      src: [
        '<%= path.src %>/**/*.js'
        '!<%= path.src %>/js/lib/*.js'
      ]

  # 画像スプライト化
    sprite:
      create:
        src: '<%= path.src %>/img/sprites/*'
        destImg: '<%= path.src %>/img/sprite.png'
        destCSS: '<%= path.src %>/css/var/_sprite.scss'
        imgPath: '../img/sprite.png'
        algorithm: 'binary-tree'
        engine: 'pngsmith'

  # ファイル変更監視
    watch:
      options:
        spawn: false
      concat:
        files: ['<%= path.src %>/js/common/*.js']
        tasks: ['concat']
      js:
        options:
          livereload: false
        files: ['<%= path.src %>/**/*.js']
        tasks: ['jshint']
      sprite:
        files: ['<%= path.src %>/img/sprites/*']
        tasks: ['sprite']


  # タスク定義
  grunt.registerTask 'build', ['copy', 'prettify', 'concat', 'jshint', 'sprite', 'clean']
