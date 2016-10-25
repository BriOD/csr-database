class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :name, :home_phone, :cell_phone, :work_phone,
             :notes, :active, :email, :account_number

  has_one :address_book

  has_one :webspace
  has_one :company
  has_one :lease
end
