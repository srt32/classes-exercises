gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

class FlightTest < Minitest::Test

  # McDonnell XP-67 "MoonBat"
  #
  #                                            |
  #                                            |
  #                  .''.         .''. `._    _|_    _.' .''.         .''.
  #                   '. '.     .' .'     ~-./ _ \.-~     '. '.     .' .'
  #   ____              '. '._.' .'         /_/_\_\         '. '._.' .'               ____
  #  '.__ ~~~~-----......-'.' '.'`~-.____.-~       ~-..____.-~'.' '.'`-......-----~~~~ __.'
  #      ~~~~----....__//.''._.'.\\\           .           ///.'._.''.\\___....----~~~~
  #                    .' .'__'. '._..__               __.._.' .'__'. '.
  #                  .' .'||    '. '.   ~-.._______..-~   .' .'    ||'. '.
  #                 '.,'  ||-.    ',.'        |_|        '.,'    .-||  ',.'
  #                       \| |                .'.                | |/
  #                        | |                | |                | |
  #                        '.'          jro   '.'                '.'
  #
  # Dear Developer,
  #
  #   The party was great. I met a bunch of awesome companies there and one of
  #   offered me a job. I took it! They have a ping-pong table and have Hawaiian
  #   Shirt Fridays. They are working on a product called CampFlix. It's like
  #   Netflix but for camping. Plus I've been at Planetastic for a WHOLE six
  #   months. It was about time I moved on to a new company.
  #
  #   So I guess this is goodbye. I'll be seeing you. Oh yeah, the CEO asked me
  #   to add flights to our system at the start of the week for Friday's demo.
  #   But now that I don't work for him anymore, I guess it falls on you.
  #
  #                                                 Sincerely,
  #                                                   Minimum Viable Developer
  #
  #   P.S. CampFlix is hiring. I get an iPad if they hire you. Send me your
  #        LinkedIn profile, I'll get you an interview.

  class Flight
    
    attr_reader :seats

    def initialize(plane_model,seats)
      @seats = seats
    end

    def window_seats
      seats.select{|seat| seat.window?}    
    end

    def aisle_seats
      seats.select{|seat| seat.aisle?}
    end

    def middle_seats
      seats.select{|seat| seat.middle_seat?}
    end

    def seat(seat_name)
      seats.find{|seat| seat.seat_number == seat_name}
    end

  end

  def setup
    seat_letters = ["A","B","C","D","E","F"]
    number_rows = 21
    @seats = [] 
    seat_letters.each do |letter|
      number_rows.times.each do |row|
        @seats << AirlineSeat.new("#{row}#{letter}")
      end
    end
  end

  def test_flight_must_be_created_with_seats 
    flight = Flight.new("DC444",@seats)
    assert_equal 126, flight.seats.count
  end

  def test_flight_window_seats_returns_all_the_window_seats
    flight = Flight.new("DC444",@seats)
    assert_equal 42, flight.window_seats.count
  end

  def test_flight_window_seats_returns_all_the_aisle_seats
    flight = Flight.new("HI667",@seats)
    assert_equal 42, flight.aisle_seats.count
  end

  def test_flight_window_seats_returns_all_the_middle_seats
    flight = Flight.new("FR343",@seats)
    assert_equal 42, flight.middle_seats.count
  end

  def test_flight_can_return_the_seat_by_seat_number
   
    seats = []

    seat_01 = AirlineSeat.new("1A")
    seat_02 = AirlineSeat.new("1B")
    seat_03 = AirlineSeat.new("1C")
    seat_04 = AirlineSeat.new("1D")
    seat_05 = AirlineSeat.new("1E")
    seat_06 = AirlineSeat.new("1F")

    seats = [ seat_01, seat_02, seat_03, seat_04, seat_05, seat_06 ]
    
    flight = Flight.new("HI667",seats)
    assert_equal seat_01, flight.seat("1A")
    assert_equal seat_03, flight.seat("1C")
    assert_equal seat_04, flight.seat("1D")
    assert_equal seat_06, flight.seat("1F")
  end


  #
  # The remaining code here is working code that assists with the above tests
  # You shouldn't have to make changes to the code below this point to make
  # the test to pass. However, you will definitely need to read the code
  #

  class AirlineSeat
    def initialize(seat_number)
      @seat_number = seat_number
    end

    def seat_number
      @seat_number
    end

    def row
      seat_number[0..-2]
    end

    def position
      seat_number[-1]
    end

    def window?
      position == "A" || position == "F"
    end

    def aisle?
      position == "C" || position == "D"
    end

    def middle_seat?
      ! window? && ! aisle?
    end

    def taken?
      @taken
    end

    def taken!
      @taken = true
    end

    def legroom?
      # TODO: Next version of our seats will definitely have legroom. I promise!
      false
    end
  end

end
