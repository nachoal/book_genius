Geocoder.configure(
  # Geocoding options
  lookup: :google,
  use_https: true,
  api_key: ENV["GOOGLE_API_SERVER_KEY"],
  units: :km,
)