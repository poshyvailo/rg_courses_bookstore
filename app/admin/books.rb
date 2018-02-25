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


  form decorate: true, html: { :multipart => true } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'New Book' do
      f.input :title
      f.input :description
      f.input :price
      f.input :in_stock
      f.input :image, :as => :file
      f.input :height
      f.input :width
      f.input :depth
      f.input :year
      f.input :material
      f.input :category_ids, as: :select, input_html: { multiple: true }, collection: Category.all
      f.input :author_ids, as: :select, input_html: { multiple: true }, collection: Author.all.collect {|author| ["#{author.firstname} #{author.lastname}", author.id] }
    end
    f.actions
  end

end
