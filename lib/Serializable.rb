require 'yaml'

module Serializable
  @@serializer = YAML

  def unserialize(string)
    obj = @@serializer.load(string)
    obj.each do |key, value|
      instance_variable_set(key, value)
    end
    puts 'Game Loaded'
  end
end
