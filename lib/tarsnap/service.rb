# frozen_string_literal: true

module Tarsnap
  class Service
    TARSNAP_EXE = "/usr/bin/tarsnap"

    attr_accessor :mock

    def initialize(mock: false)
      @mock = mock
    end

    def create_new(name, archive)
      if mock
        puts "Creating new archive #{name}"
      else
        system "#{TARSNAP_EXE} -cf #{name}.tar @#{archive}"
      end
    end

    def get_archives(name)
      all_archives = `#{TARSNAP_EXE} --list-archives`
      all_archives.split.sort.select { |archive| archive.start_with?(name) }.map { |filename| Archive.new(filename) }
    end

    def delete(archive)
      if mock
        puts "Deleting archive #{archive.filename}"
      else
        system "#{TARSNAP_EXE} -df #{archive.filename}"
      end
    end

    def list_archive(archive)
      system "#{TARSNAP_EXE} -tf #{archive}"
    end
  end
end
