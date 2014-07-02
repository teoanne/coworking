module ApplicationHelper

  def display_datetime(dt)
    dt.strftime("%d/%m/%Y %l:%M%P %Z")
  end
end
