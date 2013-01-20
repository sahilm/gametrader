module Api
  class GamesController < ApplicationController
    respond_to :json
    def index
      respond_with ['Maharashtra', 'Madhya Pradesh', 'Andhra Pradesh', 'Himachal Pradesh']
    end
  end
end
