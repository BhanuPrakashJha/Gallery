class Album < ApplicationRecord
    belongs_to :user
    validates :title, presence: true
    validates :body, presence: true
    validates :images, presence: true
    has_many_attached :images
    
    has_many :taggings
    has_many :tags, through: :taggings, dependent: :destroy
    def all_tags=(names)
        self.tags = names.split(",").map do |name|
            Tag.where(tag_name: name.strip).first_or_create!
        end
      end
      
      def all_tags
        self.tags.map(&:tag_name).join(", ")
      end
end