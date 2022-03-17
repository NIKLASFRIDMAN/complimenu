class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :qrcode ]

  def qrcode
    @table = Table.first
  end
end
