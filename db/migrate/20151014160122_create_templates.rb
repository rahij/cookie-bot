class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.belongs_to :user, index: true
      t.text :svg_source
      t.text :svg_encoded_str
      t.string :stl_key
      t.string :amf_key
      t.boolean :is_public, default: true
    end
  end
end
