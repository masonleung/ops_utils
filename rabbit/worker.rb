require 'bunny'
require 'optparse'
require 'pry'

class Worker
  def initialize
    @ch = @q = @x = nil
    @host = 'localhost'
    @port = 5672
    @user = 'guest'
    @password = 'guest'
    @queue = 'clicks_infobright'
    @file = '/mnt/clicks'
    parse_options
    connect
  end

  def connect
    puts "connect: #{@host}:#@port"
    conn = Bunny.new("amqp://#{@user}:#{@password}@#{@host}:#{@port}")
    conn.start
    @ch = conn.create_channel
  end

  def queue 
    puts "queue: #{@queue}"
    if @q.nil?
      @q =  @ch.queue(@queue, :durable => true)
    end
  end

  def exchange
    if @x.nil?
      @x = @ch.default_exchange
    end
  end
  
  def parse_options
    optparse = OptionParser.new do |opts|
      opts.on('--host HOSTNAME', 'queue host, default "localhost"') do |h|
        @host = h
      end

      opts.on('--port PORT', 'queue port, default 5672') do |p|
        @port = p
      end

      opts.on('--user USER', 'username, default "guest"') do |u|
        @user = u
      end

      opts.on('--password PASSWORD', 'password, default "guest"') do |p|
        @password = p
      end

      opts.on('--queue QUEUE NAME', 'queue name') do |q|
        @queue = q
      end

      opts.on('--file FILE', 'file name for consumer, defult "/mnt/clicks"') do |f|
        @file = f
      end

      opts.on('--help', 'help message') do
        puts opts
        exit
      end
    end.parse!
  end
  
  def run
  end
end

