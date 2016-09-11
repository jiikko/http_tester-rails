module SugoiHttpTesterRails::HttpMethodModule
  extend ActiveSupport::Concern

  included do
    enum http_method: %i(http_get http_put http_post http_delete http_head)
  end

  HTTP_METHOD_TABLE = {
    'GET'    => 'http_get',
    'PUT'    => 'http_put',
    'POST'   => 'http_post',
    'DELETE' => 'http_delete',
    'HEAD'   => 'http_head',
  }

  def popular_http_method
    HTTP_METHOD_TABLE.find { |k, v| v == http_method }[0]
  end

  def path_with_params
    return path if params.blank?
    "#{path}?#{params}"
  end

  def path=(value)
    return if value.nil?
    if %r!(/.+?)\?(.+)?! =~ value
      self['path'] = $1.try(:scrub, '*').try!(:truncate, 100, omission: '')
      self['params'] = URI.decode($2).scrub('*').try!(:truncate, 100, omission: '')
    else
      self['path'] = value.try(:scrub, '*').try!(:truncate, 100, omission: '')
      self['params'] = nil
    end
  end
end
