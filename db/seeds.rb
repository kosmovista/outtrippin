admin = User.new(email: "admin@admin.com", password: "password", password_confirmation: "password")
admin.roles = ["admin"]
admin.save

expert = User.new(email: "expert@outtrippin.com", password: "password", password_confirmation: "password")
expert.roles = ["expert"]
expert.save