class HomeController < ApplicationController
  def index
   redirect_to '/registrations/step1', if: :user_signed_in?
  end
end
