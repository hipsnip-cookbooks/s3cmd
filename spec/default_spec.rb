require_relative 'spec_helper'


describe "hipsnip-s3cmd::default" do
  context 'with the default attributes' do
    let(:chef_run) do
      ChefSpec::ChefRunner.new(CHEF_RUN_OPTIONS) do |node|
        node.set['s3cmd']['access_key'] = "myaccesskey"
        node.set['s3cmd']['secret_key'] = "mysecretkey"
      end.converge('hipsnip-s3cmd::default')
    end

    before(:each) do
      # Very hacky!
      File.stub(:exists?).and_return(true)
    end

    it { chef_run.should create_file('/root/.s3cfg') }

    it do
      chef_run.should create_file_with_content('/root/.s3cfg', "access_key = myaccesskey")
      chef_run.should create_file_with_content('/root/.s3cfg', "secret_key = mysecretkey")
      chef_run.should create_file_with_content('/root/.s3cfg', "bucket_location = EU")
    end
  end

  context 'with [ "john", "jill" ] as the users' do
    let(:chef_run) do
      ChefSpec::ChefRunner.new(CHEF_RUN_OPTIONS) do |node|
        node.set['s3cmd']['users'] = [ "john", "jill" ]
        node.set['s3cmd']['access_key'] = "myaccesskey"
        node.set['s3cmd']['secret_key'] = "mysecretkey"
      end.converge('hipsnip-s3cmd::default')
    end

    before(:each) do
      # Very hacky!
      File.stub(:exists?).and_return(true)
    end

    it { chef_run.should create_file('/home/john/.s3cfg') }
    it { chef_run.should create_file('/home/jill/.s3cfg') }

    it do
      chef_run.should create_file_with_content('/home/john/.s3cfg', "access_key = myaccesskey")
      chef_run.should create_file_with_content('/home/john/.s3cfg', "secret_key = mysecretkey")
      chef_run.should create_file_with_content('/home/john/.s3cfg', "bucket_location = EU")
    end

    it do
      chef_run.should create_file_with_content('/home/jill/.s3cfg', "access_key = myaccesskey")
      chef_run.should create_file_with_content('/home/jill/.s3cfg', "secret_key = mysecretkey")
      chef_run.should create_file_with_content('/home/jill/.s3cfg', "bucket_location = EU")
    end
  end
end