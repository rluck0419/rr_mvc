class UsersController < ApplicationController
  def show
    if user_exists?
      render User.all[user_id].to_json
    else
      render_not_found
    end
  end

  def delete
    if user_exists?
      User.delete_from_all(user_id)
      render({ msg: "200 - user #{params[:id]} deleted"}.to_json, status: "200 OK")
    else
      render_not_found
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

  private

  def user_exists?
    (1..User.all.count).include?(params[:id].to_i)
  end

  def user_id
    params[:id].to_i - 1
  end

  def render_not_found
    render({ msg: "404 - not found" }.to_json, status: "404 NOT FOUND")
  end
end
