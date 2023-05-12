class Commissions::Cards::Send < Commissions::Cards::Base
  private

  def commission_field
    "c2c_#{external ? :external : :internal}_to_commission"
  end

  def commission_type
    :c2c
  end
end
