# アプリケーション名 ”Tricket Japan”  
日本(Japan)での旅行(Trip) ＆ やりたいことリスト(bucket list) を組み合わせた造語です。
URL: http://52.199.43.118/

## アプリケーション概要  
このサイトは、日本を旅行する予定の(または、している)外国人が、日本でやりたいことや困っていることを投稿し共有するサイトです。日本人は、その投稿に対してコメントやメッセージを送ることでアドバイスや手助けをします。日本に関心のある外国人や異文化交流をしたい日本人向けのサイトです。

## アプリケーション詳細  
まず、新規登録の際に「Traveler(主に日本への旅行者)」または「Local(主に日本人の方)」をお選びいただきます。Travelerは、日本で叶えたい夢や困っていることなどを投稿できます。Localは、その投稿に対してコメントやダイレクトメッセージでTravelerの夢のお手伝いやアドバイスをします。  
基本的な機能は下記の通りです。  
・会員登録と退会 / Tricket(叶えたい夢)の投稿(Travelerのみ可) / 動画投稿 / 投稿に対するコメント  
アプリケーションの利便性を考え下記の機能も備わっています。  
・リアルタイムでのチャット機能 ※メッセージの通知や開封未開封の表示機能も合わせて実装してあります。  
・投稿に対するいいね機能 ※非同期で実装しています。いいねした投稿一覧も確認ができます。  
・ユーザに対するフォロー機能 ※非同期で実装しています。フォローしたユーザ一覧も確認ができます。  
・ランキング機能 ※１ヶ月単位で人気のある投稿やユーザをランキング表示しています。  
・コメントや投稿に対する通知機能  
・お問い合わせ機能 ※登録メールに返事が届くように設定してあります。  
・テストコード ※RspecでModel、Controller、FeatureSpecのテストを行なっています。  

## 取り入れた技術  
### フロントエンド   
・Ajax(非同期通信)  
・JQuery  
・Bootstrap  
・GoogleMapsAPI  
### サーバサイド  
・RSpec(テストコード)  
・Actioncable(websocketによる双方向通信/1対1のリアルタイムチャット)  
・Actionmailer(お問い合わせメール)  
・carrierwave(動画や写真投稿)  
・enum(数字と値の変換)  
・rails-i18n(日本語化)  
・paranoia(ユーザと投稿の論理削除)  

## 開発環境  
ruby 2.5.5、Rails 5.2.4、Rspec 3.9

# Application Name: “Tricket Japan”  
“Tricket” is a newly made up word combining “Trip” and “Bucket list”.  
URL: http://52.199.43.118/  

## Overview  
This website is for tourists and future tourists from overseas who would like to share their dreams and experiences in Japan. In relation to the posts shared, local Japanese people can give advice through comments or messages. It also creates opportunities for culture exchange.  

## Usage  
The first step to enjoy this website is you choose your user type from “Traveler (mainly for foreigners)” or “Local (mainly for the Japanese)”.  As a traveler, you can post your dreams, we call them “Tricket”, and troubles you experience in Japan. As a local, you check the Trickets and help Travelers through comments and messages.  
Basic functions are:  
registration and unsubscription / post your dream / post with a video / comment to the post.  
To enhance the user experience, there are more functions below:  
・Real time chatting  
・Ability to like posts  
・Ability to follow users  
・Favorite posts and users ranking  
・Notifications for comments, posts and messages  
・Contacts to the administrator  

## Techniques  
Front-end: Ajax / JQuery / bootstrap / GoogleMapsAPI    
Server side: RSpec / Actionmailer / Actionable / carrierwave / enum / rails-i18n / paranoia  

## Development Environment  
ruby 2.5.5、Rails 5.2.4、Rspec 3.9  
