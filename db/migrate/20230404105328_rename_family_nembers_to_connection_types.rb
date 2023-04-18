class RenameFamilyNembersToConnectionTypes < ActiveRecord::Migration[7.0]
  def change
    rename_table :family_members, :connection_types
  end
end
