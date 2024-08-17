extends Control

Var api_key = "your api key" 

var api_url = "https://uts-ws.nlm.nih.gov/rest/content/current/CUI/C0009044?apiKey="
var url = api_url + api_key
var api_request_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	print ("ready entered")
	$RichTextLabel3.add_text(str(api_request_count))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	print("Button Pressed")
	$Button/HTTPRequest.request(url)
	$ProgressBar.value = 10
	api_request_count += 1
	$RichTextLabel3.clear()
	$RichTextLabel3.add_text("API calls: " + str(api_request_count))


func _on_http_request_request_completed(result, response_code, headers, body):
	print ("request_completed")
	print(response_code)
	
	if response_code == 200:
		print(body.get_string_from_utf8())
		$ProgressBar.value = 90
		$RichTextLabel2.clear()
		$RichTextLabel2.push_color(Color.LAWN_GREEN)
		$RichTextLabel2.append_text("Response body \n")
		$RichTextLabel2.append_text(body.get_string_from_utf8())
		$ProgressBar.value = 100
	
	else:
		print ("Error: Response code: " + str(response_code))
	pass # Replace with function body.
