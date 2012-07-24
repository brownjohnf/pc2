class CreateSearches < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.connection.execute <<-SQL
    CREATE VIEW searches AS
      SELECT  pages.id AS searchable_id, pages.title AS term, 
              CAST ('Page' AS varchar) AS searchable_type 
      FROM pages
      UNION 
      SELECT  pages.id AS searchable_id, pages.description AS term, 
              CAST ('Page' AS varchar) AS searchable_type 
      FROM pages
      UNION 
      SELECT  pages.id AS searchable_id, pages.content AS term, 
              CAST ('Page' AS varchar) AS searchable_type 
      FROM pages
      UNION 
      SELECT  case_studies.id AS searchable_id, case_studies.title AS term, 
              CAST ('CaseStudy' AS varchar) AS searchable_type 
      FROM case_studies
      UNION 
      SELECT  case_studies.id AS searchable_id, case_studies.summary AS term, 
              CAST ('CaseStudy' AS varchar) AS searchable_type 
      FROM case_studies
      UNION 
      SELECT  case_studies.id AS searchable_id, case_studies.context AS term, 
              CAST ('CaseStudy' AS varchar) AS searchable_type 
      FROM case_studies
      UNION 
      SELECT  case_studies.id AS searchable_id, case_studies.approach AS term, 
              CAST ('CaseStudy' AS varchar) AS searchable_type 
      FROM case_studies
      UNION 
      SELECT  case_studies.id AS searchable_id, case_studies.results AS term, 
              CAST ('CaseStudy' AS varchar) AS searchable_type 
      FROM case_studies
      UNION 
      SELECT  case_studies.id AS searchable_id, case_studies.challenges AS term, 
              CAST ('CaseStudy' AS varchar) AS searchable_type 
      FROM case_studies
      UNION 
      SELECT  case_studies.id AS searchable_id, case_studies.lessons_learned AS term, 
              CAST ('CaseStudy' AS varchar) AS searchable_type 
      FROM case_studies
      UNION 
      SELECT  case_studies.id AS searchable_id, case_studies.next_steps AS term, 
              CAST ('CaseStudy' AS varchar) AS searchable_type 
      FROM case_studies
      UNION 
      SELECT  documents.id AS searchable_id, documents.name AS term, 
              CAST ('Document' AS varchar) AS searchable_type 
      FROM documents
      UNION 
      SELECT  documents.id AS searchable_id, documents.description AS term, 
              CAST ('Document' AS varchar) AS searchable_type 
      FROM documents
      UNION 
      SELECT  documents.id AS searchable_id, documents.file_file_name AS term, 
              CAST ('Document' AS varchar) AS searchable_type 
      FROM documents
      UNION 
      SELECT  libraries.id AS searchable_id, libraries.name AS term, 
              CAST ('Library' AS varchar) AS searchable_type 
      FROM libraries
      UNION 
      SELECT  libraries.id AS searchable_id, libraries.description AS term, 
              CAST ('Library' AS varchar) AS searchable_type 
      FROM libraries
      UNION 
      SELECT  photos.id AS searchable_id, photos.title AS term, 
              CAST ('Photo' AS varchar) AS searchable_type 
      FROM photos
      UNION 
      SELECT  photos.id AS searchable_id, photos.description AS term, 
              CAST ('Photo' AS varchar) AS searchable_type 
      FROM photos
      UNION 
      SELECT  users.id AS searchable_id, users.name AS term, 
              CAST ('User' AS varchar) AS searchable_type 
      FROM users
      UNION 
      SELECT  users.id AS searchable_id, users.email AS term, 
              CAST ('User' AS varchar) AS searchable_type 
      FROM users
      UNION 
      SELECT  users.id AS searchable_id, users.bio AS term, 
              CAST ('User' AS varchar) AS searchable_type 
      FROM users
      UNION 
      SELECT  volunteers.id AS searchable_id, volunteers.local_name AS term, 
              CAST ('Volunteer' AS varchar) AS searchable_type 
      FROM volunteers
    SQL
  end

  def self.down
    ActiveRecord::Base.connection.execute <<-SQL
      DROP VIEW searches
    SQL
  end
end
