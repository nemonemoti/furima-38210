require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = user
    item = item
    @order_address = FactoryBot.build(:order_address, user_id: 2, item_id: 2)
  end

  describe '商品購入機能' do
    it '全ての項目が入力されていれば購入ができる' do
      expect(@order_address).to be_valid
    end
    it 'building_nameが空でも購入できる' do
      @order_address.building_name = nil
      expect(@order_address).to be_valid
    end

    it 'token(クレジットカード情報)が空だと購入ができない' do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end
    it '郵便番号が空だと購入ができない' do
      @order_address.postal_code = ''
      @order_address.valid?
      expect(@order_address.errors.messages).to include postal_code: ["can't be blank", 'is invalid']
    end
    it '郵便番号にハイフンがないと登録できない' do
      @order_address.postal_code = '12345678'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postal code is invalid')
    end
    it 'area_idが空だと購入できない' do
      @order_address.area_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Area can't be blank")
    end
    it 'area_idが選択されていないと購入できない' do
      @order_address.area_id = 1
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Area must be other than 1')
    end
    it 'municipalityが空だと購入できない' do
      @order_address.municipality = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Municipality can't be blank")
    end
    it 'addressが空だと購入できない' do
      @order_address.address = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Address can't be blank")
    end
    it 'phone_numberが空だと購入できない' do
      @order_address.phone_number = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number can't be blank", 'Phone number is invalid')
    end
    it 'phone_numberは数字のみでないと（ハイフンが含まれていると）購入できない' do
      @order_address.phone_number = '123-4567891'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is invalid')
    end
    it 'phone_numberが11桁でなければ購入できない' do
      @order_address.phone_number = '080123456789'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is invalid')
    end
  end
end