class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  require 'jp_prefecture'

end
