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
        people_weights_in_kilos << {
          name: person.name,
          weight: person.weight / KILO_CONVERSION
        }
      end
    end

    people_weights_in_kilos
  end
end
