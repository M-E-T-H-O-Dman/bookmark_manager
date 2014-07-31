get '/users/new' do 
    @user = User.new
    erb :"users/new"
end    

post '/users' do 
   @user = User.new(:email => params[:email],
        :password => params[:password],
        :password_confirmation => params[:password_confirmation])
    if @user.save
    session[:user_id] = @user.id 
    redirect to ('/')
    else
        flash.now[:errors] = @users.errors.full_messages
        erb :"users/new"
    end    
end

get '/users/forgottenpassword' do 
    erb :"users/forgottenpassword"
end 

post '/users/recover' do
    @forgetful_user = User.first(email: params[:email])

    if @forgetful_user
    generate_password_token(params[:email])
    flash[:notice] = "We have sent a reset token to #{params[:email]}"
    redirect to ('/')

    else 
    flash[:notice] = "I'm sorry, we could not find that email address in our database"
    end
end  

# get "/users/reset_password/:token" do 
# user = User.first(:password_token => token)
#     erb :users/forgottenpassword/:token
# end

def generate_password_token(email)
user = User.first(:email => email)
# avoid having to memorise ascii codes
user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
user.password_token_timestamp = Time.now
user.save
end  