gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

class AirlineSeatTest < Minitest::Test

  #                                           ********
  #                                          *      *
  #                                         *      *
  #      ***********************************      *
  #    *  (  )      () () () () () ()            *
  #  *           *        *                   *
  # *             *        *               *
  #  ************************************
  #                  *       *
  #                   *********
  #
  # Dear Developer,
  #
  #   We closed another round of funding. Woot! I guess we're able to keep the
  #   the two of us around and the lights on for another few weeks before our
  #   next demo to our new masters...er, I mean investors.
  #
  #   We need to model airline seats so we can allow the booking agents to  put
  #   people in them. I started to build something but I wasn't able to finish
  #   everything and I am pretty sure THERE ARE BUGS. I would finish it but
  #   I am heading out to the big "Start Up Week" party.
  #
  #   Oh, yeah would you finish and fix this code for me?
  #
  #                                                 Sincerely,
  #                                                   Minimum Viable Developer
  #
  #   P.S. Aren't these company t-shirts so soft?


  class AirlineSeat
    attr_accessor :taken
    
    def initialize(seat_number, taken = false)
      @seat_number = seat_number
      @taken = taken
    end

    def seat_number
      @seat_number
    end
    
    def taken!
      @taken = true
    end

    def row
      # TODO: I don't think this works for all seats
      get_seat_number
    end

    def get_seat_number
      seat_number[0..-2]
    end

    def position
      seat_number[-1]
    end

    def taken?
      taken ? true : false
    end

    # TODO: I am pretty sure that all our planes are 6 seats wide. So that means
    #   that seats A and F are window seats.
    #
    #
    #                          | A B C || D E F |
    def window?
      false
      true if ["A","F"].include?(position)
    end

    def aisle?
      false
      true if ["C","D"].include?(position)
    end

    def middle_seat?
      false
      true if ["B","E"].include?(position)
    end

    def legroom?
      # TODO: Next version of our seats will definitely have legroom. I promise!
      false
    end
  end

  def test_airline_seat_has_method_seat_number
    assert AirlineSeat.instance_methods.include?(:seat_number)
  end

  def test_airline_seat_has_a_seat_number
    instance = AirlineSeat.new("11A")
    assert_equal "11A", instance.seat_number
  end

  def test_airline_seat_has_method_row
    assert AirlineSeat.instance_methods.include?(:row)
  end

  def test_airline_seat_has_the_correct_row
    instance = AirlineSeat.new("1A")
    assert_equal "1", instance.row

    instance = AirlineSeat.new("10A")
    assert_equal "10", instance.row
  end

  def test_airline_seat_has_method_position
    assert AirlineSeat.instance_methods.include?(:position)
  end

  def test_airline_seat_has_a_position
    instance = AirlineSeat.new("9F")
    assert_equal "F", instance.position
  end

  def test_airline_seat_has_correct_position
    instance = AirlineSeat.new("36C")
    assert_equal "C", instance.position
  end

  def test_airline_seats_on_the_windows_are_window_seats
    instance = AirlineSeat.new("10A")
    assert instance.window?
    refute instance.aisle?
    refute instance.middle_seat?

    instance = AirlineSeat.new("2F")
    assert instance.window?
    refute instance.aisle?
    refute instance.middle_seat?
  end

  def test_airline_seats_on_the_aisles_are_aisle_seats
    instance = AirlineSeat.new("6C")
    assert instance.aisle?
    refute instance.window?
    refute instance.middle_seat?

    instance = AirlineSeat.new("13D")
    assert instance.aisle?
    refute instance.window?
    refute instance.middle_seat?
  end

  def test_airline_seats_in_the_middle_are_middle_seats
    instance = AirlineSeat.new("2B")
    assert instance.middle_seat?
    refute instance.window?
    refute instance.aisle?

    instance = AirlineSeat.new("4E")
    assert instance.middle_seat?
    refute instance.window?
    refute instance.aisle?
  end

  def test_airline_seat_is_not_taken_when_first_created
    instance = AirlineSeat.new("22B")
    refute instance.taken?
  end

  def test_airline_seat_can_be_marked_as_taken
    instance = AirlineSeat.new("12F")
    instance.taken!
    assert instance.taken?
  end

end
