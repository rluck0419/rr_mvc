class UsersController < ApplicationController
  def show
    if (1..User.all.count).include?(params[:id].to_i)
      index = params[:id].to_i - 1
      render User.all[index].to_json
    else
      render({ msg: "404 - not found" }.to_json, status: "404 NOT FOUND")
    end
  end

  def delete
    if (1..User.all.count).include?(params[:id].to_i)
      index = params[:id].to_i - 1
      render User.all[index].to_json
      # render({ msg: "200 - user deleted"}.to_json, status: "200 OK")
    else
      render({ msg: "404 - not found" }.to_json, status: "404 NOT FOUND")
    end
  end

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

    render users[offset..limit].to_json
  end
end
