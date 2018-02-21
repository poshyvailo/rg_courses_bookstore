ActiveAdmin.register Book do

permit_params :title,
              :description,
              :price,
              :in_stock,
              :image,
              :height,
              :width,
              :depth,
              :year,
              :material,
              category_ids: [],
              author_ids: []


  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'New Book' do
      f.input :title
      f.input :description
      f.input :price
      f.input :in_stock
      f.input :image
      f.input :height
      f.input :width
      f.input :depth
      f.input :year, as: :datepicker
      f.input :material
      f.input :category_ids, as: :check_boxes, collection: Category.all
      f.input :author_ids, as: :check_boxes, collection: Author.all
    end
    f.actions
  end

end
