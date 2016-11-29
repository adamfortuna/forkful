ActiveAdmin.register Review do
  permit_params :title, :short_title, :description, :short_description, :photo, :photo_src, :photo_src_url, :published_at,
                location_posts_attributes: [:id, :location_id, :rating, :description, :order, :show_order, :_destroy],
                all_highlights: []

  before_filter :only => [:show, :edit, :update, :destroy] do
    @review = Review.friendly.find(params[:id])
  end

  index do
    selectable_column
    column :title
    column :short_description
    column :published_at
    column :locations do |review|
      review.locations.count
    end
    actions
  end

  show do
    @review = Review.friendly.find(params[:id])
    attributes_table do
      row :id
      row :created_at
      row :updated_at
      row :published_at
      row :title
      row :short_title
      row :slug
      row :description
      row :short_description
      row :highlights

      row :photo do
        image_tag(@review.photo.url(:thumb))
      end
      row :photo_src
      row :photo_src_url
    end


    panel "Locations" do
      @review.location_posts.by_order.each do |lm|
        panel lm.location.name do
          attributes_table_for lm do
            row :order
            attributes_table_for lm.location do
              row :description
            end
          end
        end
      end
    end
  end


  form(html: { multipart: true }) do |f|
    f.inputs 'Details' do
      f.input :title
      f.input :short_title
      f.input :description
      f.input :short_description

      f.input :photo, :as => :file
      f.input :photo_src
      f.input :photo_src_url

      f.input :all_highlights, as: :check_boxes, collection: Post::HIGHLIGHTS_MAPPING
      f.input :published_at
    end

    f.has_many :location_posts, heading: 'Locations', sortable: :order, allow_destroy: true, new_record: true do |location_post|
      location_post.inputs :location, :show_order
    end

    f.actions
  end
end
