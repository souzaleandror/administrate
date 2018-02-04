require_relative "associative"

module Administrate
  module Field
    class BelongsTo < Associative
      def self.permitted_attribute(attr, _options = nil)
        :"#{attr}_id"
      end

      def permitted_attribute
        foreign_key
      end

      def associated_resource_options
        [nil] + candidate_resources.map do |resource|
          [display_candidate_resource(resource), resource.send(primary_key)]
        end
      end

      def selected_option
        data && data.send(primary_key)
      end

      private

      def candidate_resources
        associated_class.public_send candidate_scope
      end

      def candidate_scope
        options.fetch(:scope, :all)
      end

      def display_candidate_resource(resource)
        associated_dashboard.display_resource(resource)
      end
    end
  end
end
