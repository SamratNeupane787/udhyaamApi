class AddColumnsinStartups < ActiveRecord::Migration[7.2]
  def change
    add_column :startups, :tagline, :text
    add_column :startups, :category, :text
    add_column :startups, :logo, :text
    add_column :startups, :websitelink, :text
    add_column :startups, :xlink, :text
    add_column :startups, :linkedin, :text
    add_column :startups, :launchtype, :text
  end
end
