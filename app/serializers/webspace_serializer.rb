class WebspaceSerializer < ActiveModel::Serializer
  attributes :id, :active, :url, :username, :password
end
