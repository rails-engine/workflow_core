# frozen_string_literal: true

module ScriptEngine
  class << self
    def engine
      @engine ||= ScriptCore::Engine.new Rails.root.join("mruby/bin")
    end

    def eval(string, input: nil, instruction_quota_start: nil, environment_variables: {})
      environment_variables.reverse_merge!("TZ" => Time.zone.name)
      sources = [
        %w[prepare_input prepare_input],
        ["user", string],
        %w[prepare_output prepare_output]
      ]

      engine.eval sources, input: input,
                           instruction_quota_start: instruction_quota_start,
                           environment_variables: environment_variables
    end

    def eval2(string, input: nil, instruction_quota_start: nil, environment_variables: {})
      environment_variables.reverse_merge!("TZ" => Time.zone.name)

      wrapped_string = "Output.value = module Main\n#{string}\nend"
      sources = [
        %w[prepare_input prepare_input],
        ["user", wrapped_string],
        %w[prepare_output prepare_output]
      ]

      engine.eval sources, input: input,
                  instruction_quota_start: instruction_quota_start,
                  environment_variables: environment_variables
    end
  end
end
