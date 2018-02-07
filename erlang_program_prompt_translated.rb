module RubyProgram
  def format_weight(list_of_objects)
    converted_list = convert_list_to_k(list_of_objects)
    # print_weight(converted_list)
    # min_max = find_max_and_min(converted_list)
    # print_max_and_min(max_object, min_object)
  end

  private

  KILO_CONVERSION = 0.45359237

  def convert_list_to_k(list)
    people_weights_in_kilos = []

    unless list.empty?
      list.map do |person|
        name = person[:name]
        weight = person[:weight][:amount]
        weight /= KILO_CONVERSION if person[:weight][:unit] == 'l'

        people_weights_in_kilos << {
          name: name,
          weight: weight
        }
      end
    end

    people_weights_in_kilos
  end
end

# Tests
include RubyProgram

test_people = [
  {
    name: 'jon',
    weight: {
      unit: 'k',
      amount: 65
    }
  },
  {
    name: 'laksdjf',
    weight: {
      unit: 'l',
      amount: 342
    }
  }
]

puts RubyProgram.format_weight([])
puts RubyProgram.format_weight(test_people)
