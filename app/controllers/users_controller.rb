class UsersController < ApplicationController
  def index
    if params[:first_name].nil? && params[:limit].nil? && param[:offset].nil?
      render User.all.to_json

    elsif params[:limit].nil? && params[:offset].nil?
      first_names = []
      User.all.each do |user|
        if user.first_name[0].downcase == params[:first_name]
          first_names << user
        end
      end
      render first_names.to_json

    elsif params[:first_name].nil?
      users = User.all
      params[:offset].to_i.times do |i|
        users.shift
      end
      while users.count > params[:limit].to_i
        users.pop
      end
      render users.to_json
    end
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
