require './helper'
require 'pry'

class Consumer
  include AMQP
  include Options
  @options = {}

  def initialize
    @options = parse_options
    connect @options[:host], @options[:port], @options[:user], @options[:password]
  end

  def run
    begin
      q = queue @options[:queue]
      file = @options[:file]
      puts "write: #{file}"
      File.open(file, 'a') do |f|
        while true
          q.subscribe do |delivery_info, properties, payload|
            # puts payload
            f.puts payload
          end
          f.flush
        end
      end
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
    end
  end
end

Consumer.new.run