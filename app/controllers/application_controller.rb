class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper :layout


  # give the access to helpers (use: helpers.pluralize and so on)
  def helpers
    ActionController::Base.helpers # you can also try  @template.helpers  OR  self.class.helpers  OR  include ActionView::Helpers
  end
end
