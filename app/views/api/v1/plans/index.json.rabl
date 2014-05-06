collection @plans
attributes :id, :title
node(:title) { |plan| plan.itinerary.winner_pitch.title }
node(:cover) { |plan| plan.pictures.cover.first.source.url }
node(:author) { |plan| { id: plan.user.id, name: plan.user.name, avatar: plan.user.avatar.url(:thumb) }}
