module MyArrayEnumerableBehaviorTestSetup
  MyArrayOfStrings = -> { strings = MyArray.new; strings << "a"; strings << "ab"; strings << "abc"; strings }.call

  def set_up_tests_for_my_array_of_strings
    #When I call my_select, pass this block and expect this result ...
    let(:select_block) { ->(string) { string.length < 3 } }
    let(:expected_select_result) { ["a", "ab"] }

    #When I call my_reject, pass this block and expect this result ...
    let(:reject_block) { ->(string) { string.length < 3 } }
    let(:expected_reject_result) { ["abc"] }

    #When I call my_find, pass this block and expect this result ...
    let(:found_find_block) { ->(string) { string =~ /ab/ } }
    let(:not_found_find_block) { ->(string) { string.empty? } }
    let(:expected_find_result) { "ab" }

    #When I call my_map, pass this block and expect this result ...
    let(:map_block) { ->(string) { string[0] } }
    let(:expected_map_result) { ["a", "a", "a"] }

    #When I call my_all?, pass these blocks.  The results will be truthy or falsey.
    let(:yes_all_block) { ->(string) { string.length < 10 } }
    let(:no_not_all_block) { ->(string) { string.length < 3 } }
    let(:truthy_yes_all_block) { ->(string) { "a truthy value" } }
    let(:falsey_no_not_all_block) { ->(string) { nil } }

    #When I call my_reduce, this blocks with these arguments and  and expect these results ...
    let(:reduce_block) { -> (aggregate, string) { aggregate + string } }
    let(:reduce_method) { :+ }
    let(:reduce_starting_aggregate) { "ZZZ" }
    let(:expected_reduce_result_with_no_starting_aggregate) { "aababc" }
    let(:expected_reduce_result_with_starting_aggregate) { "ZZZaababc" }
  end


  MyArrayOfNumbers = -> { numbers = MyArray.new; numbers << 1; numbers << 2; numbers << 3; numbers }.call

  def set_up_tests_for_my_array_of_numbers
    let(:select_block) { ->(number) { number < 3 } }
    let(:expected_select_result) { [2, 1] }

    let(:reject_block) { ->(number) { number < 3 } }
    let(:expected_reject_result) { [3] }

    let(:found_find_block) { ->(number) { number > 1 } }
    let(:not_found_find_block) { ->(number) { number.zero? } }
    let(:expected_find_result) { 2 }

    let(:map_block) { ->(number) { number - number } }
    let(:expected_map_result) { [0, 0, 0] }

    let(:yes_all_block) { ->(number) { number < 10 } }
    let(:no_not_all_block) { ->(number) { number < 3 } }
    let(:truthy_yes_all_block) { ->(number) { "not a boolean, but still truthy" } }
    let(:falsey_no_not_all_block) { ->(number) { nil } }

    let(:reduce_block) { ->(aggregate, number) { aggregate * number } }
    let(:reduce_method) { :* }
    let(:reduce_starting_aggregate) { 100 }
    let(:expected_reduce_result_with_no_starting_aggregate) { 6 }
    let(:expected_reduce_result_with_starting_aggregate) { 600 }
  end
end
