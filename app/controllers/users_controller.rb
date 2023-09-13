class UsersController < ApplicationController
  # before_action :show_splash_screen

  def index; end


  # def show_splash_screen
  #   # Skip the splash screen logic if the user is authenticated or if we are on a Devise controller action
  #   return if user_signed_in? || devise_controller?

  #   session[:splash_screen_shown] ||= false
  #   @show_splash_screen = !session[:splash_screen_shown]
  #   session[:splash_screen_shown] = true unless session[:splash_screen_shown]
  #   puts "show_splash_screen executed. @show_splash_screen: #{@show_splash_screen}"
  # end
end
