module LicenseFinder
  class GodepPackage < Package
    attr_reader :dep, :sandbox_path

    def initialize(dep, sandbox_path, options={})
      super options
      @dep = dep
      @sandbox_path = sandbox_path
    end

    def license_names_from_spec
      [] # godep spec is pretty meager
    end

    def license_files
      path_pieces = dep["ImportPath"].split(File::SEPARATOR)

      while ! path_pieces.empty? do
        path = File.join(sandbox_path, *path_pieces)
        files = PossibleLicenseFiles.find path, recursive_descent: false
        return files unless files.empty?
        path_pieces.pop
      end

      []
    end

    def children
      [] # no concept of children in godep
    end

    def name
      import_path # the best we can do given the meager godep spec
    end

    def version
      dep["Rev"]
    end

    def summary
      ""
    end

    def description
      ""
    end

    def homepage
      ""
    end

    def groups
      []
    end

    private

    def import_path
      dep["ImportPath"]
    end
  end
end
