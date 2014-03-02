require 'luchadeer/resource'

module Luchadeer

  Accessory = Class.new(Resource) do
    const_set "SINGULAR",    :accessory
    const_set "PLURAL",      :accessories
    const_set "RESOURCE_ID", 3000
  end

  Character = Class.new(Resource) do
    const_set "SINGULAR",    :character
    const_set "PLURAL",      :characters
    const_set "RESOURCE_ID", 3005
  end

  Company = Class.new(Resource) do
    const_set "SINGULAR",    :company
    const_set "PLURAL",      :companies
    const_set "RESOURCE_ID", 3010
  end

  Concept = Class.new(Resource) do
    const_set "SINGULAR",    :concept
    const_set "PLURAL",      :concepts
    const_set "RESOURCE_ID", 3015
  end

  Franchise = Class.new(Resource) do
    const_set "SINGULAR",    :franchise
    const_set "PLURAL",      :franchises
    const_set "RESOURCE_ID", 3025
  end

  Game = Class.new(Resource) do
    const_set "SINGULAR",    :game
    const_set "PLURAL",      :games
    const_set "RESOURCE_ID", 3030
  end

  Location = Class.new(Resource) do
    const_set "SINGULAR",    :location
    const_set "PLURAL",      :locations
    const_set "RESOURCE_ID", 3035
  end

  Object = Class.new(Resource) do
    const_set "SINGULAR",    :object
    const_set "PLURAL",      :objects
    const_set "RESOURCE_ID", 3055
  end

  Person = Class.new(Resource) do
    const_set "SINGULAR",    :person
    const_set "PLURAL",      :people
    const_set "RESOURCE_ID", 3040
  end

  Video = Class.new(Resource) do
    const_set "SINGULAR",    :video
    const_set "PLURAL",      :videos
    const_set "RESOURCE_ID", 2300
  end

end
