class SearchSettings < RailsSettings::CachedSettings
  SearchSettings.per_page  		||= 48
  SearchSettings.privacy_filter ||= 1
  SearchSettings.safe_search    ||= 1
  SearchSettings.content_type   ||= 7
end
