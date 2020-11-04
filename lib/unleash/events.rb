module Unleash
  class Events
    attr_accessor :events

    # NOTE: no mutexes for events

    def initialize
      self.events = []
    end

    def to_s
      self.events.to_json
    end

    def record(name, context, type, output = nil)
      self.events << {
        recorded_at: Time.now,
        name: name,
        context: context.user_id,
        type: type,
        output: output
      }
    end

    def reset
      self.events = []
    end
  end
end
