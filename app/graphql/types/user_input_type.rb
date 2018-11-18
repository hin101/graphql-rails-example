module Types
  class UserInputType < Types::BaseInputObject
    graphql_name "UserInputType"
    description "Properties for registering a new User"

    argument :email, String, required: false
    argument :password, String, required: false
  end
end