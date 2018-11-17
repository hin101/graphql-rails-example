module Types
  class ProjectType < Types::BaseObject
    graphql_name "Project"
    description "a project"
    
    field :id, Integer, null: false
    field :title, String, null: true
    field :user, UserType, null: false

    def title
      "#{object.user.email}-#{object.title}"
    end
  end
end