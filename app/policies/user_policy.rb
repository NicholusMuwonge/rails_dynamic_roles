class UserPolicy < ApplicationPolicy
	class Scope < Scope
    def resolve
      if user.user?
        scope.all
      end
    end
  end

  def index?
    user.has_role?(:admin, user&.publisher) or has_permissions("view_users")
  end

	private

	def has_permissions(permission)
		user.permissions.exists?(name: permission)
	end
end