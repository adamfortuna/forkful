module Forkful
  class Business
    include ActiveModel::Model

    attr_accessor :site, :rating, :name, :address
  end
end
