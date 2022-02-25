# Phase-4-112221

# Serializers
- [] Implement Active Model Serializer  
- [] Create custom serializers 
- [] Format data with serialization
- [] Create custom validations


### Deliverables 
- [] Add serializer for Production 
- [] Add serializer for Ticket
- [] Add custom validation

### Domain
![domain_2](assets/domain_2.png)

### Active Model Serializer
[Docs](https://learn.co/lessons/using-active-model-serializer)

Instead of handing serialization in the controller we want to practice a separation of concerns and isolate the responsibility of serialization.

```
# Gemfile
gem 'active_model_serializers'

# generate serializer 
# rails g serializer model_name

rails g serializer production 

# serializer/production_serializer
# specific attributes can be selected 
class ProductionSerializer < ActiveModel::Serializer
  attributes :title, :genre, :description, :image, :director
end


# serializer/production_serializer
# attributes can be formatted  
class ProductionSerializer < ActiveModel::Serializer
  attributes :title, :genre, :description, :image, :director, :budget, :ongoing

  def budget
    "$#{'%.2f' % object.budget}"
  end 
  
  def ongoing
    object.ongoing ? "Actively Showing": "Not Showing"
  end 
end

# serializer/production_serializer
# one-to-many associations can also be added
# Note - the related serializer must exist. The data will be formatted according to the related serializer.

class ProductionSerializer < ActiveModel::Serializer
  attributes :title, :genre, :description, :image, :director, :budget, :ongoing

  has_many :production_roles

  
  def budget
    "$#{'%.2f' % object.budget}"
  end 
  
  def ongoing
    object.ongoing ? "Actively Showing": "Not Showing"
  end 
end
# serializer/production_role_serializer

class ProductionRoleSerializer < ActiveModel::Serializer
  attributes :role, :understudy
end

#serializer/user_serializer
# Many-to-many 
# both the has_many and the has_many through associations can be added with a has_many

class UserSerializer < ActiveModel::Serializer
  attributes :name, :email, :admin
  has_many :tickets
  has_many :productions
end

```


