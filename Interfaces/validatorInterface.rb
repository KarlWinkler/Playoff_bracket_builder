class ValidatorInterface

  def initialize(validator)
    @validator = validator
  end

  def validate(name)
    return @validator.validate(name)
  end
end