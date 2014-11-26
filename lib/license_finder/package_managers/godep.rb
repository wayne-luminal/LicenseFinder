require 'json'

module LicenseFinder
  class Godep < PackageManager
    # see https://github.com/tools/godep#file-format for more info
    def package_path
      Pathname.new('Godeps/Godeps.json')
    end

    def current_packages
      godeps["Deps"].map do |dep|
        GodepPackage.new(dep, sandbox_path, logger: logger).tap do |package|
          logger.package self.class, package
        end
      end
    end

    def sandbox_path
      @sandbox_path ||= File.join(godep_path, "src")
    end

    def godep_path
      `godep path`.chomp
    end

    private

    def godeps
      @godeps ||= JSON.load(package_path)
    end
  end
end
