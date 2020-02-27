class AuthenticationController < ApplicationController

    def login
        @user = User.find_by( username: params[:user][:username] )

        if @user
            
            if @user.authenticate(params[:user][:password])

                payload = { id: @user.id }
                secret = Rails.application.secret_key_base
                token = JWT.encode(payload, secret)
                render json: { token: token, user_id: @user.id }

            else
                render json: { error: "nice try asshole" }, status: :unauthorized
            end

        else
            render json: { error: "nice try asshole" }, status: :unauthorized
        end
    end

end