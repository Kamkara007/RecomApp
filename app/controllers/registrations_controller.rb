class RegistrationsController < ApplicationController
  include Wicked::Wizard

  steps :step1, :step2, :step3

  def show
    @user = current_user || User.new
    render_wizard
  end

  def create
  @user = User.new(user_params)
  if @user.save
    @user.invite! # generates the invitation link
    sign_in(@user)
    redirect_to wizard_path(steps.first)
  else
    puts @user.errors.full_messages
    render_wizard @user
  end
end




  def update
    @user = current_user
    @user.attributes = user_params
    render_wizard @user
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :city_name, :school_name, :contact_1, :contact_2, :role_name, :password, :password_confirmation)
  end

  def finish_wizard_path
    root_path
  end
end
