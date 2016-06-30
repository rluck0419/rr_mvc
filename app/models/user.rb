require 'faker'

class User
  @@all = []
  attr_accessor :first_name, :last_name, :id, :age

  def initialize(first_name, last_name, id, age)
    @@all << self
    @first_name = first_name
    @last_name = last_name
    @id = id
    @age = age
  end

  def to_json(json_arg = nil)
    {
      first_name: @first_name,
      last_name: @last_name,
      id: @id,
      age: @age
    }.to_json
  end

  def self.all
    @@all
  end

  def self.delete_from_all(index)
    @@all.delete_at(index)
  end
end

20.times do |i|
  User.new(Faker::Name.first_name, Faker::Name.last_name, (i+1).to_s, rand(18..50).to_s)
end

User.new("Samuel", "Smithington", "21", "80")
