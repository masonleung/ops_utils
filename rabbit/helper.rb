require 'optparse'
require 'bunny'

module AMQP
  @@q = @@x = @@ch = nil

  def connect host, port, user, password
    puts "connect: #{host}:#{port}"
    conn = Bunny.new("amqp://#{user}:#{password}@#{host}:#{port}")
    conn.start
    @@ch = conn.create_channel
  end

  def queue qname
    puts "queue: #{qname}"
    if @@q.nil?
      @@q =  @@ch.queue(qname, :durable => true)
    end
    @@q
  end

  def exchange
    if @@x.nil?
      @@x = @@ch.default_exchange
    end
    @@x
  end
end

module Options
  def parse_options
    options = {}
    optparse = OptionParser.new do |opts|
      opts.on('--host HOSTNAME', 'queue host, default "localhost"') do |h|
        options[:host] = h || 'localhost'
      end

      opts.on('--port PORT', 'queue port, default 5672') do |p|
        options[:port] = p || 5672
      end

      opts.on('--user USER', 'username, default "guest"') do |u|
        options[:user] = u || 'guest'
      end

      opts.on('--password PASSWORD', 'password, default "guest"') do |p|
        options[:password] = p || 'guest'
      end

      opts.on('--queue QUEUE', 'queue name') do |q|
        options[:queue] = q || 'clicks_infobright'
      end

      opts.on('--file FILE', 'file name for consumer, defult "/mnt/clicks"') do |f|
        options[:file] = f || '/mnt/clicks'
      end

      opts.on('--help', 'help message') do
        puts opts
        exit
      end
    end.parse!
    options
  end
end