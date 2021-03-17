require "./set"

module Marten
  module DB
    module Query
      class RelatedSet(Model) < Set(Model)
        def initialize(@instance : Marten::DB::Model, @related_field_id : String, query : SQL::Query(Model)? = nil)
          @query = if query.nil?
            q = SQL::Query(Model).new
            q.add_query_node(Node.new({@related_field_id => @instance.pk}))
            q
          else
            query.not_nil!
          end
        end

        protected def clone
          cloned = self.class.new(@instance, @related_field_id, @query.clone)
          cloned
        end
      end
    end
  end
end
