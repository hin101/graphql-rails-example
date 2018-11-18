module Mutations
  class SignInUser < Mutations::BaseMutation
    null true
    graphql_name "SignInUser"
    argument :email, String, required: true
    argument :password, String, required: true

    type Types::UserType

    def resolve(email:, password:)
      @user = User.find_for_database_authentication(email: email)
      if @user.present? && @user.valid_password?(password)
        update_user_token(@user) unless @user.authentication_token.present?
        return OpenStruct.new(authentication_token: @user.authentication_token)
      else
        GraphQL::ExecutionError.new('Incorrect Email/Password')
      end
      @user
    end

    private

    def update_user_token(user)
      user.update_attributes(authentication_token: SecureRandom.uuid)
    end
  end
end