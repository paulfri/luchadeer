require 'luchadeer/resource'

module Luchadeer
  class Accessory < Resource
    SINGULAR    = :accessory
    PLURAL      = :accessories
    RESOURCE_ID = 3000
  end

  class Character < Resource
    SINGULAR    = :character
    PLURAL      = :characters
    RESOURCE_ID = 3005
  end

  class Chat < Resource
    SINGULAR    = :chat
    PLURAL      = :chats
    RESOURCE_ID = 2450
  end

  class Company < Resource
    SINGULAR    = :company
    PLURAL      = :companies
    RESOURCE_ID = 3010
  end

  class Concept < Resource
    SINGULAR    = :concept
    PLURAL      = :concepts
    RESOURCE_ID = 3015
  end

  class Franchise < Resource
    SINGULAR    = :franchise
    PLURAL      = :franchises
    RESOURCE_ID = 3025
  end

  class Game < Resource
    SINGULAR    = :game
    PLURAL      = :games
    RESOURCE_ID = 3030
  end

  class GameRating < Resource
    SINGULAR    = :game_rating
    PLURAL      = :game_ratings
    RESOURCE_ID = 3065
  end

  class Genre < Resource
    SINGULAR    = :genre
    PLURAL      = :genres
    RESOURCE_ID = 3060
  end

  class Location < Resource
    SINGULAR    = :location
    PLURAL      = :locations
    RESOURCE_ID = 3035
  end

  class Object < Resource
    SINGULAR    = :object
    PLURAL      = :objects
    RESOURCE_ID = 3055
  end

  class Person < Resource
    SINGULAR    = :person
    PLURAL      = :people
    RESOURCE_ID = 3040
  end

  class Platform < Resource
    SINGULAR    = :platform
    PLURAL      = :platforms
    RESOURCE_ID = 3045
  end

  class Promo < Resource
    SINGULAR    = :promo
    PLURAL      = :promos
    RESOURCE_ID = 1700
  end

  class RatingBoard < Resource
    SINGULAR    = :rating_board
    PLURAL      = :rating_boards
    RESOURCE_ID = 3070
  end

  class Region < Resource
    SINGULAR    = :region
    PLURAL      = :regions
    RESOURCE_ID = 3075
  end

  class Release < Resource
    SINGULAR    = :release
    PLURAL      = :releases
    RESOURCE_ID = 3050
  end

  class Review < Resource
    SINGULAR    = :review
    PLURAL      = :reviews
    RESOURCE_ID = 1900
  end

  class Theme < Resource
    SINGULAR    = :theme
    PLURAL      = :themes
    RESOURCE_ID = 3032
  end

  class UserReview < Resource
    SINGULAR    = :user_review
    PLURAL      = :user_reviews
    RESOURCE_ID = 2200
  end

  class Video < Resource
    SINGULAR    = :video
    PLURAL      = :videos
    RESOURCE_ID = 2300
  end

  class VideoType < Resource
    SINGULAR    = :video_type
    PLURAL      = :video_types
    RESOURCE_ID = 2320
  end
end
