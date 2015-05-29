# Imports images from urls or file uploads.
# Takes a `params` argument and expects it to optionally have two keys:
# :urls - a string where each url is on its own line
# :files - file uploads from a multipart form
class Importer
  attr_reader :entries, :error

  def initialize(params, klass)
    @params, @klass = params, klass
    @entries = []
  end

  def import
    each_url { |url| import_from_url url }
    each_file { |file| import_from_file file }
    hydra.run if @params[:urls].present?
    true
  rescue ActiveRecord::RecordInvalid => e
    @error = e.message
    false
  end

  def success?
    error.nil?
  end

  private

  def each_url(&block)
    @params.fetch(:urls, []).each_line { |i| block.call i.chomp }
  end

  def each_file(&block)
    @params.fetch(:files, []).each &block
  end

  def import_from_url(url)
    request = Typhoeus::Request.new url
    request.on_complete do |response|
      raise ActiveRecord::RecordInvalid unless response.success?
      @entries << @klass.create!(image: StringIO.new(response.body), album_id: @params[:album_id])
    end
    hydra.queue request
  end

  def import_from_file(file)
    @entries << @klass.create!(image: file)
  end

  def hydra
    @hydra ||= Typhoeus::Hydra.new
  end
end