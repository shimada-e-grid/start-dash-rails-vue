# frozen_string_literal: true

class Country
  include ActiveModel::Model
  attr_reader :number, :name

  def all
    ISO3166::Country.all.map do |country|
      hash = ActiveSupport::OrderedOptions.new
      hash.number = country.number.to_i
      hash.name = country.name
      hash
    end
  end

  def find_by_number(number)
    hash = ActiveSupport::OrderedOptions.new
    country = ISO3166::Country.find_country_by_number(number)
    raise ActiveRecord::RecordNotFound, { messages: "Couldn't find Country with 'number'=#{number}" } if country.nil?

    hash.number = country.number.to_i
    hash.name = country.name
    hash
  end
end
