# frozen_string_literal: true

require "thor"
require "date"
require_relative "core_ext"
require_relative "prune"

module Tarsnap
  class CLI < Thor
    Array.include CoreExtensions::Array::Clip

    class_option :dry_run, type: :boolean

    desc "snapshot", "Create a new snapshot"
    option :name
    option :archive
    def snapshot
      date_format = DateTime.now.strftime("%Y-%m-%d")
      Service.new(mock: options[:dry_run]).create_new("#{options[:name]}-#{date_format}", options[:archive])
    end

    desc "prune", "Prune old backups"
    option :name, required: true
    def prune
      tarsnap = Service.new(mock: options[:dry_run])
      Prune.new(tarsnap, options[:name]).run
    end

    def self.exit_on_failure?
      true
    end
  end
end
