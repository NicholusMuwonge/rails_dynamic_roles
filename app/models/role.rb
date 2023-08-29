class Role < ApplicationRecord
  attr_accessor :permission_ids_input
  
  has_and_belongs_to_many :users, :join_table => :users_roles
  has_and_belongs_to_many :permissions, join_table: "roles_permissions"
  accepts_nested_attributes_for :permissions
  before_validation :assign_permissions_from_input, on: :create
  before_validation :normalize_name
  
  belongs_to :resource,
             :polymorphic => true,
             :optional => true
  

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  validates :name, presence: true
  validates :name, uniqueness: { scope: [:resource_type, :resource_id], message: "Role already exists for this resource" } 
  validate :at_least_one_permission
  scopify

  private

  def assign_permissions_from_input
    self.permission_ids = permission_ids_input&.reject(&:blank?) if permission_ids_input.present?
  end

  def at_least_one_permission
    errors.add(:base, 'At least one permission is required') if permissions.empty?
  end

  def normalize_name
    self.name = normalize_string(name)
  end

  def normalize_string(str)
    str.downcase.gsub(/[^a-z0-9]/, '_')
  end

end
