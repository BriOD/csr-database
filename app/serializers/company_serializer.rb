class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :contact_first_name, :contact_last_name, :contact_email,
             :billing_email, :main_number, :contact_number, :fax

  has_one :company_address
end
