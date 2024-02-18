# typed: strict
# frozen_string_literal: true

module FactoryBot
  class << self
    sig { params(block: T.proc.bind(FactoryBot::Syntax::Default::DSL).void).void }
    def define(&block); end
  end

  class Syntax::Default::DSL
    sig { params(name: T.any(String, Symbol), options: T.untyped, block: T.proc.bind(T.untyped).void).void }
    def factory(name, options = T.unsafe(nil), &block); end
  end
end
