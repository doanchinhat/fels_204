class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  version :medium  do
    process resize_to_fill: [100, 100]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url *arg
    "http://z4.ifrm.com/30611/86/0/f5088447/icon-user-default.png"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
