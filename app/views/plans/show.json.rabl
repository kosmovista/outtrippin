object @plan
attributes :days, :cover

child :pictures do
  attributes :id
  node(:thumb) { |picture| picture.source.url(:thumb) }
end

