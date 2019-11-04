class ImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :id,
              :description,
              :alt_description,
              :raw_url,
              :full_url,
              :city
end
