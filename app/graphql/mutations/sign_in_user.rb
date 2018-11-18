module Mutations
  class SignInUser < Mutations::BaseMutation
    null true
    graphql_name "SignInUser"
    argument :email, String, required: true
    argument :password, String, required: true

    type Types::UserType

    def resolve(email:, password:)
      user = User.find_for_database_authentication(email: email)
      if user.present? && user.valid_password?(password)
        user.ensure_authentication_token
        user.save
      else
        GraphQL::ExecutionError.new('Incorrect Email/Password')
      end
      user.attributes
    end
  end
end