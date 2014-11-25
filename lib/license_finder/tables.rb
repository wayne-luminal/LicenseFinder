require 'sequel'
require LicenseFinder::Platform.sqlite_load_path
require 'logger'

module LicenseFinder
  DB = Sequel.connect(Platform.sqlite_adapter + "://" + config.artifacts.database_uri, :logger => ::Logger.new(STDOUT))

  Sequel.extension :migration, :core_extensions
  Sequel::Migrator.run(DB, ROOT_PATH.join('../db/migrate'))
end
