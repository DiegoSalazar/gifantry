class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def set_albums
    @albums = current_user.albums
  end

  def get_entries
    entries = current_user.entries.sorted.page params[:page]

    if params[:tag_name].present?
      entries.tagged_with params[:tag_name]
    elsif params[:search].present?
      entries.search params[:search]
    else
      entries
    end
  end

  def set_entry_view
    @entry_view = cookies[:entry_view] ||= Entry::VIEWS.default
  end

  private
  
  #-> Prelang (user_login:devise)
  def require_user_signed_in
    unless user_signed_in?

      # If the user came from a page, we can send them back.  Otherwise, send
      # them to the root path.
      if request.env['HTTP_REFERER']
        fallback_redirect = :back
      elsif defined?(root_path)
        fallback_redirect = root_path
      else
        fallback_redirect = "/"
      end

      redirect_to fallback_redirect, flash: {error: "You must be signed in to view this page."}
    end
  end

end
