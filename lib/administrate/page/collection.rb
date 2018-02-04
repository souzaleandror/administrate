require_relative "base"

module Administrate
  module Page
    class Collection < Page::Base
      def attribute_names
        dashboard.collection_attributes
      end

      def attributes_for(resource)
        attribute_names.map do |attr_name|
          attribute_field(dashboard, resource, attr_name, :index)
        end
      end

      def attribute_types
        dashboard.attribute_types_for(attribute_names)
      end      
      
      def filter_names
          dashboard.filter_names
      end

      def index_actions
        dashboard.index_actions
      end

      def index_actions_linea
        dashboard.index_actions_linea
      end

      def ordered_html_class(attr)
        ordered_by?(attr) && order.direction
      end

      delegate :ordered_by?, :order_params_for, to: :order

      private

      def order
        options[:order] || Order.new
      end
    end
  end
end
