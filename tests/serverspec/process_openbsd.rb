module Specinfra
  module Command
    class Openbsd
      class Base
        # monkey-patch and workaround broken `process` in specinfra
        class Process < Specinfra::Command::Base::Process
          class << self
            def get(process, opts)
              "ps -A -c -o #{opts[:format]},command | grep -E '^\ *[0-9]+\ +#{escape(process)}$' | awk '{print $1}' | head -1"
              # rubocop:enable Metrics/LineLength
            end
          end
        end
      end
    end
  end
end
