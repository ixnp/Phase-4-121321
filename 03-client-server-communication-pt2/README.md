# Phase-4-112221

# Client Server Communication pt2
## SWBAT
- [] handle validations in the controller
- [] Use strong params
- [] Implement a destroy route
- [] Implement an update route
- [] handle foreign key restraint errors  

### Deliverables 
- [] Add Create to Production 
- [] Add Update and Delete to user 
- [] Add Full CRUD to Ticket

### Domain
![domain_2](assets/domain_2.png)

### wrapped_parameters 
Instead of putting `wrap_parameters format: []` at the top of each controller we can remove them from each controller by moving `wrap_parameters format: []` to our config
```
#config/initializers/wrap_parameters.rb
ActiveSupport.on_load(:action_controller) do
  wrap_parameters format: []
end

```

### Dry Error handling 

We can dry up our error handling by using a method in rails called `rescue_from`.

```
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    private
    def render_not_found(error)
        byebug
        render json: {error: "#{error.model}NOT FOUND :("}, status: :not_found
    end 


    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end


```

### Custom validations 
Custom validations can be added alongside our built in validators. They begin with the keyword `validate` and are given a custom method. 

```
validate :must_have_gmail 

def must_have_gmail
  unless email.match?(/gmail.com/)
    errors.add(:email, "Please used  our preferred email gmail.com")
  end
end 

```


### dependencies
Rails prevents you from deleting resources if other resources depend on them. 

For example, Ticket holds a Foreign key for Production and User. If we try to `.destroy` a user with one or more associated tickets we will get the following error. 

```
"#<ActiveRecord::InvalidForeignKey: SQLite3::ConstraintException: FOREIGN KEY constraint failed>"

```

There are two ways to deal with this. 
- If you don't need the dependencies. Destroy the foreign key dependencies when you destroy a resource.  

```
   has_many :user, dependent: :delete
  # or
   has_many :user, dependent: :destroy

```
- If you need to keep the dependencies. Force the foreign key to null using nullify. 

```
  has_many :user, dependent: :nullify
```

### Delete 
To delete a resource:
  - find the resource
  - destroy the resource
    - Confirm it had no foreign key dependencies issues
  - return a response with no content 
  - handel for errors 
```
 def destroy 
        user = User.find(params[:id])
        user.destroy
        head :no_content  
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors }, status: :not_found
  end 

```

### Update
To Update a resource:
- find the resource 
- use strong params to access the updated params
- update the resource 
- handle validation errors
- return a response with the updated resource 

```
  def update
        user = User.find(params[:id])
        user.update!(user_params)
        render json: user, status: :ok
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors }, status: :not_found
    end 


```