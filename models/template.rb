class Template < ActiveRecord::Base
  validates_presence_of :svg_source, :svg_encoded_str
  belongs_to :user

  def normalize_svg!
    xml_doc  = Nokogiri::XML(svg_source)
    svg_path = xml_doc.xpath('//svg:path', 'svg' => 'http://www.w3.org/2000/svg')
    d_value = svg_path.attr('d').value
    # d_value.sub!("m", "m ")
    # d_value.gsub!(/(.*)(z)(.*)/, '\1 z\3')
    (('a'..'z').to_a + ('A'..'Z').to_a).each do |c|
      d_value.gsub!(c, " #{c} ")
    end
    d_value.squeeze!(" ")
    d_value.strip!
    svg_path.attr('d', d_value)
    self.svg_source = xml_doc.to_xml
  end
end
