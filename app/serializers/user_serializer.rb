class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :address, :phone_no, :role, :d_license_no, :password
end
