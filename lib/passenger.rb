require_relative 'csv_record'

module RideShare
  class Passenger < CsvRecord
    attr_reader :name, :phone_number, :trips

    def initialize(id:, name:, phone_number:, trips: [])
      super(id)

      @name = name
      @phone_number = phone_number
      @trips = trips
    end

    def add_trip(trip)
      @trips << trip
    end

    def net_expenditures
      raise ArgumentError.new("no trips found for this passenger") if @trips.empty?
      complete_trips = @trips.find_all { |trip| trip.end_time != nil }
      return complete_trips.sum { |trip| trip.cost }
    end

    def total_time_spent
      raise ArgumentError.new("no trips found for this passenger") if @trips.empty?
      complete_trips = @trips.find_all { |trip| trip.end_time != nil }
      return complete_trips.sum { |trip| trip.duration }
    end

    private

    def self.from_csv(record)
      return new(
        id: record[:id],
        name: record[:name],
        phone_number: record[:phone_num]
      )
    end
  end
end
