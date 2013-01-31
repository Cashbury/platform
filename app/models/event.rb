class Event < ActiveRecord::Base
  serialize :dispatcher
  serialize :receiver
  serialize :payload
end