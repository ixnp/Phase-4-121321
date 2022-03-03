class ProductionSerializer < ActiveModel::Serializer
  attributes :title, :genre, :description, :image, :budget, :ongoing

  has_many :production_roles
  has_many :users

  def budget
    "$#{'%.2f' % object.budget}"
  end 

  def ongoing
    object.ongoing ? "Activley Showing" : "No Showing"
  end 
end
