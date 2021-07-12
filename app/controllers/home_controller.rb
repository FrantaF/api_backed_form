require 'json'
require 'httparty'

class HomeController < ApplicationController
  
  def index
  end

  def create_order
   activity_id = Figaro.env.activity_id
   credentials = Figaro.env.credentials
   
   headers = {"Authorization": credentials}

   api_url = "https://api.staging.sopost.dev/v1/activities/#{activity_id}/consents"         
   consents = HTTParty.get(api_url, {"headers": headers})   

   # Validate consent - use the following value from the provided documentation when no consents are obtained.
   # NOTE: THE SAMPLE VALUE FROM DOCUMENTATION IS INVALID AND WITH THE GIVEN DETAILS I WAS NOT ABLE TO OBTAIN ANY CONSENTS
   formatted_consents = [{"consent_id":"02f24b67-ea9c-41b1-b4aa-faab7101a9b8"}]
   
   if(consents.parsed_response)
      consents.parsed_response.each { |consent|             
         formatted_consents.append({"consent_id": consent['id']})
      }   
   end
   
   #Submit order. 
   api_url = "https://api.staging.sopost.dev/v1/orders"

   order_name = params['order']['name']
   order_email = params['order']['email']
   order_address_line_1 = params["order"]["address_line_1"]
   order_address_line_2 = params["order"]["address_line_2"] 
   order_address_town = params["order"]["address_town"]
   order_address_district = params["order"]["address_district"]
   order_address_postcode = params["order"]["address_postcode"]
   
   # Assume the following values
   provider = "ff-integration"
   identity = "ff-98700f04-e705-4547-a3ee-d38a8cc9293d"   
   territory = "GBR"  
   locale = "en_GB"

   # Provided line_items IDs
   line_items = [
      {
         "stock_partition_id": "bf77168f-d4d4-42fd-984f-9dc5bcf5c4d8"
      },
      {
         "stock_partition_id": "b0f3e8a2-763d-4868-8c83-5f4ca0f200d7"
      },
      {
         "stock_partition_id": "2bf42bd5-39ac-4fea-a9ff-cd5270922f14"
      }
   ]

   body = {
      "activity_id": activity_id,
      "address": {
         "line_1": order_address_line_1,
         "line_2": order_address_line_2,
         "town": order_address_town,
         "district": order_address_district,
         "territory": territory,
         "postcode": order_address_postcode
      },
      "full_name": order_name,
      "email": order_email,
      "provider": provider,
      "identity": identity,      
      "line_items": line_items,
      "consents": formatted_consents,      
      "locale": locale
   }.to_json      

   @order = HTTParty.post(api_url, {"headers": headers, "body": body})   

   render template: 'home/confirm_order_submission'
   end
end
