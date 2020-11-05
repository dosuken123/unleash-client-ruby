require 'unleash/configuration'
require 'unleash/events'
require 'net/http'
require 'json'
require 'time'

module Unleash
  class EventsReporter
    attr_accessor :last_time

    def initialize
    end

    def send
      Unleash.logger.debug "send() Report"

      data = Unleash.events.to_json
      response = Unleash::Util::Http.post(Unleash.configuration.client_events_url, data)

      if ['200', '202'].include? response.code
        Unleash.logger.debug "Report sent to unleash server sucessfully. Server responded with http code #{response.code}"
      else
        Unleash.logger.error "Error when sending report to unleash server. Server responded with http code #{response.code}."
      end
    ensure
      Unleash.events.reset
    end
  end
end
