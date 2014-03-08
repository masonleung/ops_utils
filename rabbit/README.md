# Queue utilities
Produce, consume, and requeue messages

## Setup

    sudo apt-get install rubygems
    sudo gem install bundler
    bundle install

## Help

    ruby producer.rb --help

## Producer
Create test messages to fill up a queue

    # produce messages
    ruby producer.rb --host localhost --port 5672 --user guest --password guest --queue qname

## Consumer

    # consume and save messages to file
    ruby consumer.rb --host localhost --port 5672 --user guest --password guest --queue qname --file /tmp/clicks.log

## Requeuer

    # requeue messages
    ruby requeuer.rb --host localhost --port 5672 --user guest --password guest --queue qname --file /tmp/clicks.log
