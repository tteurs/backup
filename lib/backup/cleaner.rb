# encoding: utf-8

module Backup
  class Cleaner
    include Backup::CLI::Helpers

    ##
    # Holds an instance of the current Backup model
    attr_accessor :model

    ##
    # Creates a new instance of Backup::Cleaner
    def initialize(model)
      @model = model
    end

    ##
    # Runs the cleaner object which removes all the tmp files generated by Backup
    def clean!
      Logger.message "Backup started cleaning up the temporary files."
      run("#{ utility(:rm) } -rf #{ paths.map { |path| "'#{ path }'" }.join(" ") }")
    end

  private

    ##
    # Returns an Array of paths to temporary files generated by Backup that need to be removed
    def paths
      Array.new([
        File.join(TMP_PATH, TRIGGER),
        Backup::Model.file,
        Backup::Model.chunk_suffixes.map { |chunk_suffix| "#{Backup::Model.file}-#{chunk_suffix}" }
      ]).flatten
    end
  end
end
