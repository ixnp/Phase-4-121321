class TicketSerializer < ActiveModel::Serializer
  attributes :id, :user, :production, :price

  # belongs_to :user
  # belongs_to :production

  def user
    object.user.name
  end 

  def production
    object.production.title
  end 


end
