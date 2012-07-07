class ChangeToVeriteOnMoments < ActiveRecord::Migration

  def up
    change_table :moments do |t|
      t.rename :datapoint, :startdate
      t.rename :title, :headline
      t.rename :summary, :text
      t.rename :content, :media
      t.date :enddate
      t.string :caption
      t.string :credit
      t.integer :region_id
      t.integer :site_id
      t.string :years_of_service
      t.string :sector
    end
  end

  def down
    change_table :moments do |t|
      t.rename :startdate, :datapoint
      t.rename :headline, :title
      t.rename :text, :summary
      t.rename :media, :content
    end
    remove_column :moments, :enddate
    remove_column :moments, :caption
    remove_column :moments, :credit
    remove_column :moments, :region_id
    remove_column :moments, :site_id
    remove_column :moments, :years_of_service
    remove_column :moments, :sector
  end

end
