module Types
  class UserType < Types::BaseObject
    graphql_name "User"
    description "a user"
    
    field :id, Integer, null: false
    field :email, String, null: false
  end
end