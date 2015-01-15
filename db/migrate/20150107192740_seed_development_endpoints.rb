class SeedDevelopmentEndpoints < ActiveRecord::Migration
  def change

    Endpoint.create(
      [
        {
          endpointId: "HMS@1CENTRALTRN",
          token: "97166F0A62DB433786385872562D867A",
          brand: "1HOTEL",
          mode: "development",
          interfaceType: "HMS",
          direction: "OUTBOUND",
          url: "https://HMS-central-park.1hotels.com/axis2/services/GuestSelfService",
          username: "CRM@1CENTRAL",
          password: "Para$2014"
        },{
          endpointId: "SHG-WEB",
          token: "C596D483632745DF8506E98AA049FC84",
          mode: "development"
        },{
          endpointId: "NEXMO-SMS",
          token: "543C65DE450E40E89159F3EEEAA92B40",
          brand: "1HOTEL",
          mode: "development",
          direction: "INBOUND"
        }
      ]
    )

  end
end
