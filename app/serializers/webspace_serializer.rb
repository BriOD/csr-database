class WebspaceSerializer < ActiveModel::Serializer
  attributes :id, :active, :url, :username, :password
  
  belongs_to :customer
end
