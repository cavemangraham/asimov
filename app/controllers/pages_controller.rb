class PagesController < ApplicationController
  before_action :authenticate_player!, :except => [:landing]

  def landing
  end
  def admin
  end
end
