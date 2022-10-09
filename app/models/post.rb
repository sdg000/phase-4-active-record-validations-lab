class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, length: {minimum: 250}
    validates :summary, length: {maximum: 250}

    # validating either or
    validates :category, inclusion: {in: %w(Fiction Non-Fiction)}


    # will throw error if any "title" given do not contain phrase 
    # that  match any of the REGEX-ED elements in TOPIC ARRAY

    validate :clickbait?

    # topics = ["Wont't Believe", "Secret", "Top", "Guess"]

    TOPIC = [
        /Won't Believe/i,
        /Secret/i,
        /Top \d/i,
        /Guess/i
    ]


    def clickbait?    
        # go through all elements in array, if "title" DO NOT match any of the elements, add new error to :title
        if !TOPIC.any? {|t| t.match title}
            errors.add(:title, "must be clickbait")
        end
    end
end


