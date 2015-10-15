class ChangeIsPublicDefaultInTemplates < ActiveRecord::Migration
  def change
    change_column_default :templates, :is_public, false
  end
end
