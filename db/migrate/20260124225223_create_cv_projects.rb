class CreateCvProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :cv_projects do |t|
      t.string :title
      t.text :description
      t.string :url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
