class SaveInterface

  def initialize(saver)
    @saver = saver
  end

  def save(fileName)
    return @saver.save(fileName)
  end
end