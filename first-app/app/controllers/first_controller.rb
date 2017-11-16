# frozen_string_literal: true

class FirstController < ApplicationController
  protect_from_forgery with: :exception

  def hello; end
end
