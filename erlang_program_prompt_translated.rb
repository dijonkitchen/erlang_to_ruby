# A Ruby translation of an Erlang program that formats
# a list of people's names and weights in kilograms
# along with the people with the maximum and minimum weights
module RubyProgram
  def format_weight(list_of_objects)
    converted_list = convert_list_to_k(list_of_objects)
    print_weight(converted_list)
    max_min = find_max_and_min(converted_list)
    print_max_and_min(max_min)
  end

  private

  KILOGRAM_FACTOR = 0.45359237

  def convert_list_to_k(list)
    return list if list.empty?
    list.map do |person|
      weight = person[:weight][:amount]
      weight /= KILOGRAM_FACTOR if person[:weight][:unit] == 'l'

      {
        name: person[:name],
        weight: {
          unit: 'k',
          amount: weight
        }
      }
    end
  end

  def print_weight(names_and_kilos)
    names_and_kilos.each do |obj|
      puts "#{obj[:name].ljust(15)} #{obj[:weight][:amount]} kg"
    end
  end

  def find_max_and_min(names_and_kilos)
    max_object = names_and_kilos.first
    min_object = names_and_kilos.first

    names_and_kilos.each do |obj|
      new_amount = obj[:weight][:amount]
      max_object = obj if new_amount > max_object[:weight][:amount]
      min_object = obj if new_amount < min_object[:weight][:amount]
    end

    [max_object, min_object]
  end

  def print_max_and_min(max_min)
    return unless max_min.first && max_min.last
    puts 'Max weight was '\
      "#{max_min.first[:weight][:amount]} kg in "\
      "#{max_min.first[:name]}"
    puts 'Min weight was '\
      "#{max_min.last[:weight][:amount]} kg in "\
      "#{max_min.last[:name]}"
  end
end

# Tests
include RubyProgram

test_people = [
  {
    name: 'Ender',
    weight: {
      unit: 'k',
      amount: 65
    }
  },
  {
    name: 'Peter',
    weight: {
      unit: 'l',
      amount: 342
    }
  },
  {
    name: 'Valentine',
    weight: {
      unit: 'k',
      amount: 50
    }
  }
]

puts RubyProgram.format_weight([])
puts RubyProgram.format_weight(test_people)
