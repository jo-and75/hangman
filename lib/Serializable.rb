require 'json'

module Serializable
  def serialize
    obj = {}
    instance_variables.map do |var|
      value = instance_variable_get(var)
      obj[var.to_s] = value.respond_to?(:to_hash) ? value.to_hash : value
    end
    JSON.dump obj
  end

  def unserialize(string)
    obj = JSON.parse(string)
    obj.each do |key, value|
      instance_variable_set(key, unserialize(value))
    end
  end

  private

  def unserialize_value(value)
    if value.is_a?(Hash)
      klass = Object.const_get(value['class']) # Assumes the hash contains a 'class' key with class name
      obj = klass.new
      obj.from_hash(value)
      obj
    else
      value
    end
  end
end
