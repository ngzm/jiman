# frozen_string_literal: true

module Auths
  module Error
    class Forbidden < AuthError
      def http_status
        :forbidden
      end
    end
  end
end
