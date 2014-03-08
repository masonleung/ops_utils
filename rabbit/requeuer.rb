require './helper'

class Requeuer
  include AMQP
  include Options
  @options = {}

  def initialize
    @options = parse_options
    connect @options[:host], @options[:port], @options[:user], @options[:password]
  end

  def run
    begin
      q = @options[:queue]
      x = exchange
      file = @options[:file]
      File.open(file, 'r') do |f|
        while message = f.gets
          puts message
          x.publish(message, :routing_key => q)
        end
        f.close
      end
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
    end
  end
end

Requeuer.new.run