# frozen_string_literal: true

module ScriptEngine
  class << self
    def engine
      @engine ||= ScriptCore::Engine.new Rails.root.join("mruby", "bin")
    end

    def run(string, payload: nil, instruction_quota_start: nil)
      sources = [
        %w[preparing prepare],
        ["user", string],
        %w[packing_output pack_output]
      ]

      engine.eval sources,
                  input: {
                    configuration: {
                      time_zone_offset: Time.zone.formatted_offset(false)
                    },
                    payload: payload
                  },
                  instruction_quota_start: instruction_quota_start,
                  environment_variables: { "TZ" => Time.zone.name }
    end

    def run_inline(string, payload: nil, instruction_quota_start: nil)
      run "Output.value = module Main\n#{string}\nend",
          payload: payload,
          instruction_quota_start: instruction_quota_start
    end
  end
end
