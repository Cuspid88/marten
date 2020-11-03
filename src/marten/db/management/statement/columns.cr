module Marten
  module DB
    module Management
      class Statement
        class Columns < Reference
          def initialize(@quote_proc : Proc(String, String), @table : String, @columns : Array(String))
          end

          def rename_table(old_name : String, new_name : String)
            @table = new_name if @table == old_name
          end

          def to_s
            @columns.map { |c| @quote_proc.call(c) }.join(", ")
          end
        end
      end
    end
  end
end