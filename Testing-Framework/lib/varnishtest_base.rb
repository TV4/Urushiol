require './lib/vtc'
require './lib/vcl'
require './lib/client_test_base'
require './lib/server'
require './lib/varnish'

module Urushiol
  class VarnishTestBase
    def initialize (name,vcl_file_ref=nil)
      @vtc_obj    = Vtc.new(name)
      @vcl_source = vcl_file_ref
    end

    def mock_varnish(name)
      varnish = Varnish.new(name)
      yield varnish if block_given?
      @vtc_obj.append_config(varnish.varnish_source)
    end

    def mock_backends(source=@vcl_source)
      if source != nil
        @vtc_obj.mock_backends(Vcl.new(source).get_conf)
      else
        puts "\nCan't mock backends if no VCL file is specified.\n"
      end
    end

    def server(&block)
      if block_given?
        @vtc_obj.append_config(yield Server)
      end
    end

    def define_tests(tests)
      @vtc_obj.mock_clients_and_tests(tests)
    end

    def client_testcase(name,config="",&block)
      test = ClientTestBase.new(name,config)
      yield test if block_given?
      @vtc_obj.append_config(test.test_source)
    end

    def mock_server(name,&block)
      server = Server.new(name)
      yield server if block_given?
      @vtc_obj.append_config(server.server_source)
    end

    def create_test_file(vtc)
      File.open('/tmp/test.vtc', "wb") { |f| f.write(vtc.get_spec) }
    end

    def override_vcl_file(vcl_file)
      File.open('/tmp/test.vcl', "wb") { |f| f.write(Vcl.new(vcl_file).get_conf) }
    end

    def get_vcl
      @vcl_source
    end

    def delay(time)
      @vtc_obj.append_config("\ndelay #{time}")
    end

    def run
      create_test_file(@vtc_obj)
      system("varnishtest /tmp/test.vtc")
      cleanup
    end

    def cleanup
      #system("rm /tmp/test.vtc")
    end
  end
end
