module ApplicationHelper
  def bootstrap_flash
    content_tag :div, class: "col-sm-12" do
      render "elements/flash"
    end if flash.any?
  end

  def alert_mapping
    @alert_mapping ||= { alert: "warning", notice: "warning", error: "info" }.with_indifferent_access
  end

  def funny_gif_titles
    @funny_gif_titles ||= [
      "A Wild Gif",
      "Sweet Gif, Dude",
      "Now, <i>this</i> is a Nice Gif",
      "It's pronounced \"Gif\", not \"Gif\"!",
      "I don't know what to say, it's so beautiful. <i>Le tear</i>",
      "Never Gonna Gif You Up",
      "You Are The Master Of The Game",
      "It's a Gif and Take Relationship",
      "Oh My Gif"
    ]
  end
end
