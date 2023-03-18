module Operations::Errors
  extend ActiveSupport::Concern

  class Error < StandardError; end

  class NegativeBalance < Error
    def initialize
      super("Недостаточно средств")
    end
  end

  class WrongCurrency < Error
    def initialize
      super("Неверная валюта")
    end
  end

  class NoCurrencyAccount < Error
    def initialize(currency)
      super("Счета для валюты :#{currency} не существует")
    end
  end
end
