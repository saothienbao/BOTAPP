require 'httparty'
require 'json'
require_relative '../../../app/ui/ui'
require_relative 'questionnaire'
require_relative 'show_ui_examples'
require_relative 'chuyen_khoan'
require_relative 'mo_taikhoan'
# Everything in this module will become private methods for Dispatch classes
# and will exist in a shared namespace.
module Commands
  # Mix-in sub-modules for threads
  include Questionnaire
  include ShowUIExamples
  include Chuyen_Khoan
  include MoTaiKhoan

  # State 'module_function' before any method definitions so
  # commands are mixed into Dispatch classes as private methods.
  module_function

  API_URL = 'https://maps.googleapis.com/maps/api/geocode/json?address='.freeze
  REVERSE_API_URL = 'https://maps.googleapis.com/maps/api/geocode/json?latlng='.freeze

  # Lookup based on location data from user's device
  def lookup_location
    if message_contains_location?
      handle_user_location
    else
      say("Vui lòng thử lại và bấm nút 'Send location'")
    end
    stop_thread
  end

  def handle_user_location
    coords = @message.attachments.first['payload']['coordinates']
    lat = coords['lat']
    long = coords['long']
    @message.typing_on
    parsed = get_parsed_response(REVERSE_API_URL, "#{lat},#{long}")
    address = extract_full_address(parsed)
    say "Tọa độ vị trí của Quý khách: Vĩ độ #{lat}, Kinh độ #{long}. " \
        "Quý khách đang tại #{address}"
    @message.typing_off
  end

  # Talk to API
  def get_parsed_response(url, query)
    response = HTTParty.get(url + query)
    parsed = JSON.parse(response.body)
    parsed['status'] != 'ZERO_RESULTS' ? parsed : nil
  end

  def extract_full_address(parsed)
    parsed['results'].first['formatted_address']
  end
end
