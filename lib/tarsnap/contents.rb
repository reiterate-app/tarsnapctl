# frozen_string_literal: true

module Tarsnap
  class Contents
    attr_accessor :tarsnap, :name, :date

    def initialize(tarsnap, name, date)
      @tarsnap = tarsnap
      @name = name
      @date = date || :last
    end

    def run
      archives = tarsnap.get_archives(name)
      archives.sort_by!(&:date)
      archive = if date == :last
                  archives.last
                else
                  archives.find { |a| a.filename.end_with?("#{date}.tar") } or raise "Archive not found"
                end
      tarsnap.list_archive(archive)
    end
  end
end
