module Types
  class AuthType < Types::BaseObject
    graphql_name "AuthType"
    description "Auth type"
    
    field :authentication_token, String, null: false
  end
end