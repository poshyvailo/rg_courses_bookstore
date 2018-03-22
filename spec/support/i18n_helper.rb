module I18nHelper
  def translate(*args)
    I18n.translate!(*args)
  end

  alias :t :translate
end