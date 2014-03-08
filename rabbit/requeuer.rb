require './worker'

class Requeuer < Worker
  def run
    begin
      exchange
      File.open(@file, 'r') do |f|
        while message = f.gets
          @x.publish(message, :routing_key => @queue)
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
