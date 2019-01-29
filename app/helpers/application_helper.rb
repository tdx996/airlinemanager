module ApplicationHelper

	# execute a block with a different format (ex: an html partial while in an ajax request)
	def with_format(format, &block)
		old_formats = formats
		self.formats = [format]
		block.call
		self.formats = old_formats
		nil
	end
	
end
