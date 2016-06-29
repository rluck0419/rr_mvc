class UsersController < ApplicationController
  def index
    render User.all.to_json
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
