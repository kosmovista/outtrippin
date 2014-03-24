object @plan
attributes :days, :tips_tricks, :cover, :bookings

child :pictures do
  attributes :id
  node(:thumb) { |picture| picture.source.url(:thumb) }
end

