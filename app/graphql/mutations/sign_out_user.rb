module Mutations
  class SignOutUser < Mutations::BaseMutation
    null true
    graphql_name "SignOutUser"
    argument :email, String, required: true
    argument :authentication_token, String, required: true

    type Types::UserType

    def resolve(email:, authentication_token:)
      user = User.find_for_database_authentication(email: email, authentication_token: authentication_token)
      if user.present?
        user.update_attributes!(authentication_token: nil)
      else
        GraphQL::ExecutionError.new('User not found')
      end
      user.attributes
    end
  end
end