extends HBoxContainer

class_name Score

func set_score(num):
	render_digits(num)
	
func render_digits(num):
	for c in get_children():
		remove_child(c)
		c.queue_free()
	if num == 0:
		var rect = TextureRect.new()
		rect.texture = load("res://Assets/fonts/digits/0.png")
		add_child(rect)
	else:
		var digits = []
		var n = num
		while n > 0:
			digits.append(n % 10)
			n = n / 10
		for i in range(len(digits) - 1, -1, -1):
			var rect = TextureRect.new()
			rect.texture = load("res://Assets/fonts/digits/%d.png" % digits[i])
			add_child(rect)
