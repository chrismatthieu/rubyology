class Podcast < ActiveRecord::Base
  def self.per_page
    3
  end
end
