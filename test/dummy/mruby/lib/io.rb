class << self
  attr_accessor :stdout_buffer
end

SCRIPT__TOP = self
SCRIPT__TOP.stdout_buffer = ""

module Kernel
  def puts(*args)
    unless args.empty?
      args.each do |arg|
        SCRIPT__TOP.stdout_buffer << arg.to_s
        SCRIPT__TOP.stdout_buffer << "\n"
      end
    else
      SCRIPT__TOP.stdout_buffer << "\n"
    end
  end
end
