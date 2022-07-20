class Day < ActiveResource::Base
  include MainFormatApiResponse
  include MainActiveResourceConfig

  belongs_to :event

  def datetime
    DateTime.parse(date) if date?
  end

  def time
    datetime.time_of_day if datetime?
  end

end
