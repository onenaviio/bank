class AppService
  extend Dry::Initializer

  def self.call(*args, &block)
    new(*args).call(&block)
  end

  def self.with_payload_option
    option :payload, ->(value) { value.abs.to_f }
  end
end
