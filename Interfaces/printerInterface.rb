class PrinterInterface

  def initialize(printer)
    @printer = printer
  end

  def print
      return @printer.print
  end

  def printf(file)
    return @printer.printf(file)
  end

end