module Marten
  module DB
    class ReverseRelation
      @field : Field::Base?

      def initialize(@model : Model.class, @field_id : String)
      end

      # Returns the "on delete" strategy to consider for the considered reverse relation.
      def on_delete : Deletion::Strategy
        field.as?(Field::OneToMany).try(&.on_delete).not_nil!
      end

      # Returns `true` if the reverse relation is associated with a one to many field.
      def one_to_many?
        field.is_a?(Field::OneToMany)
      end

      # Returns `true` if the reverse relation is associated with a one to one field.
      def one_to_one?
        field.is_a?(Field::OneToOne)
      end

      private def field
        @model.get_field(@field_id)
      end
    end
  end
end
