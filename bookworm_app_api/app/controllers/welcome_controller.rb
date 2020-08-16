class WelcomeController < ApplicationController
    def index
        render json: { status: 200, message: "Bookworm API" }
    end
end
