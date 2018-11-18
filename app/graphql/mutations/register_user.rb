module Mutations
  class RegisterUser < Mutations::BaseMutation
    null true
    graphql_name "RegisterUser"
    argument :registration_details, Types::UserInputType, required: true

    type Types::UserType

    def resolve(registration_details:)
      input = Hash[registration_details.to_h.map { |k,v| [k.to_s.underscore.to_sym, v]}]
      begin
        @user = User.create!(input)
      rescue ActiveRecord::RecordInvalid => invalid
        GraphQL::ExecutionError.new("Invalid Attributes for #{invalid.record.class.name}: #{invalid.record.errors.full_messages.join(', ')}")
      end
      input
    end
  end
end