require './helper'

class Producer
  include AMQP
  include Options
  @options = {}

  def initialize
    @options = parse_options
    connect @options[:host], @options[:port], @options[:user], @options[:password]
  end

  def run
    x = exchange
    qname = @options[:queue]
    puts "queue: #{qname}"
    while true
      now = Time.now.utc.to_s
      puts now
      x.publish("Hello #{now}", :routing_key => qname)
      sleep 1
    end
  end
end

Producer.new.run