class ApplicationController < ActionController::API

    def authenticate_token
        # puts "AUTHENTICATE JWT"
        render json: { status: 401, message: 'Unauthorized' } unless decode_token(bearer_token)
    end
  
    def bearer_token
        # puts "BEARER TOKEN"
        header = request.env["HTTP_AUTHORIZATION"]

        pattern = /^Bearer /
        # puts "TOKEN WITHOUT BEARER"
        header.gsub(pattern, '') if header && header.match(pattern)
    end
  
    def decode_token(token_input)
        # puts "DECODE TOKEN, token input: #{token_input}"
        # token =
        JWT.decode(token_input, ENV['JWT_SECRET'], true)
        # render json: { decoded: token }
    rescue
        render json: { status: 401, message: 'Unauthorized' }                          
    end

    def get_current_user 
        return if !bearer_token   
        decoded_jwt = decode_token(bearer_token) 
        User.find(decoded_jwt[0]["user"]["id"])
    end 

    def authorize_user
        render json: { status: 401, message: "Unauthorized" } unless get_current_user.id == params[:id].to_i       
    end

    # delete if error occurs
    def session_user
        decoded_hash = decoded_token
        if !decoded_hash.empty?
            user_id = decoded_hash[0]['user_id']
            @user = User.find_by(id: user_id)
        else
            nil
        end
    end
    # 
  
  end