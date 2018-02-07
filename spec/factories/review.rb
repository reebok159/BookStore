FactoryBot.define do
    factory :review do
        book
        text 'My some test text'
        title 'Mike'
        rating 5
    end
end
