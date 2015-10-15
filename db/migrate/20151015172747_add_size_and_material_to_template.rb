class AddSizeAndMaterialToTemplate < ActiveRecord::Migration
  def change
    add_column :templates, :size, :string
    add_column :templates, :material, :string
  end
end
