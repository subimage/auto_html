require File.expand_path('../../unit_test_helper', __FILE__)

class VimeoTest < Minitest::Test

  DIV_START = '<div class="video-container vimeo">'

  def test_transform_url_with_www
    result = auto_html('http://www.vimeo.com/3300155') { vimeo }
    assert_equal %Q|#{DIV_START}<iframe src="//player.vimeo.com/video/3300155?title=0&byline=0&portrait=0" width="440" height="248" frameborder="0"></iframe></div>|, result
  end

  def test_transform_url_without_www
    result = auto_html('http://vimeo.com/3300155') { vimeo }
    assert_equal %Q|#{DIV_START}<iframe src="//player.vimeo.com/video/3300155?title=0&byline=0&portrait=0" width="440" height="248" frameborder="0"></iframe></div>|, result
  end

  def test_transform_url_with_params
    result = auto_html('http://vimeo.com/3300155?pg=embed&sec=') { vimeo }
    assert_equal %Q|#{DIV_START}<iframe src="//player.vimeo.com/video/3300155?title=0&byline=0&portrait=0" width="440" height="248" frameborder="0"></iframe></div>|, result
  end

  def test_transform_url_with_anchor
    result = auto_html('http://vimeo.com/3300155#skirt') { vimeo }
    assert_equal %Q|#{DIV_START}<iframe src="//player.vimeo.com/video/3300155?title=0&byline=0&portrait=0" width="440" height="248" frameborder="0"></iframe></div>|, result
  end

  def test_transform_with_options
    result = auto_html("http://www.vimeo.com/3300155") { vimeo(:width => 300, :height => 250) }
    assert_equal %Q|#{DIV_START}<iframe src="//player.vimeo.com/video/3300155?title=0&byline=0&portrait=0" width="300" height="250" frameborder="0"></iframe></div>|, result
  end

  def test_transform_with_title
    result = auto_html("http://www.vimeo.com/3300155") { vimeo(:width => 300, :height => 250, :show_title => true) }
    assert_equal %Q|#{DIV_START}<iframe src="//player.vimeo.com/video/3300155?byline=0&portrait=0" width="300" height="250" frameborder="0"></iframe></div>|, result
  end

  def test_transform_with_byline
    result = auto_html("http://www.vimeo.com/3300155") { vimeo(:width => 300, :height => 250, :show_byline => true) }
    assert_equal %Q|#{DIV_START}<iframe src="//player.vimeo.com/video/3300155?title=0&portrait=0" width="300" height="250" frameborder="0"></iframe></div>|, result
  end

  def test_transform_with_portrait
    result = auto_html("http://www.vimeo.com/3300155") { vimeo(:width => 300, :height => 250, :show_portrait => true) }
    assert_equal %Q|#{DIV_START}<iframe src="//player.vimeo.com/video/3300155?title=0&byline=0" width="300" height="250" frameborder="0"></iframe></div>|, result
  end
  
  def test_transform_url_with_https
    result = auto_html('https://vimeo.com/3300155') { vimeo }
    assert_equal %Q|#{DIV_START}<iframe src="//player.vimeo.com/video/3300155?title=0&byline=0&portrait=0" width="440" height="248" frameborder="0"></iframe></div>|, result
  end

  def test_prevent_html_transform
    str = '<iframe src="//player.vimeo.com/video/3300155?title=0&byline=0&portrait=0" width="440" height="248" frameborder="0"></iframe>'

    result = auto_html(str) { vimeo }

    assert_equal(
      str, result, 
      "Should not re-transform HTML with Vimeo links inside of it"
    )
  end


end
