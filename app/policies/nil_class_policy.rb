class NilClassPolicy < ApplicationPolicy
  class NilClassPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        raise Pundit::NotDefinedError, "Cannot scope NilClass"
      end
    end

    def show?
      false # Nobody can see nothing
    end
  end
end
