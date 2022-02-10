class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'

    @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=53949&distance=100&API_KEY=D1884030-9770-4E05-8227-B157CE7B389A'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)  
    @output = JSON.parse(@response)

    # Check for empty return value
    if !@output or @output.empty?
      @final_output = "No data available"
    else
      @final_output = @output[0]['AQI']
    end

    if @final_output == "Error"
      @api_color = "gray"
    elsif @final_output < 50
      @api_color = "green"
      @api_message = "Air quality is Good. Enjoy your outdoor activities."
    elsif @final_output < 100
      @api_color = "yellow"
      @api_message = "Air quality is Moderate. If you are unusually sensitive to particle pollution, consider reducing your activity level or shorten the amount of time you are active outdoors."
    elsif @final_output < 150
      @api_color = "orange"
      @api_message = "Air quality is Unhealthy for Sensitive Groups. People with heart or lung disease, older adults, children and teens should take steps to reduce your exposure. Everyone else: Enjoy your outdoor activities."
    elsif @final_output < 200
      @api_color = "red"
      @api_message = "Air quality is Unhealthy. Everyone take steps to reduce your exposure"
    elsif @final_output < 300
      @api_color = "purple"
      @api_message = "Air quality is Very Unhealthy"
    elsif @final_output < 500
      @api_color = "maroon"
      @api_message = "Air quality is Hazardous"
    else
      @api_color = ""
      @api_message = "Air quality is Beyond the Possible Scale!"
    end
  end

  def zipcode
    @zip_query = params[:zipcode]
    
    if params[:zipcode] == ""
      @zip_query = "You need a zipcode ;-)"
    elsif params[:zipcode]
    end

  end

end
