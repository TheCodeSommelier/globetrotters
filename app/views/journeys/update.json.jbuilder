index = @journey.packing_list.length - 1

if @journey.persisted?
  json.inserted_item render(partial: "journeys/packing_list_add_item", formats: :html, locals: {packing_item: @packing_item, index: index})
end
