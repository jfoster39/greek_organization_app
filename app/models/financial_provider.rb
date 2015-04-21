class FinancialProvider < ActiveRecord::Base
  before_save :format_url

  private

  def format_url
    url = self.external_url
    if url[0,4] != "http"
      self.external_url = "http://#{url}"
    end
    if url[-1, 1] == "/"
      self.external_url = url.chomp("/")
    end
  end
end
