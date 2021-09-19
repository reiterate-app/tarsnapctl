# frozen_string_literal: true

module Tarsnap
  class Archive
    attr_accessor :filename, :name, :date

    def initialize(filename)
      m = filename.match(/(?<name>[[:alpha:]\-]+)-(?<date>[[:digit:]]+-[[:digit:]]+-[[:digit:]]+)/)
      raise "Invalid filename #{filename}" unless m

      @name = m[:name]
      @date = Date.parse(m[:date])
      @filename = filename
    end

    def to_s
      filename
    end

    def age
      Date.today - date
    end
  end
end
