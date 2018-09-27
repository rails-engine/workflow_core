# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    session[:current_user_id] = params[:user_id]
    redirect_back fallback_location: root_url
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_url
  end
end
