require 'hashie'

class Seed
  def self.data
    @data = Hashie::Mash.new
    Dir['data/*.yml'].each do |path|
      name = File.basename(path).split('.').first
      @data.assign_property(name, Hashie::Mash.load(path))
    end

    @data
  end
end
