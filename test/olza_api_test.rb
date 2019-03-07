require "test_helper"

class OlzaApiTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::OlzaApi::VERSION
  end

  def test_create_shipment_positive
    test_url = "https://test-api.cz"
    test_login = 'api_login'
    test_pwd = 'api_password'
    test_language = 'cs'

    test_data = {
        payload: [
            {
                apiCustomRef: "Test11",
                preset: {
                    senderCountry: "pl",
                    recipientCountry: "pl",
                    speditionCode: "GLS",
                    shipmentType: "DIRECT",
                    senderId: ""
                },
                sender: {
                    senderName: "Name",
                    senderAddress: "Street 2",
                    senderCity: "City",
                    senderZipcode: "12345",
                    senderContactPerson: "Someone",
                    senderEmail: "mail@mail.xx",
                    senderPhone: "+41123456789"
                },
                recipient: {
                    recipientFirstname: "FName",
                    recipientSurname: "Lname",
                    recipientAddress: "Street 1",
                    recipientCity: "City",
                    recipientZipcode: "12345",
                    recipientContactPerson: "company",
                    recipientEmail: "test@test.pl",
                    recipientPhone: "+48123456789",
                    pickupPlaceId: ""
                },
                services: {
                    T12: false,
                    XS: false,
                    S12: true,
                    S10: false,
                    SAT: false,
                    PALLET: false,
                    CSP: false,
                    SM2: "+48123456789",
                    INS: 0
                },

                packages: {
                    packageCount: 1,
                    weight: 1,
                    shipmentDescription: "description"
                },
                specific: {
                    pick: true,
                    shipmentPickupDate: ""
                }
            },
            {
                apiCustomRef: "Test1",
                preset: {
                    senderCountry: "pl",
                    recipientCountry: "pl",
                    speditionCode: "GLS",
                    shipmentType: "WAREHOUSE",
                    senderId: ""
                },
                sender: {
                    senderName: "Name",
                    senderAddress: "Street 2",
                    senderCity: "City",
                    senderZipcode: "12345",
                    senderContactPerson: "Someone",
                    senderEmail: "mail@mail.xx",
                    senderPhone: "+41123456789"
                },
                recipient: {
                    recipientFirstname: "FName",
                    recipientSurname: "Lname",
                    recipientAddress: "Street 1",
                    recipientCity: "City",
                    recipientZipcode: "12345",
                    recipientContactPerson: "company",
                    recipientEmail: "test@test.pl",
                    recipientPhone: "+48123456789",
                    pickupPlaceId: ""
                },
                services: {
                    T12: false,
                    XS: false,
                    S12: true,
                    S10: false,
                    SAT: false,
                    PALLET: false,
                    CSP: false,
                    SM2: "+48123456789",
                    INS: 0
                },

                packages: {
                    packageCount: 1,
                    weight: 1,
                    shipmentDescription: "description"
                },
                specific: {
                    pick: true,
                    shipmentPickupDate: ""
                }
            }
        ]
    }

    stub_request(:post, "https://test-api.cz/createShipments").
        with(
            body: "{\"header\":{\"apiUser\":\"api_login\",\"apiPassword\":\"api_password\",\"language\":\"cs\"},\"payload\":[{\"apiCustomRef\":\"Test11\",\"preset\":{\"senderCountry\":\"pl\",\"recipientCountry\":\"pl\",\"speditionCode\":\"GLS\",\"shipmentType\":\"DIRECT\",\"senderId\":\"\"},\"sender\":{\"senderName\":\"Name\",\"senderAddress\":\"Street 2\",\"senderCity\":\"City\",\"senderZipcode\":\"12345\",\"senderContactPerson\":\"Someone\",\"senderEmail\":\"mail@mail.xx\",\"senderPhone\":\"+41123456789\"},\"recipient\":{\"recipientFirstname\":\"FName\",\"recipientSurname\":\"Lname\",\"recipientAddress\":\"Street 1\",\"recipientCity\":\"City\",\"recipientZipcode\":\"12345\",\"recipientContactPerson\":\"company\",\"recipientEmail\":\"test@test.pl\",\"recipientPhone\":\"+48123456789\",\"pickupPlaceId\":\"\"},\"services\":{\"T12\":false,\"XS\":false,\"S12\":true,\"S10\":false,\"SAT\":false,\"PALLET\":false,\"CSP\":false,\"SM2\":\"+48123456789\",\"INS\":0},\"packages\":{\"packageCount\":1,\"weight\":1,\"shipmentDescription\":\"description\"},\"specific\":{\"pick\":true,\"shipmentPickupDate\":\"\"}},{\"apiCustomRef\":\"Test1\",\"preset\":{\"senderCountry\":\"pl\",\"recipientCountry\":\"pl\",\"speditionCode\":\"GLS\",\"shipmentType\":\"WAREHOUSE\",\"senderId\":\"\"},\"sender\":{\"senderName\":\"Name\",\"senderAddress\":\"Street 2\",\"senderCity\":\"City\",\"senderZipcode\":\"12345\",\"senderContactPerson\":\"Someone\",\"senderEmail\":\"mail@mail.xx\",\"senderPhone\":\"+41123456789\"},\"recipient\":{\"recipientFirstname\":\"FName\",\"recipientSurname\":\"Lname\",\"recipientAddress\":\"Street 1\",\"recipientCity\":\"City\",\"recipientZipcode\":\"12345\",\"recipientContactPerson\":\"company\",\"recipientEmail\":\"test@test.pl\",\"recipientPhone\":\"+48123456789\",\"pickupPlaceId\":\"\"},\"services\":{\"T12\":false,\"XS\":false,\"S12\":true,\"S10\":false,\"SAT\":false,\"PALLET\":false,\"CSP\":false,\"SM2\":\"+48123456789\",\"INS\":0},\"packages\":{\"packageCount\":1,\"weight\":1,\"shipmentDescription\":\"description\"},\"specific\":{\"pick\":true,\"shipmentPickupDate\":\"\"}}]}",
            headers: {
                'Accept' => '*/*',
                'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Content-Type' => 'application/json',
                'User-Agent' => 'Faraday v0.15.4'
            }).
        to_return(status: 200, body: '{"status":{"responseCode": 0, "responseDescription": "Normal"},"response":{"list_processed":{"Test11":{"apiCustomRef": "Test11","shipmentId": 115,"packageIds": [1],"exchangePackageIds":[]}},"list_error":{"Test1":{"apiCustomRef": "Test1","responseCode":900, "responseDescription":"error"}}}}', headers: {})

    client = OlzaApi::Client.new(test_login, test_pwd, test_url, test_language)
    response = client.create_shipments(test_data)

    assert_instance_of OlzaApi::Response, response
    assert_equal(1, response.processed_list.size)
    assert_equal(1, response.error_list.size)
    assert_raises(OlzaApi::PdfDataStreamError) do
      response.get_labels_pdf
    end
  end

  def test_post_shipments_positive
    test_url = "https://test-api.cz"
    test_login = 'api_login'
    test_pwd = 'api_password'
    test_language = 'cs'
    data = {payload: {shipmentList: [123456]}}

    stub_request(:post, "https://test-api.cz/postShipments").
        with(
            body: "{\"header\":{\"apiUser\":\"api_login\",\"apiPassword\":\"api_password\",\"language\":\"cs\"},\"payload\":{\"shipmentList\":[123456]}}",
            headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Content-Type'=>'application/json',
                'User-Agent'=>'Faraday v0.15.4'
            }).
        to_return(status: 200, body: '{"status":{"responseCode": 0, "responseDescription": "Normal"},
                                      "response":{
                                        "list_processed":
                                          {"123456":
                                            {"packageList":
                                              {"1":
                                                {"shipmentId": "123456",
                                                 "packageId": "1",
                                                 "packageType":"normal",
                                                 "speditionExternalId":"0001",
                                                 "speditionExternalBarCode":"0001"}}}}}}', headers: {})

    client = OlzaApi::Client.new(test_login, test_pwd, test_url, test_language)
    response = client.post_shipments(data)

    assert_instance_of OlzaApi::Response, response
    assert_equal(1, response.processed_list.size)
    assert_nil(response.error_list)
    assert_raises(OlzaApi::PdfDataStreamError) do
      response.get_labels_pdf
    end
  end

  def test_get_statuses_positive
    test_url = "https://test-api.cz"
    test_login = 'api_login'
    test_pwd = 'api_password'
    test_language = 'cs'
    data = {payload: {shipmentList: [123456]}}

    stub_request(:post, "https://test-api.cz/getStatuses").
        with(
            body: "{\"header\":{\"apiUser\":\"api_login\",\"apiPassword\":\"api_password\",\"language\":\"cs\"},\"payload\":{\"shipmentList\":[123456]}}",
            headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Content-Type'=>'application/json',
                'User-Agent'=>'Faraday v0.15.4'
            }).
        to_return(status: 200, body: '{"status":{"responseCode": 0, "responseDescription": "Normal"},
                                      "response":{
                                        "list_processed":
                                          {"123456":
                                            {"shipmentStatus": "PROCESSING",
                                             "packageList":
                                              {"1":
                                                {"shipmentId": "123456",
                                                 "packageId": "1",
                                                 "packageStatus":"SENT",
                                                 "speditionExternalId":"0001",
                                                 "speditionExternalBarCode":"0001"}}}}}}', headers: {})

    client = OlzaApi::Client.new(test_login, test_pwd, test_url, test_language)
    response = client.get_statuses(data)

    assert_instance_of OlzaApi::Response, response
    assert_equal(1, response.processed_list.size)
    assert_nil(response.error_list)
    assert_raises(OlzaApi::PdfDataStreamError) do
      response.get_labels_pdf
    end
  end

  def test_get_labels_positive
    test_url = "https://test-api.cz"
    test_login = 'api_login'
    test_pwd = 'api_password'
    test_language = 'cs'
    data = {payload: {shipmentList: [123456], pageFormat:"A6"}}

    stub_request(:post, "https://test-api.cz/getLabels").
        with(
            body: "{\"header\":{\"apiUser\":\"api_login\",\"apiPassword\":\"api_password\",\"language\":\"cs\"},\"payload\":{\"shipmentList\":[123456],\"pageFormat\":\"A6\"}}",
            headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Content-Type'=>'application/json',
                'User-Agent'=>'Faraday v0.15.4'
            }).
        to_return(status: 200, body: '{"status":{"responseCode": 0, "responseDescription": "Normal"},
                                      "response":{
                                        "list_processed":
                                          {"123456":
                                            {"packageList":
                                              {"1":
                                                {"shipmentId": "123456",
                                                 "packageId": "1"}}}},
                                        "data_stream":"SGVsbG8gV29ybGQ="}}', headers: {})

    client = OlzaApi::Client.new(test_login, test_pwd, test_url, test_language)
    response = client.get_labels(data)

    assert_instance_of OlzaApi::Response, response
    assert_equal(1, response.processed_list.size)
    assert_nil(response.error_list)
    assert_instance_of(Tempfile, response.get_labels_pdf)
  end


end
