class MessagesController < ApplicationController
  def index
    @tab_color = true #background color for the table
    @messages = Message.all
  end
end
