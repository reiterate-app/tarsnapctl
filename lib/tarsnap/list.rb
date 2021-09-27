# frozen_string_literal: true

module Tarsnap
  class List
    attr_accessor :tarsnap, :name

    def initialize(tarsnap, name)
      @tarsnap = tarsnap
      @name = name
    end

    def run
      archives = tarsnap.get_archives(name)
      archives.sort_by!(&:date)
      puts archives.map(&:filename).join("\n")
    end
  end
end
