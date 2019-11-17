require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord
  
  def self.table_name 
    "#{to_s.downcase}s" #self is implicit here because scope of function is already self... 
  end
  
  def self.dbc(*args) #because I hate having to type DB[:conn].execute(whatever shows up here EVERY SINGLE TIME!)
    DB[:conn].execute(*args)
  end
  
  def self.column_names
    sql = "pragma table_info('#{table_name}')"
    table_info = dbc(sql)
    table_info.collect {|item| item["name"]}.compact #.compact removes nil from the return
  end
  
  def initialize(the_attributes={})
    the_attributes.each {|property, value| self.send("#{property}=", value)}
  end
  
  def table_name_for_insert
    self.class.table_name
  end
  
  def col_names_for_insert
    self.class.column_name
  end
  
  
  
end #end of the class