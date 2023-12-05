class ChangePackingListToArray < ActiveRecord::Migration[7.1]
  def change
    change_column :journeys, :packing_list, :text, array: true, default: [], using: "(string_to_array(packing_list, ','))"
  end
end
