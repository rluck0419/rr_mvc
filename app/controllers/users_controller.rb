class UsersController < ApplicationController
  def index
    users = User.all

    if params[:first_name]
      users = []
      User.all.each do |user|
        if user.first_name[0].downcase == params[:first_name]
          users << user
        end
      end
    end

    offset = 0
    if params[:offset]
      offset = params[:offset].to_i
    end
    
    limit = -1
    if params[:limit]
      limit = params[:limit].to_i - 1
      limit += offset
    end

    users_displayed = users[offset..limit]

    render users_displayed.to_json
  end

  def show
    if (1..User.all.count).include?(params[:id].to_i)
      index = params[:id].to_i - 1
      render User.all[index].to_json
    else
      render({ msg: "404 - not found" }.to_json, status: "404 NOT FOUND")
    end
  end
end
