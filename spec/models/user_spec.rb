require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'nicknameが空だと登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'emailに一意性がないと登録できない' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'メールアドレスは、@を含まないと登録できない' do
      @user.email = 'example.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
    it 'passwordが空だと登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'passwordが5文字以下であれば登録できない' do
      @user.password = 'aaaaa'
      @user.password_confirmation = 'aaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it 'パスワードは、半角英字だけでは登録できない' do
      @user.password = '111111'
      @user.password_confirmation = '111111'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password Password Include both letters and numbers')
    end
    it 'パスワードは、全角では登録できない' do
      @user.password = 'ａａａａａａ'
      @user.password_confirmation = 'ａａａａａａ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password Password Include both letters and numbers')
    end
    it 'passwordとpassword_confirmationが不一致では登録できない' do
      @user.password = '123456'
      @user.password_confirmation = '1234567'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'family_nameがない場合は登録できないこと' do
      @user.family_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name can't be blank", 'Family name is invalid')
    end
    it 'first_nameがない場合は登録できないこと' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank", 'First name is invalid')
    end
    it 'family_nameが全角入力でなければ登録できない' do
      @user.family_name = 'wwwww'
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name is invalid')
    end
    it 'first_nameが全角入力でなければ登録できない' do
      @user.first_name = 'wwwww'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid')
    end
    it 'family_nameは全角（漢字・ひらがな・カタカナ）での入力でなければ登録できない' do
      @user.family_name = "\bＡＡＡＡＡ"
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name is invalid')
    end
    it 'first_nameは全角（漢字・ひらがな・カタカナ）での入力でなければ登録できない' do
      @user.first_name = "\bＡＡＡＡＡ"
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid')
    end
    it 'family_name_kanaがない場合は登録できないこと' do
      @user.family_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana can't be blank", 'Family name kana is invalid')
    end
    it 'first_name_kanaがない場合は登録できないこと' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank", 'First name kana is invalid')
    end
    it 'family_name_kanaが全角(カタカナ)入力でなければ登録できない' do
      @user.family_name_kana = 'ｱｲｳｴｵ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name kana is invalid')
    end
    it 'first_name_kanaが全角(カタカナ)入力でなければ登録できない' do
      @user.first_name_kana = 'ｱｲｳｴｵ'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana is invalid')
    end
    it '生年月日がない場合は登録できない' do
      @user.birth_day = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth day can't be blank")
    end

    it '新規登録できる' do
      expect(@user).to be_valid
    end
  end
end
