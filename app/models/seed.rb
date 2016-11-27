require 'hashie'

class Seed
  def self.data
    @data = Hashie::Mash.new
    Dir['data/*.yml'].each do |path|
      name = File.basename(path).split('.').first
      # binding.pry if name == 'featured_posts'

      hash = Hashie::Extensions::Parsers::YamlErbParser.perform(path)


      @data.assign_property(name, hash)
    end

    @data
  end
end
