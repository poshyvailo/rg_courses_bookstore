module Sortable
  extend ActiveSupport::Concern

  module ClassMethods
    def sorting(sorting_params)
      results = self.where(nil)
      sorting_params.each do |key, value|
        results = results.public_send(key, value) if value.present?
      end
      results
    end
  end
end