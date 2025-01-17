# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `active_decorator` gem.
# Please instead update this file by running `bin/tapioca gem active_decorator`.

# A module that carries the controllers' view_context to decorators.
#
# source://active_decorator//lib/active_decorator/version.rb#3
module ActiveDecorator
  class << self
    # source://active_decorator//lib/active_decorator/config.rb#4
    def config; end

    # @yield [config]
    #
    # source://active_decorator//lib/active_decorator/config.rb#8
    def configure; end
  end
end

# A no-op module to mark an AR model instance as a "decorated" object.
#
# source://active_decorator//lib/active_decorator/decorated.rb#4
module ActiveDecorator::Decorated; end

# source://active_decorator//lib/active_decorator/decorator.rb#8
class ActiveDecorator::Decorator
  include ::Singleton
  extend ::Singleton::SingletonClassMethods

  # @return [Decorator] a new instance of Decorator
  #
  # source://active_decorator//lib/active_decorator/decorator.rb#11
  def initialize; end

  # Decorates the given object.
  # Plus, performs special decoration for the classes below:
  #   Array: decorates its each element
  #   Hash: decorates its each value
  #   AR::Relation: decorates its each record lazily
  #   AR model: decorates its associations on the fly
  #
  # Always returns the object, regardless of whether decorated or not decorated.
  #
  # This method can be publicly called from anywhere by `ActiveDecorator::Decorator.instance.decorate(obj)`.
  #
  # source://active_decorator//lib/active_decorator/decorator.rb#25
  def decorate(obj); end

  # Decorates AR model object's association only when the object was decorated.
  # Returns the association instance.
  #
  # source://active_decorator//lib/active_decorator/decorator.rb#53
  def decorate_association(owner, target); end

  private

  # Decorate with proper monkey patch based on AR version
  #
  # source://active_decorator//lib/active_decorator/decorator.rb#82
  def decorate_relation(obj); end

  # Returns a decorator module for the given class.
  # Returns `nil` if no decorator module was found.
  #
  # source://active_decorator//lib/active_decorator/decorator.rb#60
  def decorator_for(model_class); end

  class << self
    private

    def allocate; end
    def new(*_arg0); end
  end
end

# source://active_decorator//lib/active_decorator/helpers.rb#5
module ActiveDecorator::Helpers
  # source://active_decorator//lib/active_decorator/helpers.rb#6
  def method_missing(method, *args, **_arg2, &block); end
end

# source://active_decorator//lib/active_decorator/railtie.rb#4
class ActiveDecorator::Railtie < ::Rails::Railtie; end

# Override AR::Relation#records to decorate each element after being loaded (for AR 5+)
#
# source://active_decorator//lib/active_decorator/decorator.rb#95
module ActiveDecorator::RelationDecorator
  # source://active_decorator//lib/active_decorator/decorator.rb#96
  def records; end
end

# Override AR::Relation#to_a to decorate each element after being loaded (for AR 3 and 4)
#
# source://active_decorator//lib/active_decorator/decorator.rb#102
module ActiveDecorator::RelationDecoratorLegacy
  # source://active_decorator//lib/active_decorator/decorator.rb#103
  def to_a; end
end

# source://active_decorator//lib/active_decorator/version.rb#4
ActiveDecorator::VERSION = T.let(T.unsafe(nil), String)
