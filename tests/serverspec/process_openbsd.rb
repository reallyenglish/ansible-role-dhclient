class Specinfra::Command::Openbsd::Base::Process < Specinfra::Command::Base::Process
  class << self
    def get(process, opts)
      "ps -A -c -o #{opts[:format]},command | grep -E '^\ *[0-9]+\ +#{escape(process)}$' | awk '{print $1}' | head -1"
    end
  end
end
