module Api::Exception

  class BadRequest    < StandardError; end
  class Unauthorized  < StandardError; end
  class Forbidden     < StandardError; end

  module V1
  end

end