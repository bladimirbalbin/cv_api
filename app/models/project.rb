class Project < ApplicationRecord
  self.table_name = 'cv_projects'
  belongs_to :user
end
