class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|

      #タイトルカラム・本文カラムを追加
      t.string :title, null:false
      t.string:body, null:false

      t.timestamps null:false
    end
  end
end
