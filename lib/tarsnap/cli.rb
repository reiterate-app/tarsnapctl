# frozen_string_literal: true

require "thor"
require "date"
require_relative "core_ext"
require_relative "prune"
require_relative "list"
require_relative "contents"

module Tarsnap
  class CLI < Thor
    Array.include CoreExtensions::Array::Clip

    class_option :dry_run, type: :boolean

    desc "snapshot", "Create a new snapshot"
    option :name
    option :archive
    def snapshot
      date_format = DateTime.now.strftime("%Y-%m-%d")
      name = "#{options[:name]}-#{date_format}"
      Service.new(mock: options[:dry_run]).create_new(name, options[:archive])
      puts "Created archive: #{name}.tar"
    end

    desc "prune", "Prune expired backups"
    option :name, required: true
    def prune
      tarsnap = Service.new(mock: options[:dry_run])
      Prune.new(tarsnap, options[:name]).run
    end

    desc "list", "List archives"
    option :name
    def list
      tarsnap = Service.new(mock: options[:dry_run])
      List.new(tarsnap, options[:name]).run
    end

    desc "contents", "List contents of archive"
    option :name, required: true
    option :date
    def contents
      tarsnap = Service.new(mock: options[:dry_run])
      Contents.new(tarsnap, options[:name], options[:date]).run
    end

    def self.exit_on_failure?
      true
    end
  end
end
