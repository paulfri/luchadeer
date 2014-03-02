require 'luchadeer/resource'

module Luchadeer
  class Accessory < Resource
    DETAIL = :accessory
    LIST   = :accessories
    ID     = 3000
  end

  class Character < Resource
    DETAIL = :character
    LIST   = :characters
    ID     = 3005
  end

  class Chat < Resource
    DETAIL = :chat
    LIST   = :chats
    ID     = 2450
  end

  class Company < Resource
    DETAIL = :company
    LIST   = :companies
    ID     = 3010
  end

  class Concept < Resource
    DETAIL = :concept
    LIST   = :concepts
    ID     = 3015
  end

  class Franchise < Resource
    DETAIL  = :franchise
    LIST    = :franchises
    ID      = 3025
  end

  class Game < Resource
    DETAIL  = :game
    LIST    = :games
    ID      = 3030
  end

  class GameRating < Resource
    DETAIL  = :game_rating
    LIST    = :game_ratings
    ID      = 3065
  end

  class Genre < Resource
    DETAIL  = :genre
    LIST    = :genres
    ID      = 3060
  end

  class Location < Resource
    DETAIL  = :location
    LIST    = :locations
    ID      = 3035
  end

  class Object < Resource
    DETAIL  = :object
    LIST    = :objects
    ID      = 3055
  end

  class Person < Resource
    DETAIL  = :person
    LIST    = :people
    ID      = 3040
  end

  class Platform < Resource
    DETAIL  = :platform
    LIST    = :platforms
    ID      = 3045
  end

  class Promo < Resource
    DETAIL  = :promo
    LIST    = :promos
    ID      = 1700
  end

  class RatingBoard < Resource
    DETAIL  = :rating_board
    LIST    = :rating_boards
    ID      = 3070
  end

  class Region < Resource
    DETAIL  = :region
    LIST    = :regions
    ID      = 3075
  end

  class Release < Resource
    DETAIL  = :release
    LIST    = :releases
    ID      = 3050
  end

  class Review < Resource
    DETAIL  = :review
    LIST    = :reviews
    ID      = 1900
  end

  class Theme < Resource
    DETAIL  = :theme
    LIST    = :themes
    ID      = 3032
  end

  class UserReview < Resource
    DETAIL  = :user_review
    LIST    = :user_reviews
    ID      = 2200
  end

  class Video < Resource
    DETAIL  = :video
    LIST    = :videos
    ID      = 2300
  end

  class VideoType < Resource
    DETAIL  = :video_type
    LIST    = :video_types
    ID      = 2320
  end
end
