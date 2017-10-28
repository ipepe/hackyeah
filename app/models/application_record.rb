class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  #   acts_as_paranoid

  def self.human_enum_name(enum_name, enum_value)
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{enum_name.to_s.pluralize}.#{enum_value}")
  end

  def human_enum_name(enum_name)
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{enum_name.to_s.pluralize}.#{self[enum_name]}")
  end

  def human_attribute_name(*args)
    self.class.human_attribute_name(*args)
  end

  def self.pluck_to_hash(*keys)
    pluck(*keys).map { |pa| Hash[keys.zip(pa)] }
  end

  class << self
    protected

    def enum_with_string_values(enum_definitions)
      enum_definitions.keys.each do |enum_attribute_name|
        enum_definitions[enum_attribute_name] = enum_definitions[enum_attribute_name].
                                                each_with_object(Hash.new) do |enum_value, hash|
          hash[enum_value] = enum_value.to_s
        end
      end
      enum(enum_definitions)
    end
  end
end
