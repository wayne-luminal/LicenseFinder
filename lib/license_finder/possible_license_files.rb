module LicenseFinder
  class PossibleLicenseFiles
    CANDIDATE_FILE_NAMES = %w(LICENSE License Licence COPYING README Readme ReadMe)
    CANDIDATE_PATH_WILDCARD = "*{#{CANDIDATE_FILE_NAMES.join(',')}}*"

    def self.find(install_path, options={})
      new(install_path, options).find
    end

    def initialize(install_path, options={})
      @install_path = install_path ? Pathname(install_path) : nil
      @recursive_descent = options.key?(:recursive_descent) ? options[:recursive_descent] : true
    end

    def find
      paths_of_candidate_files.map do |path|
        file_at_path(path)
      end
    end

    private

    attr_reader :install_path

    def paths_of_candidate_files
      candidate_files_and_dirs.map do |path|
        path.directory? ? path.children : path
      end.flatten.uniq
    end

    def candidate_files_and_dirs
      return [] if install_path.nil?
      glob = if @recursive_descent
               install_path.join('**', CANDIDATE_PATH_WILDCARD)
             else
               install_path.join(CANDIDATE_PATH_WILDCARD)
             end
      Pathname.glob glob
    end

    def file_at_path(path)
      PossibleLicenseFile.new(install_path, path)
    end
  end
end
