# frozen_string_literal: true

module CoreExtensions
  module Array
    module Clip
      def clip(from_end = 1)
        self[0..-(from_end + 1)]
      end
    end
  end
end
