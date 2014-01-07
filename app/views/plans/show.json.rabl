object @plan
attributes :days

child :pictures do
  attributes :id
  node(:thumb) { |picture| picture.source.url(:thumb) }
end