class UsersController < ApplicationController
   before_action :set_user, only: [:edit, :update, :show]
   before_action :require_same_user, only: [:edit, :update, :destroy]
   before_action :require_admin, only: [:destroy]
   
   def index
      @users = User.paginate(page: params[:page], per_page: 10).order("updated_at DESC")
   end
   
   def new
       @user = User.new
   end
   
   def create
      @user = User.new(user_params)
      if @user.save
         session[:user_id] = @user.id
         
         flash[:success] = "Hello #{@user.username}, welcome to Wormblog!"
         
         redirect_to user_path(@user)
      else
         render 'new'
      end
   end
   
   def edit
      #@user = User.find(params[:id])
      
   end
   
   def update
      #@user = User.find(params[:id])
      if @user.update(user_params)
         flash[:success] = "Your account has been changed"
         redirect_to articles_path
      else
         render 'edit'
      end
   end
   
   def show
      #@user = User.find(params[:id])
      @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
   end
   
   def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:danger] = "User and all articles created by user have been deleted!"
      redirect_to users_path
   end
   
   def mail
      @user = User.find(params[:id])
      UserMailer.welcome_email(@user).deliver
      #SendEmailJob.set(wait: 2.seconds).perform_later(@user)
      redirect_to user_path(@user)
   end
   

   
   private
   def user_params
      params.require(:user).permit(:username, :email, :password, :avatar)
   end
   
   def set_user
      @user = User.find(params[:id])
   end
   
   def require_same_user
      if current_user != @user and !current_user.admin?
         flash[:danger] = "You can only edit your own account"
         redirect_to root_path
      end
   end
   
   def require_admin
      if (logged_in? and !current_user.admin?) || !logged_in?
         flash[:danger] = "Only admin can perform that action"
         redirect_to root_path
      end
   end
   
   def confirm_email
      user = User.find_by_confirm_token(params[:id])
      if user
         user.email_activate
         flash[:success] = "Welcome to the Sample App! Your email has been confirmed."
         redirect_to login_path
      else
         flash[:error] = "Sorry. User does not exist"
         redirect_to root_path
      end
   end
end