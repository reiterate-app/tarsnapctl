# frozen_string_literal: true

module Tarsnap
  class Prune
    attr_accessor :tarsnap, :name, :archives

    def initialize(tarsnap, name)
      @tarsnap = tarsnap
      @name = name
    end

    def run
      @archives = tarsnap.get_archives(name)
      expired = expired_weeklies + expired_monthlies
      if expired.empty?
        puts "No archives need to be pruned"
      else
        puts "Expiring archives: #{expired.map(&:filename).join(', ')}"
        expired.each { |a| tarsnap.delete(a) }
      end
    end

    def weekly_archive?(archive)
      archive.age > 7 && archive.age < 60
    end

    def monthly_archive?(archive)
      archive.age >= 60
    end

    # Find archives in the interval specified by time_select,
    # and keep only the latest every time_interval
    # return all other 'expired' archives (in time_select, but closer than time_interval)
    def expired(time_select, time_interval)
      archives.select(&method(time_select))
              .group_by { |a| [a.date.year, a.date.send(time_interval)] }
              .values.map(&:clip).flatten
    end

    def expired_weeklies
      expired(:weekly_archive?, :cweek)
    end

    def expired_monthlies
      expired(:monthly_archive?, :month)
    end
  end
end
