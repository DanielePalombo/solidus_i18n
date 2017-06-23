module SolidusI18n
  module LocaleHelper
    def select_available_locales(store = nil)
      select_tag('store[preferred_available_locales][]',
                 options_for_select(
                   all_locales_options,
                   store.preferred_available_locales
                 ), common_options)
    end

    def available_locales_options
      current_store.preferred_available_locales.map { |locale| locale_presentation(locale) }
    end

    # Need to manually add en to the array because the en.yml was moved from
    # this project. solidusio/solidus now has those keys.
    def all_locales_options
      SolidusI18n::Locale.all.map { |locale| locale_presentation(locale) }.push(['English (EN)', :en])
    end

    def available_locales_presentation(store)
      store.preferred_available_locales.map do |locale|
        Spree.t(:'i18n.this_file_language', locale: locale)
      end.join(', ')
    end

    private

    def locale_presentation(locale)
      [Spree.t(:'i18n.this_file_language', locale: locale), locale]
    end

    def common_options
      { class: 'fullwidth', multiple: 'true' }
    end
  end
end
