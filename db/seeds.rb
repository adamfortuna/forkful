def create_review_title name
  words = Faker::Hipster.words(rand(4)+1)
  words << name
  words.shuffle.collect(&:capitalize).join(' ')
end

def create_review_description name
  lines = []
  rand(20).times.collect do |index|
    if index != 0
      lines << "## " + Faker::Hipster.sentence(3, false).first(-1)
    end

    lines << Faker::Hipster.paragraph(rand(8), false, 4)
  end

  lines.join("\n\n")
end

def create_random_highlights
  highlights = []
  highlights << :spotlight if rand(10) > 6
  highlights << :feature if rand(10) > 5

  highlights
end

def map_description
  lines = []
  rand(5).times.collect do |index|
    lines << Faker::Hipster.paragraph(rand(4), false, 4)
  end

  lines.join("\n\n")
end

images = Dir[File.join(Rails.root, 'app', 'assets', 'images', 'seeds', '*')]

puts "Users..."
puts "  adam@fortuna.name"
AdminUser.find_or_create_by(email: 'adam@fortuna.name').tap do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.save
end

puts "\n\nSocial Sites..."
Seed.data.social_sites.active.each do |ss|
  puts "  #{ss.name}"
  SocialSite.find_or_create_by(name: ss.name)
end

puts "\n\nLocations..."
Seed.data.locations.active.each do |r|
  Location.find_or_initialize_from_yelp(r).tap do |location|
    location.rating = rand(4) + 1
    puts "  #{location.name}"
    location.save!
  end
end
puts "Currently at #{Location.count} Location"

puts "\n\nReviews..."
Location.all.each_with_index do |location, index|
  next if index % 7 == 0

  if !(review = location.posts.reviews.first)
    review = Review.new
    review.locations << location
  end

  review.title = create_review_title(location.name)
  review.short_title = create_review_title(location.name)
  review.short_description = Faker::Hipster.paragraph(2)
  review.description = create_review_description(location.name)
  review.published_at = rand(100).days.ago

  review.highlights = create_random_highlights

  review.photo = File.open(images.sample) if review.photo.file.nil?

  puts "  #{review.title}"
  review.save!
end


puts "\n\nNews..."
Location.all.each_with_index do |location, index|
  next if index % 7 == 0

  if !(news = location.posts.broadcasts.first)
    news = Broadcast.new
    news.locations << location
  end

  title = "Something About #{location.name}"

  news.title = title
  news.short_title = title
  news.description = Faker::Hipster.paragraph(10)
  news.short_description = Faker::Hipster.paragraph(2)
  news.published_at = rand(100).days.ago

  news.photo = File.open(images.sample) if news.photo.file.nil?

  if (index % 3) == 0
    rand(3).times do
      offset = rand(Location.count)
      news.locations << Location.offset(offset).first
    end
  end

  puts "  #{news.title}"
  news.save!
end


puts "\n\nMaps..."
Seed.data.best.all.each do |title|
  Map.find_or_initialize_by(title: title).tap do |map|
    map.short_title = map.title
    map.description = map_description
    map.short_description = Faker::Hipster.paragraph(2)
    map.published_at = rand(100).days.ago

    map.photo = File.open(images.sample) if map.photo.file.nil?

    count = title.to_i

    loop do
      offset = rand(Location.count)
      location = Location.offset(offset).first
      unless map.locations.include?(location)
        map.locations << location
      end
      break if map.locations.length >= count
    end

    puts "  #{map.title}"
    map.save!
  end
end
