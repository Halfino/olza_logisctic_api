module OlzaApi
  class RequestMaker

    attr_accessor :api_user, :api_pwd, :api_laguage

    def initialize(api_user, api_pwd, api_language)
      @api_user = api_user
      @api_pwd = api_pwd
      @api_laguage = api_language
    end

    def send_post_request(url, body = nil)
      request = Request.new(:post, url, build_header, body.to_json)
      connection = create_connection(url, request.headers)
      raw_response  = connection.post do |req|
        req.body = request.body
      end

      response.build_response(raw_response)
      if response.valid?
        {
          result: 'success',
          repsonse: response,
          response_status: response.response_code,
          msg: "All packages was accepted by Olza."
        }
      else
        response.parse_errors
        {
            result: 'error',
            response: response,
            response_status: response.response_code,
            errors: response.errors,
            msg: "Response from Olza was not successful."
        }
      end
    end
    private

    # using cs as default language. Uasble are cs and pl case sensitive
    def build_header
      apiLanguage = :api_laguage ? :api_laguage : "cs"
      {
        'apiUser': "#{:api_user}",
        'apiPassword': "#{:api_pwd}",
        'language': "#{apiLanguage}",
        'Content-Type': 'application/json'
      }
    end

    def create_connection(url, header)
      Faraday.new(url: url, headers: header) do |conn|
        conn.request :json
        conn.response :logger
        conn.adapter Faraday.default_adapter
      end
    end

    def build_response(raw_response, ignore_body = false)
      if ignore_body
        Response.new(raw_response.status)
      else
        Response.new(raw_response.status, raw_response.body)
      end
    end


  end
end
