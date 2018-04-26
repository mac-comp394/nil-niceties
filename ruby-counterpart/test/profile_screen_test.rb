require_relative "test_helper"

describe "Todo list" do

  let(:theme0) do
    Style.new(
      background_color: nil,
      foreground_color: :fulvous)
  end

  let(:theme1) do
    Style.new(
      background_color: :fuchsia,
      foreground_color: :smaragdine)
  end

  let(:theme2) do
    Style.new(
      background_color: :mauve,
      foreground_color: :wenge)
  end

  def profileScreen(avatarStyle:, app_theme:)
    avatar = if avatarStyle
      StyledImage.new(image: Image.new, style: avatarStyle)
    end
    
    ProfileScreen.new(
      user: User.new(name: "Sally Jones", avatar: avatar),
      app_theme: app_theme)
  end


  it "works when avatar has a background color" do
    assert_equal(
      :mauve,
      profileScreen(avatarStyle: theme2, app_theme: theme1)
        .header_background_color)
  end

  it "works when avatar has no background color" do
    assert_equal(
      :fuchsia,
      profileScreen(avatarStyle: theme0, app_theme: theme1)
        .header_background_color)
  end

  it "works when avatar and app theme both have no background color" do
    assert_nil(
      profileScreen(avatarStyle: theme0, app_theme: theme0)
        .header_background_color)
  end

  it "works when no avatar" do
    assert_equal(
      :mauve,
      profileScreen(avatarStyle: nil, app_theme: theme2)
        .header_background_color)
  end

  it "works when no styles at all" do
    assert_nil(
      profileScreen(avatarStyle: nil, app_theme: theme0)
        .header_background_color)
  end

end
