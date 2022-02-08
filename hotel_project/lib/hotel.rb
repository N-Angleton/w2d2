require_relative "room"

class Hotel

    attr_reader :rooms

    def initialize(name, hash)
        @name = name
        @rooms = {}
        hash.each { |k, v| @rooms[k] = Room.new(v) }
    end

    def name
        words = @name.split.map { |word| word.capitalize }
        words.join(" ")
    end

    def room_exists?(str)
        @rooms.key?(str)
    end

    def check_in(person, room)
        if !room_exists?(room)
            puts "sorry, room does not exist"
        elsif rooms[room].add_occupant(person)
            puts "check in successful"
        else
            puts "sorry, room is full"
        end
    end

    def has_vacancy?
        rooms.values.sum { |room| room.available_space } > 0
    end

    def list_rooms
        rooms.each { |k, v| puts "#{k} #{v.available_space}"}
    end

end
