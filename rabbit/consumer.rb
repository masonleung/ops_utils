require './worker'

class Consumer < Worker
  def run
    queue
    begin
      puts "write: #{@file}"
      File.open(@file, 'a') do |f|
        while true
          @q.subscribe do |delivery_info, properties, payload|
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

if __FILE__ == $0
  Consumer.new.run
end
