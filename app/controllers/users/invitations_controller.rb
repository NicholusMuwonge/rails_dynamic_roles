class Users::InvitationsController < Devise::InvitationsController
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected
	def after_invite_path_for(_resource)
		users_users_path
	end

	def invite_resource
		@resource_roles = Role.where(resource_id: current_user.publisher.id, resource_type: "Publisher").where.not(name: "admin")

		super do |user|
			user.publisher = current_user.publisher
			user.roles = Role.where(id: params[:role][:role_ids])&.compact_blank
			user.save
		end
	end

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:invite, keys: [:email, :role_ids])
	end
end