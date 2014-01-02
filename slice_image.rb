#download image as 640x640
#crop the bottom 20 pixels

# extract pixel data to 'data.txt'
#CSV.open('data.txt', 'w') {|csv| cropped.each_pixel {|pixel,c,r| csv << pixel.to_hsla.to_a.first(3)} }  # fourth value is unnecessary: alpha is always 1.0

# run octave algorithms

require 'RMagick'
include Magick
require 'csv'

ImageWidth = 640
ImageHeight = 620
pixels = CSV.read("./mlclass-ex7/idx_16.txt", { :col_sep => "\t" })

(1..16).each do |k|

  img = Image.new(ImageWidth, ImageHeight) {|i| i.background_color = "Transparent"}

  n = 0
  ImageHeight.times do |y|                # Store pixels a row at a time
    ImageWidth.times do |x|               # Build a row of pixels
      if pixels[n][0] == k.to_s
        pixel = Magick::Pixel.from_hsla(pixels[n][1].to_f, pixels[n][2].to_f, pixels[n][3].to_f, 1)
        img.store_pixels(x, y, 1, 1, [pixel])
      end
      n += 1
    end
  end

  img.write("./images/16/#{k}.gif")
end