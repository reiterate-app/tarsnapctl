# frozen_string_literal: true

require_relative "tarsnap/version"
require_relative "tarsnap/archive"
require_relative "tarsnap/cli"
require_relative "tarsnap/service"

module Tarsnap
  class Error < StandardError; end
end
