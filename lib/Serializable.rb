require 'json'

module Serializable
  def serialize
    obj = {}
    instance_variables.map do |var|
      obj[var.to_s] = instance_variable_get(var)
    end
    JSON.dump obj
  end

  def unserialize(string)
    obj = JSON.parse(string)
    obj.each do |key, value|
      instance_variable_set(key, value)
    end
  end
end
