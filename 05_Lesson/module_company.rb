# Модуль Company содержит методы которые могут
# указывать название компании-производителя и получать его.
module Company
  # Принимает в виде параметра название компании и сохраняет его.
  def name_company(name)
    @name_company = name
  end

  # Возвращает название компании.
  def return_company
    @name_company
  end
end
