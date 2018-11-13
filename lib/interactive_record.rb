require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord

  def self.table_name
    self.to_s.downcase.pluralize
  end

  def self.column_names
    DB[:conn].results_as_hash = true

    sql = "PRAGMA table_info('#{table_name}')"
    table_info = DB[:conn].execute(sql)

    column_names = []
    table_info.each {|row| column_names << row["name"]}
    column_names.compact
  end

  def initialize(options = {})
     options.each do |attr, value|
       self.send("#{attr}=", value)
     end
   end


end
