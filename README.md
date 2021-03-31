<img src="https://user-images.githubusercontent.com/75315945/112314914-e9f12e80-8cec-11eb-958c-3b6ea72093c2.jpg" height='400px' width='800px' ><br>
# 筋トレノート

## サイト概要
日々、筋トレに取り組む方のためのトレーニングメモアプリです。
トレーニングメモを残すことで過去の自分と比較でき、成長を実感することができます。
また、フォローや投稿をしあって、筋トレ好きの方専用のtwitterのような機能も利用できます。

### サイトテーマ
筋トレの記録管理アプリ

### テーマを選んだ理由
自分自身が筋トレをする中で、過去の記録を残しておけばよかったと後悔する場面があったため。
また筋トレは、孤独で取り組むことになりやすい趣味であるため、オンライン上で一緒に頑張れる仲間を見つけれるサービスが欲しいと考えたため。

### ターゲットユーザ
筋トレをしている方で、
- トレーニング記録をつけたい方
- トレーニング仲間を見つけたい方
- 他人と比較して、モチベーションを上げたい方

### 主な利用シーン
筋トレをしながら、または終了後に、筋トレの記録をつける。（トレーニング内容、重量、レップ数など）
その後、過去の記録とグラフ等で比較することができる。
筋トレをしていない間は、筋トレ仲間の投稿を確認し、コメント、いいねができ、モチベーションを高めることができる。

## 設計書
https://docs.google.com/spreadsheets/d/1t7K17X6HNCsj48rDtXkXmgfKzulH1kwg3vDJ6xQfhuc/edit#gid=977420151

## 機能一覧
https://docs.google.com/spreadsheets/d/1T2MHI2li78aAp1b7PUX8FgoAmNYtAM0lBq5I6AHS8G8/edit#gid=0

## 使用方法

### インストール
$ git clone git@github.com:akf38/kintore_note.git (SSH)<br>
or <br>
$ git clone https://github.com/akf38/kintore_note.git (HTTPS) <br>
$ cd kintore_note <br>
$ bundle install<br>
$ rails db:migrate<br>
$ rails db:seed<br>
$ rails s <br>

### テスト
ターミナル（もしくはコマンドプロンプト）で上記の作業を行った後、ローカルサーバーにアクセスしてご覧ください。

【ゲストユーザーログイン機能があります。】 <br>
新規登録画面、ログイン画面の下部リンク 'ゲストユーザーはこちら>>'をご利用ください。<br>
（登録画面にて新規登録も可能です。）<br>
※一部SNSでのログイン機能は、本番環境での動作も確認できておりますが、現状開発者自身のアカウント以外でのログインが不可能である場合がございます。<br>
SNS連携でのログインに失敗された方は、お手数ですがゲストユーザーリンクか新規登録をお試しいただけますと幸いです。
## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## Gem
・devise 
・refile
・refile
・refile-mini_magick
・jquery-rails
・font-awesome-sass
・bootstrap
・dotenv-rails
・kaminari
・chartkick
・groupdate
・simple_calendar
・acts-as-taggable-on
・jquery-ui-rails
・omniauth-facebook
・omniauth-twitter
・omniauth-google-oauth2
・omniauth
・bullet
・devise-i18n
・devise-i18n-views
・rails-i18n
・faker
・factory_bot_rails

## 作成者
[akf38](https://github.com/akf38)