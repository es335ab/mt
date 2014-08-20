# Middleman & Grunt Env

##Usage

### Grobal install

```sh
gem install bundler
gem install middleman
npm install -g grunt-cli
```

### Local install

```sh
bundle install
npm install
```

### middleman server

```sh
bundle exec middleman server
```

- 動的にファイル生成して`localhost:4567`で確認することができる

### middleman build

```sh
bundle exec middleman build
```

- 静的html,css,jsを`build/`にビルドすることができる

### grunt watch

```sh
grunt watch
```

- `/source/img/sprite/*.png`の画像ファイルを監視して、変更があったら自動で`/source/img/sprite.png`の生成と`/source/css/var/_sprite.scss`の生成を行う

- `/source/js/common/*.js`の変更を監視して、変更があったら、common以下のjsを結合して`/source/js/common.js`を生成する

- `jshint`によるjsの構文チェックを行う

### grunt build

```sh
grunt build
```

- `/build/`以下のhtml整形、不要ファイル削除、jsの圧縮など本番delpoy用の細かいタスクを行う