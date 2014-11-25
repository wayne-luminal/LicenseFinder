#
#  When creating a new PackageManager, you should implement:
#
#  * package_path
#  * current_packages
#
module LicenseFinder
  class PackageManager
    attr_reader :logger

    def initialize options={}
      @logger       = options[:logger] || LicenseFinder::Logger::Default.new
      @package_path = options[:package_path] # dependency injection for tests
    end

    def active?
      injected_package_path.exist?.tap { |is_active| logger.active self.class, is_active }
    end

    def package_path
      # should return a Pathname pointing to the package config file
      raise NotImplementedError, "#package_path must be implemented"
    end

    def current_packages
      # should return an Array of Packages
      raise NotImplementedError, "#current_packages must be implemented"
    end

    private

    def injected_package_path
      @package_path || package_path
    end
  end
end
