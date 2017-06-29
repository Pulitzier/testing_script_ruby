require 'curb'
require 'nokogiri'
require 'csv'

def parse_page(uri, page)
	url = Curl.get(uri)
	url.perform

	# File.open(page, 'w') do |f|
	# 	f.puts url.body_str
	# end

	doc = Nokogiri.parse(url.body_str)
	out = doc.xpath("//body//section[@id='center_column']//a[@class='product-name']/@href").to_a

	CSV.open("links.csv", 'w') do |row|
		row << [out.join("\n")]
	end

	CSV.foreach("links.csv", 'r') do |row|
		# product = Curl.get(row)
		# product.perform


	# url = Curl.get('https://www.petsonic.com/hobbit-alf-estrellas-tiernas-salmon-queso-para-perros.html#/unidades-1_unidad_')
	# url.perform

		# doc = Nokogiri.parse(product.body_str)
		# product_w = doc.xpath("//body//section[@id='center_column']//span[@class='attribute_name']/text()")
		# product_p = doc.xpath("//body//section[@id='center_column']//span[@class='attribute_price']/text()")
			
		# out = doc.xpath("//body//section[@id='center_column']//h1/text()")
		# pic = doc.xpath("//body//section[@id='center_column']//img[@id='bigpic']/@src")
		# CSV.open(page, 'a') do |line|
		# 	i = 0
		# 	while i < product_w.length
		# 		line << [out.text.strip + ' - ' + product_w[i].text.strip, product_p[i].text.strip, pic.text.strip]
		# 		i += 1
		# 	end
		# end

	# File.open(page, 'w') do |f|
	# 	f.puts []
	# end

	end

end

parse_page("https://www.petsonic.com/snacks-huesos-para-perros/?controllerUri=category&id_category=896&n=221", "output_info.csv")