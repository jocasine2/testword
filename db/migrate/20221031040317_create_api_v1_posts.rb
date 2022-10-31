class CreateApiV1Posts < ActiveRecord::Migration[6.1]
  def change
    create_table :api_v1_posts do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
