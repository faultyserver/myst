require "../../ast"

module Myst
  class TFunctor < Value
    property name       : String
    property parameters : AST::ParameterList
    property arity      : Int32
    property body       : AST::Block
    property scope      : Scope

    def initialize(definition : AST::FunctionDefinition)
      @name       = definition.name
      @parameters = definition.parameters
      @arity      = @parameters.children.size
      @body       = definition.body
      @scope      = Scope.new(restrictive: false)

      @scope[definition.name] = self
    end


    def ==(other : TFunctor) : TBoolean
      TBoolean.new(false)
    end

    def !=(other : TFunctor) : TBoolean
      TBoolean.new(true)
    end
  end
end
