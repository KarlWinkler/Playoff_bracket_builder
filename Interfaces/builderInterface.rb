class BuilderInterface

  def initialize(builder)
    @builder = builder
  end

  def build
    return @builder.build
  end
end
