module OlzaApi
  class Client

    attr_accessor :api_user, :api_pwd, :api_url, :language

    def initialize(api_user, api_pwd, api_url, language, test_api = false)
      @api_user = api_user
      @api_pwd = api_pwd
      @api_url = api_url.last == '/' ? api_url[0..-2] : api_url
      @language = language
      @test_api = test_api
    end

    # creates shipment in Olza system.
    def create_shipments(data)
      endpoint_url = "#{@api_url}/createShipments"
      body = data
      RequestMaker.new(@api_user, @api_pwd, @language).
          send_post_request(endpoint_url, body)
    end

    # post shipments created in Olza system into spedition system
    def post_shipments(data)
      endpoint_url = "#{@api_url}/postShipments"
      body = data
      RequestMaker.new(@api_user, @api_pwd, @language).
          send_post_request(endpoint_url, body)
    end

    # returns shipment labels as pdf
    def get_labels(data)
      endpoint_url = "#{@api_url}/getLabels"
      body = data
      RequestMaker.new(@api_user, @api_pwd, @language).
          send_post_request(endpoint_url, body)
    end

    # returns statuses of actual packages
    def get_statuses(data)
      endpoint_url = "#{@api_url}/getStatuses"
      body = data
      RequestMaker.new(@api_user, @api_pwd, @language).
          send_post_request(endpoint_url, body)
    end
  end
end