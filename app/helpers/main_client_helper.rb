module MainClientHelper

  def pub_url(path)
    URI.join(pub_host, path).to_s
  end

  def pub_host
    Settings.pub[:protocol] ||= 'http'
    "#{Settings.pub.protocol}://#{Settings.pub.host}"
  end

end
