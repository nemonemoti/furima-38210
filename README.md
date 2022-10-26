# テーブル設計

## users テーブル

| Column             | Type   | Options     |  
| ------------------ | ------ | ----------- |
| nickname           | string | null:false  |  
| email              | string | null:false  |  
| encrypted_password | string | null: false |  
| first_name         | string | null: false |  
| family_name        | string | null: false |  
| first_name_kana    | string | null: false |  
| family_name_kana   | string | null: false |  
| birth_day          | date   | null: false |  

## Association  

-has_many :items  
-has_many :orders  

## items テーブル  

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| product_name         | string     | null: false                    |  
| product_detail       | text       | null: false                    |  
| category_id          | integer    | null: false                    |  
| product_condition_id | integer    | null: false                    |  
| delivery_fee_id      | integer    | null: false                    |  
| area_id              | integer    | null: false                    |  
| days_to_ship_id      | integer    | null: false                    |  
| price                | integer    | null: false                    |  
| user                 | references | null: false, foreign_key: true |  

## Association  

-belongs_to :user  
-has_one :order  

## orders テーブル  

| Column | Type       | Options                        | 
| ------ | ---------- | ------------------------------ | 
| user   | references | null: false, foreign_key: true |  
| item   | references | null: false, foreign_key: true |  

## Association  

-belongs_to :user  
-belongs_to :item  
-has_one :shipping_address  

## shipping_address テーブル  

| Column        | Type       | Options                        |  
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |  
| area_id       | integer    | null: false                    |  
| municipality  | string     | null: false                    |  
| address       | string     | null: false                    |  
| building_name | string     |                                |  
| phone_number  | string     | null: false                    |  
| order         | references | null: false, foreign_key: true |  

## Association  

-belongs_to :order  