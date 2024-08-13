require 'json'

module Serializable
  def serialize
    obj = {}
    instance_variables.each do |var|
      value = instance_variable_get(var)
      obj[var.to_s.delete('@')] = value.respond_to?(:to_hash) ? value.to_hash : value
    end
    JSON.dump(obj)
  end

  def unserialize(string)
    obj = JSON.parse(string)
    obj.each do |key, value|
      instance_variable_set("@#{key}", unserialize_value(value))
    end
  end

  private

  def unserialize_value(value)
    if value.is_a?(Hash) && value['class']
      klass = Object.const_get(value['class'])
      obj = klass.new
      obj.from_hash(value['data'])
      obj
    else
      value
    end
  end
end
