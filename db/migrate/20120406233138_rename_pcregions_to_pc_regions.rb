class RenamePcregionsToPcRegions < ActiveRecord::Migration
  def change
    rename_table :pcregions, :pc_regions
  end
end
