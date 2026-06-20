require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @order_address = OrderAddress.new(
      user_id: 1,
      item_id: 1,
      postal_code: '123-4567',
      prefecture_id: 2,
      city: '横浜市緑区',
      street_address: '青山1-1-1',
      building_name: 'テストビル101',
      phone_number: '09012345678',
      token: 'tok_abcdefghijk00000000000000000'
    )
  end

  describe '商品購入機能' do
    context '購入できる場合' do
      it 'すべての項目が正しく入力されていれば購入できる' do
        expect(@order_address).to be_valid
      end

      it '建物名が空でも購入できる' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end

    context '購入できない場合' do
      it 'user_idが空では購入できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空では購入できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'postal_codeが空では購入できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeにハイフンがなければ購入できない' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include(
          'Postal code is invalid. Include hyphen(-)'
        )
      end

      it 'prefecture_idが1では購入できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include(
          "Prefecture can't be blank"
        )
      end

      it 'cityが空では購入できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end

      it 'street_addressが空では購入できない' do
        @order_address.street_address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include(
          "Street address can't be blank"
        )
      end

      it 'phone_numberが空では購入できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include(
          "Phone number can't be blank"
        )
      end

      it 'phone_numberが9桁以下では購入できない' do
        @order_address.phone_number = '090123456'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include(
          'Phone number is invalid'
        )
      end

      it 'phone_numberが12桁以上では購入できない' do
        @order_address.phone_number = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include(
          'Phone number is invalid'
        )
      end

      it 'phone_numberにハイフンが含まれていると購入できない' do
        @order_address.phone_number = '090-1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include(
          'Phone number is invalid'
        )
      end

      it 'tokenが空では購入できない' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
