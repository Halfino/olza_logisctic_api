require "test_helper"

class OlzaApiTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::OlzaApi::VERSION
  end

  def test_create_shipment_positive
    WebMock.disable_net_connect!
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
        to_return(status: 200, body: '{"status":{"responseCode": 0, "responseDescription": "Normal"},"response":{"list_processed":{"Test11":{"apiCustomRef": "Test11","shipmentId": 115,"packageIds": [1],"exchangePackageIds":[]}}}}', headers: {})

    client = OlzaApi::Client.new(test_login, test_pwd, test_url, test_language)
    response = client.create_shipments(test_data)

    assert_equal(1, response.processed_list.size)
  end

  # Enables net connection for implementation tests
  WebMock.allow_net_connect!
  #test creates new shipments in Olza test panel based on test data!
  def test_implementation_create_shipment
    test_url = "https://test.panel.olzalogistic.com/api/v1"
    test_login = 'api_mixit'
    test_pwd = 'uKcFxtvmHA2X'
    test_language = 'cs'

    # for better understanding of data format, check olza logistic panel and olza api guides
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
    client = OlzaApi::Client.new(test_login, test_pwd, test_url, test_language)
    response = client.create_shipments(test_data)


    assert_equal 1, response.error_list.size
    assert_instance_of OlzaApi::Response, response
  end

  def test_implementation_get_statuses
    test_url = "https://test.panel.olzalogistic.com/api/v1"
    test_login = 'your test login'
    test_pwd = 'your test password'
    test_language = 'cs'

    data = {payload:{shipmentList:[123456]}}

    client = OlzaApi::Client.new(test_login, test_pwd, test_url, test_language)
    response = client.get_statuses(data)

    assert_instance_of OlzaApi::Response, response
  end

  # this test returns error in response, as test olza logistic panel is not conected to test version of Olza spedition system.
  # to process use production api connection
  def test_implementation_post_shipments
    test_url = "https://test.panel.olzalogistic.com/api/v1"
    test_login = 'your test login'
    test_pwd = 'your test password'
    test_language = 'cs'

    data = {payload: {shipmentList: [123456]}} #use real Shipment ID

    client = OlzaApi::Client.new(test_login, test_pwd, test_url, test_language)
    response = client.post(data)

    assert_instance_of OlzaApi::Response, response
  end

  # same problem as described above. Labels are unable to get as it needs information from Olza spedition system.
  def test_implementation_get_labels
    test_url = "https://test.panel.olzalogistic.com/api/v1"
    test_login = 'your test login'
    test_pwd = 'your test password'
    test_language = 'cs'

    data = {payload: {shipmentList: [123456]}} # use real Shipment ID

    client = OlzaApi::Client.new(test_login, test_pwd, test_url, test_language)
    response = client.get_labels(data)

    assert_instance_of OlzaApi::Response, response
  end

end
