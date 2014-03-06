module OtIntercom
  require 'intercom'

  GLOMAD_TAG = "GLOMAD"

  def authenticate
    Intercom.app_id = "mjcr4qbv"
    Intercom.api_key = "1467594e3a1e5ca57e1481e295dc90d668282680"
  end

  def add_expert(user)
    # authenticate
    # intercom_user = Intercom::User.create(email: user.email, name: user.name)
    #
    # intercom_user.custom_data["website"] = user.website unless user.website.blank?
    #
    # intercom_user.save
    # tag(user.email, GLOMAD_TAG)
    # user.geo_expertise.each do |g|
    #   tag(user.email, g)
    # end
  end

  def tag(email, tag_name)
    # tag = Intercom::Tag.create(name: tag_name, emails: [email], tag_or_untag: "tag")
    # tag.save
  end
end