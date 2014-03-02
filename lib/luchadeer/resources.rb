require 'luchadeer/resource'

# missing resources:
# review, reviews, 1900
# theme, themes, 3032
# user_review, user_reviews, 2200
# video_type, video_types, 2320

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

  Chat = Class.new(Resource) do
    const_set "SINGULAR",    :chat
    const_set "PLURAL",      :chats
    const_set "RESOURCE_ID", 2450
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

  GameRating = Class.new(Resource) do
    const_set "SINGULAR",    :game_rating
    const_set "PLURAL",      :game_ratings
    const_set "RESOURCE_ID", 3065
  end

  Genre = Class.new(Resource) do
    const_set "SINGULAR",    :genre
    const_set "PLURAL",      :genres
    const_set "RESOURCE_ID", 3060
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

  Platform = Class.new(Resource) do
    const_set "SINGULAR",    :platform
    const_set "PLURAL",      :platforms
    const_set "RESOURCE_ID", 3045
  end

  Promo = Class.new(Resource) do
    const_set "SINGULAR",    :promo
    const_set "PLURAL",      :promos
    const_set "RESOURCE_ID", 1700
  end

  RatingBoard = Class.new(Resource) do
    const_set "SINGULAR",    :rating_board
    const_set "PLURAL",      :rating_boards
    const_set "RESOURCE_ID", 3070
  end

  Region = Class.new(Resource) do
    const_set "SINGULAR",    :region
    const_set "PLURAL",      :regions
    const_set "RESOURCE_ID", 3075
  end

  Release = Class.new(Resource) do
    const_set "SINGULAR",    :release
    const_set "PLURAL",      :releases
    const_set "RESOURCE_ID", 3050
  end

  Video = Class.new(Resource) do
    const_set "SINGULAR",    :video
    const_set "PLURAL",      :videos
    const_set "RESOURCE_ID", 2300
  end
end
