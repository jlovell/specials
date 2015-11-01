class SplitSpecialsByType < ActiveRecord::Migration
  def up
    add_column :specials, :type, :string
    add_column :specials, :content, :text

    Special.all.each do |special|
      base_attrs = special.attributes.slice(*%w(restaurant_id day))
      %w(food drink event).each do |type|
        if (content = special.send(type)).present?
          Special.create!(base_attrs.merge(type: type, content: content))
        end
      end
      special.destroy!
    end

    remove_column :specials, :food
    remove_column :specials, :drink
    remove_column :specials, :event
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
