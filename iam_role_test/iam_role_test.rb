require 'rubygems'
require 'aws-sdk'
require 'pry'

default_bucket = 'str-ops-test'

def test_s3_bucket bucket
    puts "-- write to #{bucket}"
    filename = 'test.message'
    client = Aws::S3::Client.new(region: 'us-east-1')
    s3 = Aws::S3::Resource.new(client: client)
    obj = s3.bucket(bucket).object(filename)
    obj.upload_file(filename)
end

bucket = ARGV[0] || default_bucket
test_s3_bucket default_bucket

