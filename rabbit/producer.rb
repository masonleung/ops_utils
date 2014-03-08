require './worker'

class Producer < Worker
  def run
    exchange
    puts "queue: #{@queue}"
    while true
      now = Time.now.utc.to_s
      puts now
      @x.publish("Hello #{now}", :routing_key => @queue)
      sleep 1
    end
  end
end

Producer.new.run
