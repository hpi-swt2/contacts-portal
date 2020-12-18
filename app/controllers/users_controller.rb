class UsersController < ApplicationController
  before_action :authorize, except: %i[show index add_contact search]

  def show
    @user = User.find(params[:id])
  end

  def edit; end

  def update
    return render :edit unless @user.update(user_params)

    redirect_to @user
  end

  def update_status
    @user.current_status = params[:user][:current_status]
    @user.save
    redirect_to @user
  end

  def index
    @users = User.all
  end

  def add_contact
    authenticate_user!
    current_user.contacts << User.find(params[:id])
    current_user.save
    redirect_to home_index_path
  end

  def search
     if params[:q].blank?
        @results = User.all
     else
        search_pattern = params[:q].downcase
        @results = []
        User.all.each do |user|

           if user.user_identifier.include? search_pattern
              @results << user
           end
        end
     end
  end

  private

  def user_params
    params.require(:user).permit(:username, :firstname, :lastname, :birthdate, :place_of_residence)
  end

  def authorize
    authenticate_user!
    if current_user.id.to_s == params[:id]
      @user = current_user
    else
      redirect_to root_path
    end
  end
end
